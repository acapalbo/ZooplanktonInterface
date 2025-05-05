function batchFlatField(appProgress,filePath,outputDir,FFmethod) 
    addpath assets\
    addpath networkFunctions\
    addpath videoProcessing\
    videoFiles = dir(filePath);
    mkdir(outputDir)
    tStart = tic;
    fprintf("Reading from <strong>%s</strong>.\n",filePath);
    for z = 3:length(videoFiles)
        appProgress.Text = strcat(string(round((z-3)/(length(videoFiles)-3)*100,2)),"%");
        try
            tempVid = read_avi(fullfile(filePath,videoFiles(z).name));
        catch
            fprintf("<strong>%s</strong> failed to read.\n",videoFiles(z).name);
            continue
        end
        try
            calFrame = calibrateV2(tempVid);
            ffVid = preprocess_video(tempVid,calFrame,1,FFmethod);
        catch 
            fprintf("<strong>%s</strong> failed to process.\n",videoFiles(z).name);
            continue
        end
        try
            fileName = videoFiles(z).name;
            fileName = strcat(fileName(1:end-4),"precise_ff.avi");
            write_avi(ffVid,fullfile(outputDir,fileName))
        catch
            fprintf("<strong>%s</strong> failed to write.\n",videoFiles(z).name);
            continue
        end
        clear tempVid calFrame ffVid
    end
    tEnd = toc(tStart);
    fprintf("Total time: %.3f seconds\n",tEnd)

end