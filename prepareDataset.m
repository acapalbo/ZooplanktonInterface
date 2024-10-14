function prepareDataset(startingFolder,srcFolder,uniformSize,classNames)
% classNames
% srcFolder
% startingFolder = pwd;
Files=dir(srcFolder);
% mkdir PreparedDataset
% uniformSize = [227,227];
% for k=3:length(Files)
%    FileNames=Files(k).name
% end
globalIter = 1;
length(Files)
if isfolder(fullfile(srcFolder,Files(3).name))
for k=3:length(Files)
    FolderName=Files(k).name;
    mkdir(fullfile(startingFolder,"PreparedDataset",classNames(k-2)))
    % cd (strcat(srcFolder,"/",FolderName))
    imgs = dir(fullfile(srcFolder,FolderName));
    for z=3:length(imgs)
        img = imread(fullfile(srcFolder,FolderName,imgs(z).name));
        img = imresize(img,uniformSize,"bilinear");
        % delete(imgs(z).name)
        imwrite(img,fullfile(startingFolder,"PreparedDataset",classNames(k-2), ...
            strcat(num2str(globalIter,'%04.f'),".png")));
        % movefile(imgs(z).name,strcat(num2str(globalIter,'%03.f'),".png"));
        globalIter = globalIter + 1;
    end    
    % cd(startingFolder)

end
else

    mkdir(fullfile("PreparedDataset","1"))
    cd (srcFolder)
    imgs = dir('*.*');
    for z=3:length(imgs)
        img = imread(imgs(z).name);
        img = imresize(img,uniformSize,"bilinear");
        % delete(imgs(z).name)
        imwrite(img,fullfile(startingFolder,"PreparedDataset",num2str(1), ...
            strcat(num2str(globalIter,'%04.f'),".png")));
        % movefile(imgs(z).name,strcat(num2str(globalIter,'%03.f'),".png"));
        globalIter = globalIter + 1;
    end    
    % cd(startingFolder)


end