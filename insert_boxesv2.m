% input image & binary, find bounding boxes, output image w/ boxes
function boxed_image = insert_boxesv2(raw_img, boxes)

    % obtain bounding box information for each object in the frame
    % props = regionprops(binary_image, 'BoundingBox');
    % boxes = cat(1,props.BoundingBox);
    [l,w] = size(raw_img);
    % insert boxes into the image
    boxed_image = raw_img;
    [detections,~] = size(boxes);
    for i = 1:detections
        pos = uint16([boxes(i,1), boxes(i,2), boxes(i,3), boxes(i,4)]);
        % if boxes(i,3)*boxes(i,4) > 100 && std2(raw_img(pos(2):pos(2)+pos(4)-1,pos(1):pos(1)+pos(3)-1)) > 30
        boxed_image = insertShape(boxed_image, "rectangle", pos, ...
            ShapeColor=("red"),LineWidth = 2);%,Opacity=0.5);
        % cropped_img = raw_img(max(pos(2),1):min(pos(2) + pos(4),l), ...
        %     max(pos(1),1):min(pos(1)+pos(3),w));
        %size(cropped_img)
        %imshow(cropped_img);
        %pause(1)
        % end
    end
end