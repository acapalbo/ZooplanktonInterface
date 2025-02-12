function batchClassify(appProgress,datasetsFolder,netTable,performBinning,seperateTrash,imgSize,confidenceThreshold,outputDir)
    logitLayer = "batchnorm";
    classNames = string(1:4);
    mkdir(outputDir)
    datasetFiles = dir(datasetsFolder);
    for z = 3:length(datasetFiles)
        tempFiles = dir(fullfile(datasetsFolder,datasetFiles(z).name))
        datasetPath = fullfile(datasetsFolder,datasetFiles(z).name,tempFiles(3).name)
        appProgress.Text = strcat(string(round((z-3)/(length(datasetFiles)-3)*100,2)),"%");
        dataSetName = tempFiles(3).name
        if seperateTrash && performBinning
            binBoundaries = netTable.boundaries;
            theta = netTable.theta;
            trainedSeperator = netTable.trainedSeperator;
            correctImgKey = SVMseperateTrash(datasetPath,dataSetName,netTable.trainedNet,logitLayer,trainedSeperator,imgSize,outputDir);
            
            [~,~,~] = classifySegmentedImagesIsotonic(netTable.trainedNet,strcat(outputDir,"\SVMClassifiedRawImages_",dataSetName,"\2"),strcat(outputDir,"\SVMPredictions_",dataSetName,"\2"),confidenceThreshold,outputDir,theta,binBoundaries,dataSetName,correctImgKey);
        elseif seperateTrash && ~performBinning
            trainedSeperator = netTable.trainedSeperator;

            correctImgKey = SVMseperateTrash(datasetPath,dataSetName,netTable.trainedNet,logitLayer,trainedSeperator,imgSize,outputDir);
            classifySegmentedImages(netTable.trainedNet,strcat(outputDir,"\SVMClassifiedRawImages_",dataSetName,"\2"),strcat(outputDir,"\SVMPredictions_",dataSetName,"\2"),confidenceThreshold,outputDir,dataSetName,correctImgKey)
        elseif ~seperateTrash && performBinning
            binBoundaries = netTable.boundaries;
            theta = netTable.theta;
            [tempImgKey,tempUniform] = prepareDatasetSingleClass(outputDir,datasetPath,imgSize,dataSetName);
            [~,~,~] = classifySegmentedImagesIsotonic(netTable.trainedNet,datasetPath,tempUniform,confidenceThreshold,outputDir,theta,binBoundaries,dataSetName,tempImgKey);
        elseif ~seperateTrash && ~performBinning
            [tempImgKey,tempUniform] = prepareDatasetSingleClass(outputDir,datasetPath,imgSize,dataSetName);
            classifySegmentedImages(netTable.trainedNet,datasetPath,tempUniform,confidenceThreshold,outputDir,dataSetName,tempImgKey);
        end

    end
end

