% takes binary video, expands objects by a certain distance on each side
function expanded = domain_expansionV2(original, distance)

    % initialize variables
    [length, width, num_frames] = size(original);
    expanded = zeros(length, width, num_frames, 'logical');

    % expand objects in each frame individually
    for i = 1:length
        for j = 1:width
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