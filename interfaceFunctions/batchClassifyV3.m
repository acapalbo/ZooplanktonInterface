function batchClassifyV3(appProgress,datasetsFolder,netTable,imgSize, ...
    confidenceThreshold,outputDir,subClassTable)
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
            if ~isempty(subClassTable)
                subClassParents = cell2mat(subClassTable.dataArea.UserInput(:,1));
                for j = 1:length(subClassParents)
                    subDataset = fullfile(basePath,"ClassificationOutput",strcat("ClassifiedRawImages",dataSetName),string(subClassParents(j)));
                    subUniform =  fullfile(basePath,"ClassificationOutput",strcat("ClassificationOutput",dataSetName),string(subClassParents(j)));
                    classifySegmentedImages(subClassTable.dataArea.UserInput(j,3),subDataset,subUniform,confidenceThreshold,outputDir,strcat(dataSetName,"subclass_",string(subClassParents(j))),tempImgKey);
                end
            end
        end
    end
    zipOutputFolders(basePath)
end

