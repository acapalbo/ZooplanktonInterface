% takes expanded vid obj_orient,obj_area,obj_extrema,obj_eccent
function check = movement_check(vid,pm_frames,obj_circularity,obj_area,frame_idx)

    check = 0;
    base_img = vid(:,:,frame_idx);
    boxes = regionprops(base_img, 'BoundingBox','Area','Perimeter','Eccentricity','Orientation','Circularity');
    bboxes = cat(1,boxes.BoundingBox);
    allCircularity = cat(1,boxes.Circularity);
    orientation = cat(1,boxes.Orientation);
    allArea = cat(1,boxes.Area);
    allPerimeter = cat(1,boxes.Perimeter);
    allEccentricity = cat(1,boxes.Eccentricity);
    % figure
    % imshow(base_img)
    % finds desired object based on given area and orientation
    for i=1:size(orientation,1)
        area = allArea(i);
        circularity = allCircularity(i);
        if circularity - obj_circularity < 2
            if area - obj_area < 2
                obj_idx = i;
            end
        end
    end

    obj_pos = bboxes(obj_idx,:);
    obj_orient = orientation(obj_idx,:);
    obj_area = allArea(obj_idx,:);
    obj_perim = allPerimeter(obj_idx,:);
    obj_eccent = allEccentricity(obj_idx,:);

    x = obj_pos(3)/2; %height
    y = obj_pos(4)/2; %width
    obj_centroid = [obj_pos(1)+x,obj_pos(2)+y];

    [~,~,frame_num] = size(vid);
    forward_frames = pm_frames;
    backward_frames = pm_frames;
    if frame_idx - backward_frames < 1
        backward_frames = frame_idx - 1;
        forward_frames = 2*pm_frames - backward_frames;
    end
    if frame_idx + forward_frames > frame_num
        forward_frames = frame_num - frame_idx;
        backward_frames = 2*pm_frames - forward_frames;
    end
    for k = 1:2*pm_frames
        if check >= floor((k-1)/2)
            % frame forward
            if k <= forward_frames
                check_img = vid(:,:,frame_idx + k);
                check_boxes = regionprops(check_img, 'BoundingBox','Orientation','Area','Perimeter','Eccentricity');
                inFrame = search_frame(check_boxes,obj_orient,obj_area,obj_perim,obj_eccent,obj_centroid);
                check = check + inFrame;
            end

            % frame backward
            if k <= backward_frames
                check_img = vid(:,:,frame_idx - k);
                check_boxes = regionprops(check_img, 'BoundingBox','Orientation','Area','Perimeter','Eccentricity');
                inFrame = search_frame(check_boxes,obj_orient,obj_area,obj_perim,obj_eccent,obj_centroid);
                check = check + inFrame;
            end
            fprintf("Iteration %d, check = %d\n",k,check);
        end
    end
end

function check = search_frame(check_boxes,obj_orient,obj_area,obj_perim,obj_eccent,obj_centroid)
    check = 0;
    bboxes = cat(1,check_boxes.BoundingBox);
    orientation = cat(1,check_boxes.Orientation);
    allArea = cat(1,check_boxes.Area);
    allPerimeter = cat(1,check_boxes.Perimeter);
    allEccentricity = cat(1,check_boxes.Eccentricity);
    distance_threshold = 35;
    for i = 1:size(bboxes,1)
        bounding_pos = bboxes(i,:);
        y = bounding_pos(:,4)/2; %height
        x = bounding_pos(:,3)/2; %width
        centroids = [bounding_pos(:,1) + x,bounding_pos(:,2)+y]; % flip for matrix form
        temp_vect = sqrt((centroids(1)-obj_centroid(1))^2 +(centroids(2)-obj_centroid(2))^2);
        if temp_vect < distance_threshold
            orient = orientation(i,:);
            area = allArea(i,:);
            perim = allPerimeter(i,:);
            eccent = allEccentricity(i,:);
            match_check = checkProps(orient, area,perim,eccent, obj_orient,obj_area,obj_perim,obj_eccent);
            if match_check >= 3
                check = check + 1;
            end
        end
    end
end

function match_check = checkProps(orient, area,perim,eccent, obj_orient,obj_area,obj_perim,obj_eccent)
    match_check = 0;
    angle_thresh = 15;
    area_thresh = 15;
    eccent_thresh = 0.2;
    perim_thresh = 10;
    if abs(orient - obj_orient) < angle_thresh
        match_check = match_check + 1;
    end
    if abs(area - obj_area) < area_thresh
        match_check = match_check + 1;
    end
    if abs(eccent - obj_eccent) < eccent_thresh
        match_check = match_check + 1;
    end
    if abs(perim - obj_perim) < perim_thresh
        match_check = match_check + 1;
    end
end