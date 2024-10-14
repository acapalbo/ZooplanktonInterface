% takes video and method and produces final expanded binary version for
% object detection
function [processed_vid,freqMask] = process_binary_videoSteps_v2(vid,thresh,h_vars,step)
    h_vars
    switch step
        case 'Binary'
            BW = binarize(vid,thresh);
            max(BW(:))
            [masked,freqMask] = mask_recurring_pixels(BW, h_vars(1));
            clear BW
            filtered = remove_small_objects(masked, h_vars(2));
            clear masked
            processed_vid = imdilate(filtered,strel("disk",h_vars(3)));
            clear filtered
        case 'Mask'
            BW = vid;
            [masked,freqMask] = mask_recurring_pixels(BW, h_vars(1));
            clear BW
            filtered = remove_small_objects(masked, h_vars(2));
            clear masked
            processed_vid = imdilate(filtered,strel("disk",h_vars(3)));
            clear filtered
        case 'SmallObj'
            masked = vid;
            filtered = remove_small_objects(masked, h_vars(2));
            clear masked
            processed_vid = imdilate(filtered,strel("disk",h_vars(3)));
            clear filtered
        case 'Dilate'
            filtered = vid;
            processed_vid = imdilate(filtered,strel("disk",h_vars(3)));
            clear filtered
    end
end

function binary = binarize(original, threshold)
    [l,w,num_frames] = size(original);
    binary = zeros(l, w, num_frames, 'logical');
    binary(:, :, :) = original(:, :, :) < threshold*255;
    clear l w num_frames original threshold
end

function [masked,freqMask] = mask_recurring_pixels(original, max_frequency)
    [l,w,num_frames] = size(original);
    masked = original;

    % find detection frequency for each pixel location
    freqMask = mean(uint8(original), 3);
    clear original
    % mask all pixel locations w/ high detection frequencies
    masked(repmat(freqMask >= max_frequency,[1,1,num_frames])) = 0;
    masked = logical(masked);
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
