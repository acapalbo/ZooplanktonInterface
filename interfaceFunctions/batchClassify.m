function batchClassify(datasetsFolder,netTable,performBinning,seperateTrash,imgSize,confidenceThreshold,outputDir)
    logitLayer = "batchnorm";
    classNames = string(1:4);
    mkdir(outputDir)
    for z = 1:length(datasetsFolder)
        dataSetName = strsplit(datasetsFolder(z),"\");
        dataSetName = dataSetName(end);
        if seperateTrash && performBinning
            binBoundaries = netTable.boundaries;
            theta = netTable.theta;
            trainedSeperator = netTable.trainedSeperator;
            tempUnseperated = datasetsFolder(z);
            dataSetName = strsplit(datasetsFolder(z),"\");
            dataSetName = dataSetName(end);
            correctImgKey = SVMseperateTrash(tempUnseperated,dataSetName,netTable.trainedNet,logitLayer,trainedSeperator,imgSize,outputDir);
            
            [~,~,~] = classifySegmentedImagesIsotonic(netTable.trainedNet,strcat(outputDir,"\SVMClassifiedRawImages_",dataSetName,"\2"),strcat(outputDir,"\SVMPredictions_",dataSetName,"\2"),confidenceThreshold,outputDir,theta,binBoundaries,dataSetName,correctImgKey);
        elseif seperateTrash && ~performBinning
            trainedSeperator = netTable.trainedSeperator;
            tempUnseperated = datasetsFolder(z);
            dataSetName = strsplit(datasetsFolder(z),"\");
            dataSetName = dataSetName(end);
            correctImgKey = SVMseperateTrash(tempUnseperated,dataSetName,netTable.trainedNet,logitLayer,trainedSeperator,imgSize,outputDir);
            classifySegmentedImages(netTable.trainedNet,strcat(outputDir,"\SVMClassifiedRawImages_",dataSetName,"\2"),strcat(outputDir,"\SVMPredictions_",dataSetName,"\2"),confidenceThreshold,outputDir,dataSetName,correctImgKey)
        elseif ~seperateTrash && performBinning
            binBoundaries = netTable.boundaries;
            theta = netTable.theta;
            [tempImgKey,tempUniform] = prepareDatasetSingleClass(outputDir,datasetsFolder(z),imgSize,dataSetName);
            [~,~,~] = classifySegmentedImagesIsotonic(netTable.trainedNet,datasetsFolder(z),tempUniform,confidenceThreshold,outputDir,theta,binBoundaries,dataSetName,tempImgKey);
        elseif ~seperateTrash && ~performBinning
            [tempImgKey,tempUniform] = prepareDatasetSingleClass(outputDir,datasetsFolder(z),imgSize,dataSetName);
            classifySegmentedImages(netTable.trainedNet,datasetsFolder(z),tempUniform,confidenceThreshold,outputDir,dataSetName,tempImgKey);
        end

    end
end

