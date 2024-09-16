%takes video array, video title, and desired img_format (e.g. '.png')
%produces directory in current directory with every frame as individual image
function image_directory(video_array,video_title,img_format)
    
    frames = size(video_array,3);
    
    %setting up directory title
    startingFolder = pwd;
    filename = strcat(startingFolder,'\obj_imgs_',video_title);
    
    mkdir (filename);
    cd (filename);

    for k=1:frames
        img_file = strcat(video_title,'obj_',int2str(k),'_',img_format);
        imwrite(video_array(:,:,k),img_file);
    end
    cd (startingFolder);
end