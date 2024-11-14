% inputs video (3-D uint8 array), calibration frame (2-D uint8 array),
% brightness (usually 0.80-1.20), outputs flat-fielded video (3-D uint8 array)

% pixel-wise dynamic flatfielding (decently fast); when the background of 
% the video shifts, it shifts the calibration frame accordingly
function flatfielded_video = dynamic_flatfield(original, calibration_frame, brightness)

    % initialize variables (up = 1, down = 2, left = 3, right = 4, normal = 5)
    [length, width, num_frames] = size(original);   % stores video specs
    flatfielded_video = zeros(length, width, num_frames, 'uint8');   % stores updated frames

    % find average pixel value for each frame
    average_values = mean(mean(original));

    % generate flatfielded video
    for k = 1:num_frames

        % initialize more variables (up = 1, down = 2, left = 3, right = 4, normal = 5)
        offset_values = zeros(4, 1, 'uint16');   % stores current calibration frame offset information
        boolean_values = [true, true, true, true];   % stores on/off values for up/down/left/right
        finished = false;   % stores whether or not improvements can still be made

        % for each frame, while improvements can be made...
        while ~finished

            % initialize EVEN MORE variables
            improvement_scores = zeros(5, 1, 'double');   % stores "improvement scores" for up/down/left/right/normal
            number_of_pixels = zeros(5, 1, 'double');   % stores number of pixels that involve both images

            % ...update the "center" flatfield...
            % ...and find the mean square difference
            for i = (1+offset_values(2)):(length-offset_values(1))
                for j = (1+offset_values(4)):(width-offset_values(3))
                    flatfielded_video(i, j, k) = uint8((uint16(original(i, j, k)) * uint16(average_values(1, 1, k) * brightness)) / uint16(calibration_frame(i + offset_values(1) - offset_values(2), j + offset_values(3) - offset_values(4))));
                    improvement_scores(5) = improvement_scores(5) + ((double(original(i, j, k)) - double(calibration_frame(i + offset_values(1) - offset_values(2), j + offset_values(3) - offset_values(4))))^2);
                    number_of_pixels(5) = number_of_pixels(5) + 1;
                end
            end
            improvement_scores(5) = improvement_scores(5) / number_of_pixels(5);
            % fprintf("mean square diff. for normal frame: %u\n", improvement_scores(5));

            % then, generate similar "improvement scores" for each shift
            if (boolean_values(1))
                for i = (1+offset_values(2)):(length-offset_values(1)-1)
                    for j = (1+offset_values(4)):(width-offset_values(3))
                        improvement_scores(1) = improvement_scores(1) + ((double(original(i, j, k)) - double(calibration_frame(i + offset_values(1) + 1 - offset_values(2), j + offset_values(3) - offset_values(4))))^2);
                        number_of_pixels(1) = number_of_pixels(1) + 1;
                    end
                end
                improvement_scores(1) = improvement_scores(1) / number_of_pixels(1);
                % fprintf("mean square diff. for up-shifted frame: %u\n", improvement_scores(1));
            end
            
            if (boolean_values(2))
                for i = (1+offset_values(2)+1):(length-offset_values(1))
                    for j = (1+offset_values(4)):(width-offset_values(3))
                        improvement_scores(2) = improvement_scores(2) + ((double(original(i, j, k)) - double(calibration_frame(i + offset_values(1) - offset_values(2) - 1, j + offset_values(3) - offset_values(4))))^2);
                        number_of_pixels(2) = number_of_pixels(2) + 1;
                    end
                end
                improvement_scores(2) = improvement_scores(2) / number_of_pixels(2);
                % fprintf("mean square diff. for down-shifted frame: %u\n", improvement_scores(2));
            end
            
            if (boolean_values(3))
                for i = (1+offset_values(2)):(length-offset_values(1))
                    for j = (1+offset_values(4)):(width-offset_values(3)-1)
                        improvement_scores(3) = improvement_scores(3) + ((double(original(i, j, k)) - double(calibration_frame(i + offset_values(1) - offset_values(2), j + offset_values(3) + 1 - offset_values(4))))^2);
                        number_of_pixels(3) = number_of_pixels(3) + 1;
                    end
                end
                improvement_scores(3) = improvement_scores(3) / number_of_pixels(3);
                % fprintf("mean square diff. for left-shifted frame: %u\n", improvement_scores(3));
            end
            
            if (boolean_values(4))
                for i = (1+offset_values(2)):(length-offset_values(1))
                    for j = (1+offset_values(4)+1):(width-offset_values(3))
                        improvement_scores(4) = improvement_scores(4) + ((double(original(i, j, k)) - double(calibration_frame(i + offset_values(1) - offset_values(2), j + offset_values(3) - offset_values(4) - 1)))^2);
                        number_of_pixels(4) = number_of_pixels(4) + 1;
                    end
                end
                improvement_scores(4) = improvement_scores(4) / number_of_pixels(4);
                % fprintf("mean square diff. for right-shifted frame: %u\n", improvement_scores(4));
            end
            
            % update the center frame to move in the direction that
            % improved the image the most; otherwise, don't change it
            [~, best_direction] = min(improvement_scores); % stores direction with the best "improvement score"
            if (boolean_values(1) && best_direction == 1)
                offset_values(1) = offset_values(1) + 1;
                % fprintf("Going up!\n");
            elseif (boolean_values(2) && best_direction == 2)
                offset_values(2) = offset_values(2) + 1;
                % fprintf("Going down!\n");
            elseif (boolean_values(3) && best_direction == 3)
                offset_values(3) = offset_values(3) + 1;
                % fprintf("Going left!\n");
            elseif (boolean_values(4) && best_direction == 4)
                offset_values(4) = offset_values(4) + 1;
                % fprintf("Going right!\n");
            else
                finished = true;
                % fprintf("Finished!\n");
            end

            % "turn off" any shift that didn't improve the image
            if (improvement_scores(1) > improvement_scores(5))
                boolean_values(1) = false;
            end
            if (improvement_scores(2) > improvement_scores(5))
                boolean_values(2) = false;
            end
            if (improvement_scores(3) > improvement_scores(5))
                boolean_values(3) = false;
            end
            if (improvement_scores(4) > improvement_scores(5))
                boolean_values(4) = false;
            end

        end

        % fprintf("%d, ", k);

    end

    % fprintf("\n");

end