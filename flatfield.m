% inputs video (3-D uint8 array), calibration frame (2-D uint8 array), &
% brightness (usually 0.80-1.20), outputs flat-fielded video (3-D uint8 array)

% static, raw flatfielding (very fast)
function flatfielded_video = flatfield(original, calibration_frame, brightness)

    % initialize variables
    [length, width, num_frames] = size(original);

    % find average pixel value for each frame
    average_values = mean(mean(original));

    % generate flatfielded video
    flatfielded_video = zeros(length, width, num_frames, 'uint8');
    for k = 1:num_frames
        for i = 1:length
            for j = 1:width
        flatfielded_video(i,j,k) = uint8((uint16(original(i,j,k))*uint16(average_values(1, 1, k) * brightness)) / uint16(calibration_frame(i,j)));
            end
        end
    end
end