function batchClassifyV2(appProgress,datasetsFolder,netTable,imgSize,confidenceThreshold,outputDir)
    % classNames = string(1:7);
    mkdir(outputDir)
    fileParts = strsplit(outputDir,"\");
    basePath = strjoin(fileParts(1:end-1),"\");
    datasetFiles = dir(datasetsFolder);
    for z = 3:length(datasetFiles)
        tempFiles = dir(fullfile(datasetsFolder,datasetFiles(z).name));
        datasetPath = fullfile(datasetsFolder,datasetFiles(z).name,tempFiles(3).name);
        appProgress.Text = strcat(string(round((z-3)/(length(datasetFiles)-3)*100,2)),"%");
        dataSetName = tempFiles(3).name;
        [tempImgKey,tempUniform] = prepareDatasetSingleClass(outputDir,datasetPath,imgSize,dataSetName);
        if isstring(tempImgKey)
            classifySegmentedImages(netTable.trainedNet,datasetPath,tempUniform,confidenceThreshold,outputDir,dataSetName,tempImgKey);
        end
    end
    zipOutputFolders(basePath)
end

