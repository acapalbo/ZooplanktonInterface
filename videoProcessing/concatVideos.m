function [totalVid,calFrame,ffVid] = concatVideos()
    filePath = uigetdir();
    videoFiles = dir(filePath);
    mkdir(fullfile(filePath,"CombinedVideo"))
    tStart = tic;
    fprintf("Reading from <strong>%s</strong>.\n",filePath);
    for z = 3:length(videoFiles)
        tempVid = read_avi(fullfile(filePath,videoFiles(z).name));
        if exist("totalVid")
            totalVid = cat(3,totalVid,tempVid);
        else
            totalVid = tempVid;
        end
    end

    calFrame = calibrateV2(totalVid);
    ffVid = preprocess_video(totalVid,calFrame,1,"precise");

    fileName = strcat(videoFiles(3).name,"_",videoFiles(end).name);
    write_avi(totalVid,fullfile(filePath,"CombinedVideo\",fileName))
    fileName = strcat(fileName,"precise_ff.avi");
    write_avi(ffVid,fullfile(filePath,"CombinedVideo\",fileName))

    tEnd = toc(tStart);
    fprintf("Total time: %.3f seconds\n",tEnd)

end