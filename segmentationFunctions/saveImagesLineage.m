%takes video array, video title, and desired img_format (e.g. '.png')
%produces directory in current directory with every frame as individual image
function [identifiers,relVsNonRel] = saveImagesLineage(video_array,frameNum,bboxes,videoPath,seperateSmallImages,minLength,minWidth,outputDir)
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
    relVsNonRel = 0;
    for k=1:frames
        [l,w] = size(cell2mat(video_array(k)));
        fileNameFormat = sprintf('f%dx%dy%dw%dh%d_%s.png',frameNum,bboxes(k,1),bboxes(k,2),bboxes(k,3),bboxes(k,4),videoTitle); 

        if (l <= minLength & w <= minWidth) & seperateSmallImages  
            img_file = strcat(outputDir,"\NonRelevantObjects_",videoTitle,"\",fileNameFormat);
            imwrite(uint8(cell2mat(video_array(k))),img_file);
            identifiers = cat(1,identifiers,string(fileNameFormat));
            relVsNonRel = cat(1,relVsNonRel,0);
        else 
            img_file = strcat(outputDir,"\DataSet_",videoTitle,"\",fileNameFormat);
            imwrite(uint8(cell2mat(video_array(k))),img_file);
            identifiers = cat(1,identifiers,string(fileNameFormat));
            relVsNonRel = cat(1,relVsNonRel,1);
        end
    end
    identifiers(1) = [];
    relVsNonRel(1) = [];
end