function randomImgOrder = randomlySelectImages(folderPath,numImages,makeDir)
    imgFiles = dir(folderPath);
    imgFiles = struct2table(imgFiles);
    imgNames = imgFiles.name;
    imgNames(1:2) = [];
    imgOrder = randperm(length(imgNames),numImages);
    randomImgOrder = imgNames(imgOrder);
    if makeDir
        mkdir randomImages
        for i = 1:length(randomImgOrder)
            tempImg = imread(fullfile(folderPath,randomImgOrder(i)));
            imwrite(tempImg,fullfile(pwd,"randomImages",randomImgOrder(i)))
        end
    end
end