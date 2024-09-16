% inputs video (3-D uint8 array), outputs calibration frame (2-D array)
function calibration_frame = calibrate(original)

    % initialize variables
    [length, width, num_frames] = size(original);

    % sort 3-D array in ascending order w/ respect to time
    sorted_video = zeros(length, width, num_frames, 'uint8');
    for i = 1:length
        for j = 1:width
            sorted_video(i, j, :) = sort(original(i, j, :));
        end
    end

    % return frame w/ avg. of top 80% of values
    calibration_frame = zeros(length, width, 'uint8');
    for i = 1:length
        for j = 1:width
            calibration_frame(i, j) = mean(sorted_video(i, j, uint16(0.2*num_frames):end));
        end
    end
end