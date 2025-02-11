function final_bboxes = segment_objects_core(BW,frame_idx,raw_frame,h_vars)
    
    base_frame = BW(:,:,frame_idx);
    props = regionprops(base_frame, 'BoundingBox','PixelIdxList');

    [detections,~] = size(props);
    fprintf("Detected %d objects\n", detections);
    
    final_bboxes=zeros(detections,4,"uint16");
    
    for i = 1:detections
    
        bounding_pos = uint16(props(i).BoundingBox);

        cropped_img = crop_bounding_initial(raw_frame,bounding_pos,h_vars(4));
        obj_mask = mask_object_super_pixel(cropped_img);
    
        % **Uncomment to check that object masks are suffient**
        % figure
        % fig = gcf;
        % fig.Position = [400,200,100,100];
        % imshow(labeloverlay(imresize(cropped_img,[200,200]),imresize(obj_mask,[200,200])));
        % pause(1)
        % close gcf;

        stats = object_metrics(cropped_img, obj_mask);
        % checks if object is valid given algorithm criteria
        % validity = check_criteria(stats);
    
        if stats(1) > 25 && stats(4) < 0.6
    
            % BW_cropped = crop_bounding_initial(BW,bounding_pos,200);
            % class(allPixelIdx)
            if h_vars(5) > 0
                check_movement = movementCheckRegion3(BW,h_vars(5),frame_idx,props(i).PixelIdxList);
            else
                check_movement = 0;
            end
            % fprintf("Moves %d frames\n",check_movement)

            if check_movement <= h_vars(5)
                final_bboxes(i,:) = uint16(props(i).BoundingBox);
            end
        end
    end
end
