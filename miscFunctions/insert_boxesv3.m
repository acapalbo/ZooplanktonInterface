% input image & binary, find bounding boxes, output image w/ boxes
function boxedVideo = insert_boxesv3(raw_video,csvDir)

    % obtain bounding box information for each object in the frame
    % props = regionprops(binary_image, 'BoundingBox');
    % boxes = cat(1,props.BoundingBox);
    % boxedVideo = zeros(size(raw_video,1),size(raw_video,2));
    csvFolder = dir(csvDir);
    for z = 1:size(raw_video,3)
        tempCSV = readmatrix(strcat(csvDir,"/Frame_",num2str(z),".csv"));
        boxes = tempCSV(:,2:5);
        raw_img = raw_video(:,:,z);
        % [l,w] = size(raw_img);
        % insert boxes into the image
        boxed_image = raw_img;
        [detections,~] = size(boxes);
        for i = 1:detections
            pos = uint16([boxes(i,1), boxes(i,2), boxes(i,3), boxes(i,4)]);
            boxed_image = insertShape(boxed_image, "rectangle", pos, ...
                ShapeColor=("red"),LineWidth = 4);%,Opacity=0.5);
        end
        if exist("boxedVideo")
            boxedVideo = cat(4,boxedVideo,boxed_image);
        else
            boxedVideo = boxed_image;
        end
    end
end