% Organism classes: 2 3 6 7

sortedPath = "C:\Users\acapalbo\OneDrive - Florida Atlantic University\AutomatedClassificationValidation\Sorted";
sortedFolders = dir(sortedPath);
mkdir CompiledDataset
for z = 3:length(sortedFolders)
    tempTopLevel = dir(fullfile(sortedPath,sortedFolders(z).name));
    for k = 3:length(tempTopLevel)
        % fprintf("<strong>%s</strong>\n",sortedFolders(z).name)
        if isfolder(fullfile(sortedPath,sortedFolders(z).name,tempTopLevel(k).name))
            tempDataset = dir(fullfile(sortedPath,sortedFolders(z).name,tempTopLevel(k).name));
            fileNames = struct2table(tempDataset);
            fileNames = fileNames.name;
            fileNames(1:2) = [];
            fileNames(contains(fileNames,"_removed")) = [];
            reClassified = fileNames(contains(fileNames,"_reclassified"));
            for j = [2,3,6,7]
                mkdir(strcat("CompiledDataset/",string(j)))
                tempClass = struct2table(dir(fullfile(sortedPath,sortedFolders(z).name,tempTopLevel(k).name,string(j)))).name;
                tempReclassified = struct2table(dir(fullfile(sortedPath,sortedFolders(z).name,tempTopLevel(k).name,sprintf("%d_reclassified",j)))).name;
                % tempTotal = cat(1,tempClass,tempReclassified);
                if ~isempty(tempClass)
                    tempClass(1:2)=[];
                    for i = 1:length(tempClass)
                        copyfile(fullfile(sortedPath,sortedFolders(z).name,tempTopLevel(k).name,string(j),tempClass(i)),strcat("CompiledDataset/",string(j)))
                    end
                end
                if ~isempty(tempReclassified)
                    tempReclassified(1:2)=[];

                    for i = 1:length(tempReclassified)
                        copyfile(fullfile(sortedPath,sortedFolders(z).name,tempTopLevel(k).name,sprintf("%d_reclassified",j),tempReclassified(i)),strcat("CompiledDataset/",string(j)))
                    end
                end
            end
        end
    end
end