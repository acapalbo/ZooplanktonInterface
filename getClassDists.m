function classCounts = getClassDists(vid,BWthresh,h_vars,videoPath,saveTrashImages,minLength,minWidth,outputDir,parallelPool)
    BW = process_binary_videoV2(vid,BWthresh,h_vars);
    [~,videoTitle,~] = fileparts(videoPath);
    % Gather segmented images
    dataSetFilePath = segment_objects_parallel(vid,BW,h_vars,videoPath,saveTrashImages,minLength,minWidth,outputDir,parallelPool);
    
    
    imds = imageDatastore(dataSetFilePath, ...
        IncludeSubfolders=true, ...
        LabelSource="foldernames");

    numBins = 90;
    [totalYMag,totalYDir,datasetForm,imageFilePaths] = fitImageGradientHists(dataSetPath,numBins);

    x = linspace(-180,180,numBins);
    bubbleMarker = [];
    for z = 1:length(totalYDir)
        tempDir = cell2mat(totalYDir(z));
        idx = find(tempDir == max(tempDir));
        if idx >= 45 & idx <= 46 & max(tempDir)*100 >= .6
            bubbleMarker = cat(1,bubbleMarker,1);
        else
            bubbleMarker = cat(1,bubbleMarker,0);
        end
    end
    bubbleMarker = logical(bubbleMarker);
    bubbleImgs = imageFilePaths(logical(bubbleMarker));
    % Seperate out bubbles
    writeImages(bubbleImgs,outputDir)

    [tempImgKey,tempUniform] = prepareDatasetSingleClass(outputDir,fullfile(outputDir,"BubblesRemoved"),[229,229],videoTitle);
    classCounts = classifySegmentedImages(netTable.trainedNet,fullfile(outputDir,"BubblesRemoved"),tempUniform,confidenceThreshold,outputDir,videoTitle,tempImgKey);

    
end

function writeImages(bubbleImgs,outputPath)
    for z = 1:length(bubbleImgs)
        [~,tempFileName,ext] = fileparts(string(bubbleImgs(z)));
        copyfile(string(bubbleImgs(z)),fullfile(outputPath,"BubblesRemoved",strcat(tempFileName,ext)))
    end
end