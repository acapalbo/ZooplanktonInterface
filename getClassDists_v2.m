% Gelatinous niche counts
function classCounts = getClassDists_v2(outputDir,netTable,parallelPool,videoTitle,abundanceDir)
    % BW = process_binary_videoV2(vid,BWthresh,h_vars);
    % [~,videoTitle,~] = fileparts(videoPath);
    classificationDir = fullfile(outputDir,strcat("NicheClassification_",videoTitle));
    files = struct2table(dir(abundanceDir));
    files = string(files.name);
    sortedDir = files(contains(files,"ClassificationOutput"));
    sortedRaw = fullfile(abundanceDir,files(contains(files,"ClassifiedRaw")));
    uniformDir = files(contains(files,"Prepared"));
    dataSourceDir = fullfile(abundanceDir,sortedDir);
    gelDir = fullfile(dataSourceDir,"5");
    % abundanceDir
    % uniformDir
    imgKey = readtable(fullfile(abundanceDir,uniformDir,"imgSizes.csv"));
    % mkdir(fullfile(outputDir,"SegmentationData"))
    % % Gather segmented images
    % % fprintf("Starting Segmentation\n")
    % 
    % dataSetFilePath = segment_objects_parallel(vid,BW,h_vars,videoPath,saveTrashImages,minLength,minWidth,fullfile(outputDir,"SegmentationData"),parallelPool);
    % 
    % 
    % % imds = imageDatastore(dataSetFilePath, ...
    % %     IncludeSubfolders=true, ...
    % %     LabelSource="foldernames");
    % % imgSizes = getImgSizes(dataSetFilePath);
    % segFiles = dir(fullfile(outputDir,"SegmentationData"));
    % mkdir(fullfile(outputDir,"SegmentationData","BoxedValidationData"))
    % segFiles = struct2table(segFiles);
    % segFiles = segFiles.name;
    % csvDir = fullfile(fullfile(outputDir,"SegmentationData"),segFiles(contains(segFiles,"Table")));
    % writeBoxedVideo(vid,csvDir,fullfile(outputDir,"SegmentationData","BoxedValidationData"),videoTitle)
    % numBins = 90;
    % fprintf("Finished Segmentation\n")
    % fprintf("Removing Camera Abnormalties\n")
    % [totalYMag,totalYDir,datasetForm,imageFilePaths] = fitImageGradientHists(dataSetFilePath,numBins);

    % x = linspace(-180,180,numBins);
    % bubbleMarker = [];
    % buffer = 3;
    % gradientThresh = 0.5;
    % for z = 1:length(totalYDir)
    %     tempDir = cell2mat(totalYDir(z));
    %     idx = find(tempDir == max(tempDir));
    %     if idx >= 45 - buffer & idx <= 46 + buffer & max(tempDir)*100 >= gradientThresh
    %         bubbleMarker = cat(1,bubbleMarker,1);
    %     else
    %         bubbleMarker = cat(1,bubbleMarker,0);
    %     end
    % end
    % errorMarker = [];
    % for z = 1:length(imgSizes)
    %     tempImgSize = imgSizes(z,1:2);
    %     if min(tempImgSize)/max(tempImgSize) < 0.2
    %         errorMarker = cat(1,errorMarker,1);
    %     else
    %         errorMarker = cat(1,errorMarker,0);
    %     end
    % end
    % errorMarker = logical(errorMarker);
    % bubbleMarker = logical(bubbleMarker);
    % bubbleImgs = imageFilePaths(bubbleMarker);
    % errorImgs = imageFilePaths(errorMarker);
    % nonBubbleOrError = imageFilePaths(~bubbleMarker|~errorMarker);
    % % Seperate out bubbles
    % writeImages(bubbleImgs,outputDir,"ErrorImages")
    % writeImages(nonBubbleOrError,outputDir,"CleanDataset")
    % fprintf("Finished Cleaning Dataset\n")
    % fprintf("Beginning Classification\n")
    % [tempImgKey,tempUniform] = prepareDatasetSingleClass(outputDir,dataSetFilePath,[229,229],videoTitle);
    
    classCounts = classifySegmentedImagesIsotonic(netTable,sortedRaw,gelDir,0.5,classificationDir,videoTitle,imgKey,true);
    % fprintf("Classification Complete\n")
    
end

function writeImages(inputImgs,outputPath,dirTitle)
    mkdir(fullfile(outputPath,dirTitle))
    for z = 1:length(inputImgs)
        [~,tempFileName,ext] = fileparts(string(inputImgs(z)));
        copyfile(string(inputImgs(z)),fullfile(outputPath,dirTitle,strcat(tempFileName,ext)))
    end
end

function imgSizes = getImgSizes(dataPath)
    dataFiles = dir(dataPath);
    imgSizes = [];
    for z = 3:length(dataFiles)
        tempImg = imread(fullfile(dataPath,dataFiles(z).name));
        imgSizes = cat(1,imgSizes,[size(tempImg,1),size(tempImg,2)]);
    end
end