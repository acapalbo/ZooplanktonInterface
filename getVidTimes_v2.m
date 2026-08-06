function allTimes = getVidTimes_v2(videoFiles)    
    allTimes = [];
    for z = 1:length(videoFiles)
        videoTitle = videoFiles(z);
        tempTime = extract(videoTitle,digitsPattern(4)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+ " " + digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+"."+digitsPattern(3));
        tempTime = tempTime(2);
        tempTime = datetime(string(tempTime),"InputFormat","yyyy-MM-dd HH-mm-ss.SSS");
        allTimes = cat(1,allTimes,tempTime);
    end
end