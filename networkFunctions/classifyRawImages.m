function classifyRawImages(rawImageDir,predictionDir,imgKey,videoTitle)
    % rawImages = dir(rawImageDir);
    predictionClasses = dir(predictionDir);
    mkdir(sprintf("ClassifiedRawImages_%s",videoTitle))
    classificationDir = sprintf("ClassifiedRawImages_%s",videoTitle);
    imgKey = reconstructKey(imgKey);

    for j = 3:length(predictionClasses)
        tempClass = fullfile(predictionDir,predictionClasses(j).name);
        tempPredictions = dir(tempClass);
        mkdir(fullfile(classificationDir,num2str(j-2)))
        for z = 3:length(tempPredictions)
            tempUniImg = tempPredictions(z).name;
            tempRawImg = imgKey(any(imgKey == tempUniImg,2));
            copyfile(fullfile(rawImageDir,tempRawImg),fullfile(classificationDir,string(j-2),tempRawImg))
        end
    end
end