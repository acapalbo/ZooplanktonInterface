function crop_bounding(img, bounding_pos,frame_num, img_format)
    [num_objects,~] = size(bounding_pos);
    [l,w] = size(img);
    frameName = "Frame_";
    frameName = strcat(frameName,frame_num);
    startingFolder = pwd;
    filename = '\SegmentedObjects_';
    filename = strcat(filename,frameName);
       
    
        
    filename = strcat(startingFolder,filename);
    filename = string(filename);
    already_made = exist(filename);
    k = 1;
    while already_made ~= 0
        par = "(";
        par2 = ")";
        num = strcat(par, num2str(k));
        num_prev = strcat(par,num2str(k-1));
        num = strcat(num,par2);
        num_prev = strcat(num_prev,par2);
        filename = erase(filename,num_prev);
        filename = strcat(filename,num);
        k = k+1;
        already_made = exist(filename);
    end
    mkdir (filename);
    cd (filename);

    %set up image title and write to desired image format
    for i = 1:num_objects
        if bounding_pos(i,2) + bounding_pos(i,4) > l
            bounding_pos(i,4) = l - bounding_pos(i,2);
        end
        if bounding_pos(i,1) + bounding_pos(i,3) > w
            bounding_pos(i,3) = w - bounding_pos(i,1);
        end
        if bounding_pos(i,1) == 0
            bounding_pos(i,1) = 1;
        end
        if bounding_pos(i,2) == 0
            bounding_pos(i,2) = 1;
        end
        img_file = 'obj_';
        frame_num = int2str(i);
        img_file = strcat(img_file,frame_num);
        space = '_';
        img_file = strcat(img_file,space);
        img_file = strcat(img_file,frameName);
        img_file = strcat(img_file, img_format);

        cropped_img = img(bounding_pos(i,2):bounding_pos(i,2) + bounding_pos(i,4),bounding_pos(i,1):bounding_pos(i,1)+bounding_pos(i,3));   
        imwrite(cropped_img,img_file);
        

    end
    cd (startingFolder);
end