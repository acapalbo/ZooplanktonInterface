function scores = SVMseperateTrash(trainingScores,trainingDir,tbPredictedScores,predictionDir,rawdataSetPath,desiredTitle)
    [imgKey,dataSetPath] = prepareDataset(pwd,rawdataSetPath,[227,227],1,desiredTitle);
    
    testingImds = imageDatastore(predictionDir, ...
        IncludeSubfolders=true, ...
        LabelSource="foldernames");

    trainingImds = imageDatastore(trainingDir, ...
        IncludeSubfolders=true, ...
        LabelSource="foldernames");

    cl = fitcsvm(trainingScores,trainingImds.Labels,"KernelFunction","rbf","ClassNames",[1 2]);
    [Labels,scores] = predict(cl,tbPredictedScores);
    SVMdir = strcat("SVMPredictions_",desiredTitle);
    mkdir(fullfile(pwd,SVMdir))
    mkdir(fullfile(pwd,SVMdir,string(1)))
    mkdir(fullfile(pwd,SVMdir,string(2)))
    for z = 1:length(Labels)
        if Labels(z) == 1
            copyfile(cell2mat(testingImds.Files(z)),fullfile(pwd,SVMdir,string(1)));
        else
            copyfile(cell2mat(testingImds.Files(z)),fullfile(pwd,SVMdir,string(2)));
        end
    end

        mkdir(sprintf("SVMClassifiedRawImages_%s",desiredTitle))
    classificationDir = sprintf("SVMClassifiedRawImages_%s",desiredTitle);
    predictionDir = fullfile(pwd,SVMdir);
    predictionClasses = dir(predictionDir);
    for j = 3:length(predictionClasses)
        tempClass = fullfile(predictionDir,predictionClasses(j).name);
        tempPredictions = dir(tempClass);
        mkdir(fullfile(classificationDir,num2str(j-2)))
        for z = 3:length(tempPredictions)
            tempUniImg = tempPredictions(z).name;
            tempRawImg = imgKey(any(imgKey == tempUniImg,2));
            copyfile(fullfile(rawdataSetPath,tempRawImg),fullfile(classificationDir,string(j-2),tempRawImg))
        end
    end
end