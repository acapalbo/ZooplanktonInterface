filePath = "C:\Users\acapalbo\OneDrive - Florida Atlantic University\AutomatedClassificationValidation";
imgFolders = dir(filePath);

for z = 3:length(imgFolders)
    topLevelFolder = dir(fullfile(filePath,imgFolders(z).name));
    if isfolder(fullfile(filePath,imgFolders(z).name)) & contains(imgFolders(z).name,digitsPattern)  & ~contains(imgFolders(z).name,lettersPattern)

        for k = 3:length(topLevelFolder)
            tempClassified = dir(fullfile(filePath,imgFolders(z).name,topLevelFolder(k).name));
            T = struct2table(tempClassified);
            T = T.name;
            T(1:2) = [];
            if ~any(contains(T,"_removed")) & ~any(contains(T,"_reclassified"))
                for j = 1:length(T)
                    mkdir(fullfile(filePath,imgFolders(z).name,topLevelFolder(k).name,strcat(T(j),"_removed")))
                end
            end
            if ~any(contains(T,"_reclassified")) & ~any(contains(T,"_removed"))
                for j = 1:length(T)
                    mkdir(fullfile(filePath,imgFolders(z).name,topLevelFolder(k).name,strcat(T(j),"_reclassified")))
                end
            end
            if any(contains(T,"_reclassified")) & any(contains(T,"_removed"))

                directoriesTBRM = T(contains(T,"_reclassified") & contains(T,"_removed"));
                for j = 1:length(directoriesTBRM)
                    rmdir(fullfile(filePath,imgFolders(z).name,topLevelFolder(k).name,string(directoriesTBRM(j))))
                end
            end
            
        end
    end
end