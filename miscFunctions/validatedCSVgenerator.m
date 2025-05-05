clear
imgPath = uigetdir;

imgDirs = dir(imgPath);

for z = 3:length(imgDirs)
    if isfolder(fullfile(imgPath,imgDirs(z).name))
         mkdir(fullfile("Sorted",imgDirs(z).name))
         tempFiles = dir(fullfile(imgPath,imgDirs(z).name));
         T = struct2table(tempFiles);
         fileNames = T.name;
         fileNames(1:2)=[];
         folderCheck = zeros(length(fileNames),1,"logical");
         for j = 1:length(fileNames)
            if isfolder(fullfile(imgPath,imgDirs(z).name,fileNames(j)))
                folderCheck(j) = 1;
                % disp("Folder")
            end
         end
         fileNames(folderCheck) = [];
         % tempTable = strjoin([fileNames,repmat(strjoin(repmat("",[1,5])),length(fileNames),1),repmat("no",length(fileNames),1),repmat(strjoin(repmat("",[1,43])),length(fileNames),1)],"");
         baseString = sprintf("File:%s|Status:%s",strjoin(repmat("",[1,40])),strjoin(repmat("",[1,38])));
         tempTable = cat(1,baseString,strjoin(repmat("-",[89,1]),""));
         % baseString
         % tempTable
         % tempTable = cat(1,baseString,tempTable);
         for j = 1:length(fileNames)
            tempLine = sprintf("%s%s|%s%s",string(fileNames(j)),strjoin(repmat("",[1,5])),"Not Validated",strjoin(repmat("",[1,32])));
            tempTable = cat(1,tempTable,tempLine);
         end
         writematrix(tempTable,fullfile("Sorted",imgDirs(z).name,strcat(imgDirs(z).name,".txt")))
    end
end