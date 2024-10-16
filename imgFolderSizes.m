function fullInfo = imgFolderSizes(folderPath)
    imgFiles = dir(folderPath);
    if isfolder(fullfile(folderPath,imgFiles(3).name))
        folders = dir(folderPath);
        for z = 3:length(folders)
        imgFiles = dir(fullfile(folderPath,folders(z).name));
            for i = 3:length(imgFiles)
                info = imfinfo(fullfile(folderPath,folders(z).name,imgFiles(i).name));
                if exist('fullInfo')
                    fullInfo = cat(1,fullInfo,[info.Height,info.Width]);
                else
                    fullInfo = [info.Height,info.Width];
                end
            end
        end
    else
        for i = 3:length(imgFiles)
            if ~isfolder(fullfile(folderPath,imgFiles(i).name))
                info = imfinfo(fullfile(folderPath,imgFiles(i).name));
                if exist('fullInfo')
                    fullInfo = cat(1,fullInfo,[info.Height,info.Width]);
                else
                    fullInfo = [info.Height,info.Width];
                end
            end
        end
    end
end