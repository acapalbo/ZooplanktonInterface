function blurrySeperate(directoryPath,thresh)
    imgFiles = dir(directoryPath);
    outputDir = "FFT_Focus_Sort";
    tempoutputDir = outputDir;
    if exist(outputDir)
        z = 0;
        while exist(tempoutputDir)
            z = z + 1;
            tempoutputDir = strcat(outputDir,"(",string(z),")");
        end
    end
    outputDir = tempoutputDir;
    mkdir(outputDir)
    mkdir(fullfile(outputDir,"InFocus"))
    mkdir(fullfile(outputDir,"Blurry"))
    for z = 3:length(imgFiles)
        [~,meanVal] = blurryDetect(fullfile(directoryPath,imgFiles(z).name),false);
        if meanVal < thresh
            copyfile(fullfile(directoryPath,imgFiles(z).name),fullfile(outputDir,"Blurry"))
        else
            copyfile(fullfile(directoryPath,imgFiles(z).name),fullfile(outputDir,"InFocus"))
        end
    end
end