function imgSizes = datasetImgSizes(uniformDir,imgKey)
    tempPredictions = dir(uniformDir);
    imgSizes = [];
    for z = 3:length(tempPredictions)
        tempUniImg = string(tempPredictions(z).name);
        % size(imgKey);
        % size(tempUniImg);
        % tempUniImg
        % imgKey(:,2).uniformFileName
        % tempUniImg
        tempRawImg = imgKey(imgKey.uniformFileName == tempUniImg,:);
        if isempty(tempRawImg)
            error("You fucked up")
        end
        % tempInfo= imfinfo(fullfile(rawImgDir,tempRawImg));
        imgSizes = cat(1,imgSizes,uint8([tempRawImg.length,tempRawImg.width]));
    end
    % rawImgFiles = dir(rawImgDir);
    % imgSizes = [0,0];
    % for z = 1:length(imds.Labels)
    %     % imds.Files(z)
    %
    % end
    % imgSizes(1,:) = 0;
end