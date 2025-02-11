function imgSizes = datasetImgSizes(imds,rawImgDir)
    rawImgFiles = dir(rawImgDir);
    imgSizes = [0,0];
    for z = 1:length(imds.Labels)
        strParts = strsplit(imds.Files(z));
        tempInfo= iminfo(rawImgFiles(cell2mat(strParts(7))+2).name);
        imgSizes = cat(1,imgSizes,[tempInfo.width,tempInfo.height]);
    end
    imgSizes(1,:) = 0;
end