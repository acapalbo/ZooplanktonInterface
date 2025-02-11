function moveLargeImages(folderPath,videoTitle)
    imageDir = dir(folderPath);
    mkdir(strcat("largeImages",videoTitle))
    for z=3:length(imageDir)
        info = imfinfo(fullfile(folderPath,imageDir(z).name));
    
        if info.Height > 50 | info.Width > 50
            copyfile(fullfile(folderPath,imageDir(z).name),strcat(pwd,"\largeImages",videoTitle))
        end
    end
end