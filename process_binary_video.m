% takes video and method and produces final expanded binary version for
% object detection
function processed_vid = process_binary_video(vid,thresh,method,h_vars)

    if method == "edge"
        BW = edge_finder_vid(vid, "sobel", thresh, "both");
    end

    if method == "gradient"
        BW = imgradient_vid(vid,thresh);
    end

    if method == "histBin"
        BW = hist_eq_vid(vid,thresh);
    end

    if method == "binarize"
        BW = binarize(vid,thresh);
    end

    if method == "gaussFilt"
        BW = gaussFilt(vid,150);
    end

    masked = mask_recurring_pixels(BW, h_vars(1));
    clear BW
    filtered = remove_small_objects(masked, h_vars(2));
    clear masked
    processed_vid = domain_expansion(filtered, h_vars(3));
    clear filtered
end

function edge_frames = edge_finder_vid(vid, method,fudge_factor, direction)
    
    [l,w,num_frames] = size(vid);
    edge_frames = zeros(l,w,num_frames,"logical");

    for i=1:num_frames
        img = vid(:,:,i);
        % generates base threshold for method chosen
        [~,threshold] = edge(img,method);
        threshold = threshold*fudge_factor;
        edge_frames(:,:,i) = edge(img, method, threshold, direction);
    end
end    

function filtered_vid = imgradient_vid(vid,thresh)
    [l,w,num_frames] = size(vid);
    filtered_vid = zeros(l,w,num_frames,"logical");
    for i=1:num_frames
        img = vid(:,:,i);
        [img_filt,~] = imgradient(img);
        img_filt(img_filt < thresh) = 0;
        img_filt(img_filt >= thresh) = 1;
        filtered_vid(:,:,i) = logical(img_filt);
    end
end    

function filtered_vid = gaussFilt(vid,thresh)
    [l,w,num_frames] = size(vid);
    filtered_vid = zeros(l,w,num_frames,"logical");
    h = fspecial('log',9,0.4);
    for i=1:num_frames
        img = vid(:,:,i);
        img_filt = imfilter(img,h);
        img_filt(img_filt < thresh) = 0;
        img_filt(img_filt >= thresh) = 1;
        filtered_vid(:,:,i) = logical(img_filt);
    end
end    

function filtered_vid = hist_eq_vid(vid,threshold)
    [l,w,num_frames] = size(vid);
    filtered_vid = zeros(l,w,num_frames,"logical");
    for i=1:num_frames
        img = vid(:,:,i);
        img_filt = histeq(img);
        img_filt = imcomplement(imbinarize(img_filt,threshold));
        filtered_vid(:,:,i) = logical(img_filt);
    end
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
    for i = 1:l
        for j = 1:w
            if frequencies(i, j) >= max_frequency
                masked(i, j, :) = 0;
            end
        end
    end
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
