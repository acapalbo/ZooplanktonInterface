function allTimes = getVidTimes(videoDir)    
    videoFiles = dir(videoDir);
    allTimes = [];
    for z = 3:length(videoFiles)
        videoTitle = videoFiles(z).name;
        tempTime = extract(videoTitle,digitsPattern(4)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+ " " + digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+"."+digitsPattern(3));
        tempTime = datetime(string(tempTime),"InputFormat","yyyy-MM-dd HH-mm-ss.SSS");
        allTimes = cat(1,allTimes,tempTime);
    end
end