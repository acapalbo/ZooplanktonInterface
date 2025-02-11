function newImgKey = reconstructKey(keyPath)
    ImgKey = readlines(keyPath);
    for i = 1:length(ImgKey) - 1
        tempStr = ImgKey(i);
        strParts = strsplit(tempStr," ");
        if exist("newImgKey")
            newImgKey = cat(1,newImgKey,[sprintf("%s %s",strParts(1),strParts(2)) strParts(3)]);
        else
            newImgKey = [sprintf("%s %s",strParts(1),strParts(2)) strParts(3)];
        end
    end
end