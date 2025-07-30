% inputs video (3-D uint8 array), calibration frame (2-D uint8 array), &
% brightness (usually 0.80-1.20), outputs flat-fielded video (3-D uint8 array)

% static, raw flatfielding (very fast)
function flatfielded_video = standardFlatfield_v2(original, brightness)

    % initialize variables
    [length, width, num_frames] = size(original);
    k = 10;
    % find average pixel value for each frame
    average_values = uint16(mean(mean(original)));

    calibration_frame = calibrateV2(original(:,:,1:k));
    average_values = squeeze(average_values);
    flatfielded_video = zeros(length, width, num_frames, 'uint8');
    for z = 1:num_frames
    % generate flatfielded video
    if mod(z,k) == 0
    calibration_frame = calibrateV2(original(:,:,z:min(z+k,num_frames)));

    end
    flatfielded_video(:,:,z) = uint8(uint16(original(:,:,z)).*uint16(average_values(z)*brightness) ./ uint16(calibration_frame));

    end
end