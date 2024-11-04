function batchFlatField() 
    addpath assets\
    addpath networkFunctions\
    addpath videoProcessing\
    filePath = uigetdir();
    videoFiles = dir(filePath);
    mkdir(fullfile(filePath,"FFvideos"))
    tStart = tic;
    for z = 3:length(videoFiles)
        try
            tempVid = read_avi(fullfile(filePath,videoFiles(z).name));
            calFrame = calibrateV2(tempVid);
            ffVid = preprocess_video(tempVid,calFrame,1,"precise");
            fileName = videoFiles(z).name;
            fileName = strcat(fileName(1:end-4),"precise_ff.avi");
            write_avi(ffVid,fullfile(filePath,"FFvideos\",fileName))
        catch
            fprintf("<strong>%s</strong> failed to read.\n",videoFiles(z).name);
            continue
        end
    end
    tEnd = toc(tStart);
    fprintf("Total time: %.3f seconds\n",tEnd)

end