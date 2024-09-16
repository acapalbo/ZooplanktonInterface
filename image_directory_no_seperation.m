%takes video array, video title, and desired img_format (e.g. '.png')
%produces directory in current directory with every frame as individual image
function image_directory_no_seperation(video_array,img_format,frameNum)
    warning('off','MATLAB:MKDIR:DirectoryExists');
    frames = length(video_array);
    
    %setting up directory title
    % startingFolder = pwd;
    % filename = strcat(startingFolder,'\obj_imgs_',video_title);
    % 
    % mkdir (filename);
    % cd (filename);
    for k=1:frames
        [l,w] = size(cell2mat(video_array(k)));
        if l*w < 1600
            img_file = strcat(".\TestingOutputs\SmallObjects\","f",num2str(frameNum),'obj',int2str(k),img_format);
            imwrite(cell2mat(video_array(k)),img_file);
        else
            img_file = strcat(".\TestingOutputs\LargeObjects\","f",num2str(frameNum),'obj',int2str(k),img_format);
            imwrite(cell2mat(video_array(k)),img_file);
        end
    end
end