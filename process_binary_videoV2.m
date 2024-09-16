% takes video and method and produces final expanded binary version for
% object detection
function processed_vid = process_binary_videoV2(vid,thresh,h_vars)

    BW = binarize(vid,thresh);

    masked = mask_recurring_pixels(BW, h_vars(1));
    clear BW
    filtered = remove_small_objects(masked, h_vars(2));
    clear masked
    processed_vid = domain_expansion(filtered, h_vars(3));
    clear filtered
end

function binary = binarize(original, threshold)
    [l,w,num_frames] = size(original);
    binary = zeros(l, w, num_frames, 'logical');
    binary(:, :, :) = original(:, :, :) < threshold*255;
    clear l w num_frames original threshold
end

function masked = mask_recurring_pixels(original, max_frequency)
    [l,w,num_frames] = size(original);
    masked = original;

    % find detection frequency for each pixel location
    frequencies = mean(uint8(original), 3);
    clear original
    % mask all pixel locations w/ high detection frequencies
    masked(repmat(frequencies >= max_frequency,[1,1,num_frames])) = 0;
    clear l w num_frames original max_frequency
end

function filtered = remove_small_objects(original, min_area)
    [l,w,num_frames] = size(original);
    filtered = zeros(l, w, num_frames, 'logical');

    for k = 1:num_frames
        filtered(:, :, k) = bwareaopen(original(:, :, k), min_area);
    end
    clear l w num_frames original min_area
end
