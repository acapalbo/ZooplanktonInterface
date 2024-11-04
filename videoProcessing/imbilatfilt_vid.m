%applies imfilter to all video frames
function filtered_vid = imbilatfilt_vid(vid)
    [l,w,num_frames] = size(vid);
    filtered_vid = zeros(l,w,"uint8");
    for i=1:num_frames
        img = vid(:,:,i);
        img_filt = imbilatfilt(img);
        filtered_vid = cat(3, filtered_vid, img_filt);
    end
    filtered_vid = filtered_vid(:,:,2:end);
end    
