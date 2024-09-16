function objectArray = segmented_object_cleanup(bboxes, raw_frame)
    objectArray = {};
    % length(bboxes)
    for i=1:length(bboxes)
        boundingPos = bboxes(i,:);
        if ~isempty(boundingPos)
            obj = crop_bounding_initial(raw_frame,boundingPos,10);
            normImg = double(imresize(obj,[200 200],"bilinear"));
 
            objectArray = cat(3, objectArray,{normImg});
        end
    end
    % clearvars -except objectArray
end