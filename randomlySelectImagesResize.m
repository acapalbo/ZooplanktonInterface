function randomImgOrder = randomlySelectImagesResize(folderPath,numImages,makeDir)
    imgFiles = dir(folderPath);
    imgFiles = struct2table(imgFiles);
    imgNames = imgFiles.name;
    imgNames(1:2) = [];
    imgOrder = randperm(length(imgNames),numImages);
    randomImgOrder = imgNames(imgOrder);
    % fullInfo = imgFolderSizes(folderPath);
    maxL = 0;
    maxW = 0;
    if makeDir
        mkdir randomImages
        mkdir randomImagesResized
        mkdir randomImagesScaleBar
        for i = 1:length(randomImgOrder)
            tempImg = imread(fullfile(folderPath,randomImgOrder(i)));
            imwrite(tempImg,fullfile(pwd,"randomImages",randomImgOrder(i)))
            [l,w] = size(tempImg);
            if l > maxL
                maxL = l;
            end
            if w > maxW
                maxW = w;
            end
        end
        for i = 1:length(randomImgOrder)
            tempImg = imread(fullfile(pwd,"randomImages",randomImgOrder(i)));
            resizeImg = imresize(tempImg,[maxL,maxW]);
            imwrite(resizeImg,fullfile(pwd,"randomImagesResized",randomImgOrder(i)));
        end
        for i = 1:length(randomImgOrder)
            % tempImg = imread(fullfile(pwd,"randomImages",randomImgOrder(i)));
            tempImg = insertScaleBarAdaptiveImageWithLabeling(fullfile(pwd,"randomImages",randomImgOrder(i)),1,1/26.9,"mm",i);
            resizeImg = imresize(tempImg,[maxL,maxW]);
            imwrite(resizeImg,fullfile(pwd,"randomImagesScaleBar",randomImgOrder(i)));
        end
    end
end