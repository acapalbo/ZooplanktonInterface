%takes video array, video title, and desired img_format (e.g. '.png')
%produces directory in current directory with every frame as individual image
function identifiers = saveImagesLineage(video_array,frameNum,bboxes,videoPath)
    warning('off','MATLAB:MKDIR:DirectoryExists');
    frames = length(video_array);
    [~,videoTitle,~] = fileparts(videoPath);
    %setting up directory title
    % startingFolder = pwd;
    % filename = strcat(startingFolder,'\obj_imgs_',video_title);
    % 
    % mkdir (filename);
    % cd (filename);
    identifiers = "";
    for k=1:frames
        [l,w] = size(cell2mat(video_array(k)));
        fileNameFormat = sprintf('f%dx%dy%dw%dh%d_%s.png',frameNum,bboxes(k,1),bboxes(k,2),bboxes(k,3),bboxes(k,4),videoTitle); 
        if l*w < 1600
            img_file = strcat(".\TestingOutputs\SmallObjects\",fileNameFormat);
            imwrite(cell2mat(video_array(k)),img_file);
        else
            img_file = strcat(".\TestingOutputs\LargeObjects\",fileNameFormat);
            imwrite(cell2mat(video_array(k)),img_file);
        end
        identifiers = cat(1,identifiers,string(fileNameFormat));
    end
    identifiers(1) = [];
end