dirPath = uigetdir;
directoryFolders = dir(dirPath);

videoTitle = "MyCamera-063-2024-03-03 11-49-38.939.avi";
for i = 3:length(directoryFolders)
    tempFolder = directoryFolders(i).name;
    fileNames = dir(strcat(dirPath,'/',tempFolder));
    if tempFolder ~= "BoundingBoxData"
    for z = 3:length(fileNames)
        tempImg = fileNames(z).name;
        numberStr = extract(tempImg,digitsPattern);
        csv = strcat(dirPath,'/BoundingBoxData/Frame_',string(numberStr(1)));
        csv = readmatrix(csv);
        k = cell2mat(numberStr(2));
        k = str2num(k);
        movefile(strcat(dirPath,'/',tempFolder,'/',tempImg),strcat(dirPath,'/',tempFolder,'/',sprintf('f%sx%dy%dw%dh%d_%s.png',string(numberStr(1)),csv(k,1),csv(k,2),csv(k,3),csv(k,4),videoTitle)))

    end
    end
end