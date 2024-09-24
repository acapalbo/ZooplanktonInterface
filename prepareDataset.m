function prepareDataset(srcFolder,uniformSize,classNames)
srcFolder
startingFolder = pwd;
Files=dir(srcFolder);
mkdir PreparedDataset
% uniformSize = [227,227];
% for k=3:length(Files)
%    FileNames=Files(k).name
% end
globalIter = 1;
length(Files)
if isfolder(Files(3).name)
for k=3:length(Files)
    FolderName=Files(k).name;
    mkdir(strcat("./PreparedDataset/",classNames(k-2)))
    cd (strcat(srcFolder,"/",FolderName))
    imgs = dir('*.*');
    for z=3:length(imgs)
        img = imread(imgs(z).name);
        img = imresize(img,uniformSize,"bilinear");
        % delete(imgs(z).name)
        imwrite(img,strcat(startingFolder,"/PreparedDataset/",classNames(k-2),"/", ...
            num2str(globalIter,'%04.f'),".png"));
        % movefile(imgs(z).name,strcat(num2str(globalIter,'%03.f'),".png"));
        globalIter = globalIter + 1;
    end    
    cd(startingFolder)

end
else

    mkdir(strcat("./PreparedDataset/1"))
    cd (srcFolder)
    imgs = dir('*.*');
    for z=3:length(imgs)
        img = imread(imgs(z).name);
        img = imresize(img,uniformSize,"bilinear");
        % delete(imgs(z).name)
        imwrite(img,strcat(startingFolder,"/PreparedDataset/1/", ...
            num2str(globalIter,'%04.f'),".png"));
        % movefile(imgs(z).name,strcat(num2str(globalIter,'%03.f'),".png"));
        globalIter = globalIter + 1;
    end    
    cd(startingFolder)


end