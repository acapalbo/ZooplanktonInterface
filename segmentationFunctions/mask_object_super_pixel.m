function BWfinal = mask_object_super_pixel(img)
    [l,w]= size(img);
    y_origin = l/2;
    x_origin = w/2;
    
    % generates binary mask of the image
    
    outputImage = super_pixel_avg(img);
    threshold = graythresh(outputImage);
    BW = logical(imcomplement(imbinarize(outputImage,threshold)));
    seD = strel("disk",1);
    BWdil = imdilate(BW,seD);
    CC = bwconncomp(BWdil);
    props = regionprops(CC, 'All');
    bboxes = cat(1,props.BoundingBox);

    y = bboxes(:,4)/2; %height
    x = bboxes(:,3)/2; %width
    centroids = [bboxes(:,2)+y,bboxes(:,1) + x]; % flip for matrix form
    closest_vect = sqrt((centroids(1,1) - y_origin)^2 +(centroids(1,2) - x_origin)^2);
    closest_idx = 1;
        for i = 1:size(centroids,1)
            temp_vect = sqrt((centroids(i,1)-y_origin)^2 +(centroids(i,2)-x_origin)^2);
            if temp_vect < closest_vect
                closest_vect = temp_vect;
                closest_idx = i;
            end
        end
        L = labelmatrix(CC);
        mask = uint8(BW).*uint8((L == closest_idx));
        seD = strel("disk",2);
        expanded_bw = imdilate(mask,seD);
        % expanded_bw = domain_expansion(mask, 2);
        BWfinal = imerode(expanded_bw,seD);
end

function avg_img = super_pixel_avg(img)
    [l,w] = size(img);
    n_pixels = 1000;
    if n_pixels > l*w
        n_pixels = floor(sqrt(l*w));
    end
    [L,N] = superpixels(img,n_pixels);
    img_rgb = img;
    img_rgb = cat(3,img_rgb,img);
    img_rgb = cat(3,img_rgb,img);
    img = img_rgb;
    avg_img = zeros(size(img),'like',img);
    idx = label2idx(L);
    sz = size(img);
    for labelVal = 1:N
        redIdx = idx{labelVal};
        greenIdx = idx{labelVal}+sz(1)*sz(2);
        blueIdx = idx{labelVal}+2*sz(1)*sz(2);
        avg_img(redIdx) = mean(img(redIdx));
        avg_img(greenIdx) = mean(img(greenIdx));
        avg_img(blueIdx) = mean(img(blueIdx));
    end    
    avg_img = avg_img(:,:,1);
end