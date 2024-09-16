% takes expanded vid obj_orient,obj_area,obj_extrema,obj_eccent
function check = movement_check_v2(vid,pm_frames,obj_centroid,frame_idx)
    check = 0;
    base_img = vid(:,:,pm_frames+1);
    CC = bwconncomp(base_img);
    props = regionprops("table",CC, 'BoundingBox','Area','Perimeter','Eccentricity','Orientation','Centroid','PixelList');
    obj_idx = find(~cellfun(@isempty,cellfun(@(m) find(m(:,1) == obj_centroid(2) & m(:,2) == obj_centroid(1)),props.PixelList,'UniformOutput',false)));
    if isempty(obj_idx)
        A = repmat([obj_centroid(2),obj_centroid(1)],[length(props.Centroid) 1]);
        [~,obj_idx] = min(abs(props.Centroid - double(A)));
    end
    obj_pos = props.BoundingBox(obj_idx,:);
    x = obj_pos(3)/2; %height
    y = obj_pos(4)/2; %width
    obj_centroid = [obj_pos(1)+x,obj_pos(2)+y];

    [~,~,frame_num] = size(vid);
    forward_frames = pm_frames;
    backward_frames = pm_frames;
    base_frame = 4;
    for k = 1:pm_frames
        % if check >= k-1
            % frame forward
            if k <= forward_frames
                check_img = vid(:,:,base_frame + k);
                check_boxes = regionprops(check_img, 'BoundingBox','Orientation','Area','Perimeter','Eccentricity');
                inFrame = search_frame(check_boxes,props.Orientation(obj_idx,:),props.Area(obj_idx,:), ...
                    props.Perimeter(obj_idx,:),props.Eccentricity(obj_idx,:),obj_centroid);
                check = check + inFrame;
            end

            % frame backward
            if k <= backward_frames
                check_img = vid(:,:,base_frame - k);
                check_boxes = regionprops(check_img, 'BoundingBox','Orientation','Area','Perimeter','Eccentricity');
                inFrame = search_frame(check_boxes,props.Orientation(obj_idx,:),props.Area(obj_idx,:), ...
                    props.Perimeter(obj_idx,:),props.Eccentricity(obj_idx,:),obj_centroid);
                check = check + inFrame;
            end
        % end
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
            % fprintf("%.2f %.2f %.2f %.2f\n",obj_orient,obj_area,obj_perim,obj_eccent);
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