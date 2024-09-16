% inputs video (3-D uint8 array), calibration frame (2-D uint8 array), &
% brightness (usually 0.80-1.20), outputs flat-fielded video (3-D uint8 array)

% sub-pixel gradient flatfielding (VERY slow); does the same thing as the
% dynamic flatfielding program, but the calibration frame can be moved to a
% decimal position (e.g. 2.3 pixels right, 0.4 pixels up)
function flatfielded_video = precise_flatfield(original, calibration_frame, brightness)

    % initialize variables
    [length, width, num_frames] = size(original);

    % find average pixel value for each frame
    average_values = mean(mean(original));

    % prepare monomodal optimizer and metric
    [optimizer, metric] = imregconfig('monomodal');
    optimizer.MinimumStepLength = 0.1;
    optimizer.MaximumStepLength = 0.5;

    % generate flatfielded video
    flatfielded_video = zeros(length, width, num_frames, 'uint8');
    for k = 1:num_frames
        calibration_shift = imregister(calibration_frame, original(:, :, k), "translation", optimizer, metric);
        for i = 1:length
            for j = 1:width
                flatfielded_video(i, j, k) = uint8((uint16(original(i, j, k)) * uint16(average_values(1, 1, k) * brightness)) / uint16(calibration_shift(i, j)));
            end
        end
    end
end