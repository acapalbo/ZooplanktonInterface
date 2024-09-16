% takes binary video, expands objects by a certain distance on each side
function expanded = domain_expansion(original, distance)

    % initialize variables
    [length, width, num_frames] = size(original);
    expanded = zeros(length, width, num_frames, 'logical');

    % expand objects in each frame individually
    for i = 1:length
        if (i-distance) < 1
            min_length = 1;
            max_length = i+distance;
        elseif (i+distance) > length
            min_length = i-distance;
            max_length = 1;
        else
            min_length = i-distance;
            max_length = i+distance;
        end
        for j = 1:width
            if (j-distance) < 1
                min_width = 1;
                max_width = j+distance;
            elseif (j+distance) > width
                min_width = j-distance;
                max_width = 1;
            else
                min_width = j-distance;
                max_width = j+distance;
            end
            for k = 1:num_frames
                if original(i, j, k) == 1
                    expanded(min_length:max_length, min_width:max_width, k) = 1;
                end
            end

        end
        %fprintf("%d, ", i);
    end
    %fprintf("\n");

end