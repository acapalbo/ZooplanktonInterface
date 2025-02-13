function correctImgKey = SVMseperateTrash(rawdataSetPath,desiredTitle,trainedNet,logitLayer,SVMclassifier,imgSize,outputDir)
    [imgKey,dataSetPath] = prepareDatasetSingleClass(outputDir,rawdataSetPath,imgSize,desiredTitle);
    
    predictionImds = imageDatastore(dataSetPath, ...
            IncludeSubfolders=true, ...
            LabelSource="foldernames");
    predictionData = combine(predictionImds,arrayDatastore(double(imgKey(:,3:4))));
    predictedLogits = minibatchpredict(trainedNet,predictionData,"Outputs",logitLayer);
    [Labels,scores] = isanomaly(SVMclassifier,predictedLogits);
    SVMdir = strcat("SVMPredictions_",desiredTitle);
    mkdir(fullfile(outputDir,SVMdir))
    mkdir(fullfile(outputDir,SVMdir,string(1)))
    mkdir(fullfile(outputDir,SVMdir,string(2)))
    for z = 1:length(Labels)
        if Labels(z) == 1
            copyfile(cell2mat(predictionImds.Files(z)),fullfile(outputDir,SVMdir,string(1)));
        else
            copyfile(cell2mat(predictionImds.Files(z)),fullfile(outputDir,SVMdir,string(2)));
        end
    end

    mkdir(strcat(outputDir,"\SVMClassifiedRawImages_",desiredTitle))
    classificationDir = strcat(outputDir,"\SVMClassifiedRawImages_",desiredTitle);
    predictionDir = fullfile(outputDir,SVMdir);
    predictionClasses = dir(predictionDir);
    for j = 3:length(predictionClasses)
        tempClass = fullfile(predictionDir,predictionClasses(j).name);
        tempPredictions = dir(tempClass);
        mkdir(fullfile(classificationDir,num2str(j-2)))

        for z = 3:length(tempPredictions)
            tempUniImg = tempPredictions(z).name;
            tempRawImg = imgKey(any(imgKey == tempUniImg,2));
            if exist("correctImgKey")
                correctImgKey = cat(1,correctImgKey,imgKey(any(imgKey == tempUniImg,2),:));
            else
                correctImgKey =imgKey(any(imgKey == tempUniImg,2),:);
            end
            copyfile(fullfile(rawdataSetPath,tempRawImg),fullfile(classificationDir,string(j-2),tempRawImg))
        end
    end
end