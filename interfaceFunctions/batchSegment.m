function allDatasetPaths = batchSegment(videoFolder,h_vars,BWthresh,saveTrashImages,minLength,minWidth,batchOutputDir,runParallel,parallelMethod)
    videoFiles = dir(videoFolder);
    
    if runParallel
        delete(gcp("nocreate"));
        parallelPool = parpool(parallelMethod,maxNumCompThreads);
    end
    for z = 3:length(videoFiles)
        vid = read_avi(fullfile(videoFolder,videoFiles(z).name));
        fileName = char(videoFiles(z).name);
        fileName = fileName(1:end-4);
        BW = process_binary_videoV2(vid,BWthresh,h_vars);
        outputDir = fullfile(batchOutputDir,strcat("SegmentationOutput_",fileName));
        mkdir(outputDir)
        if ~runParallel
            dataSetFilePath = segment_objects(vid,BW,h_vars,fullfile(videoFolder,videoFiles(z).name),saveTrashImages,minLength,minWidth,outputDir);
        else
            dataSetFilePath = segment_objects_parallel(vid,BW,h_vars,fullfile(videoFolder,videoFiles(z).name),saveTrashImages,minLength,minWidth,outputDir,parallelPool);
        end
        if exist("allDatasetPaths")
            allDatasetPaths = cat(1,allDatasetPaths,dataSetFilePath);
        else
            allDatasetPaths = dataSetFilePath;
        end
    end
end