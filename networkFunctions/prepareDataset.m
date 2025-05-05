function [imgKey,dataSetPath] = prepareDataset(startingFolder,srcFolder,uniformSize,classNames,dataSetTitle)
% classNames
% srcFolder
% startingFolder = pwd;
Files=dir(srcFolder);
mkdir(strcat("PreparedDataset",dataSetTitle));
dataSetPath = strcat(pwd,"\PreparedDataset",dataSetTitle,"\DataSet");
% uniformSize = [227,227];
% for k=3:length(Files)
%    FileNames=Files(k).name
% end
globalIter = 1;

    for k=3:length(Files)
        FolderName=Files(k).name;
        mkdir(fullfile(startingFolder,strcat("PreparedDataset",dataSetTitle,"\DataSet"),classNames(k-2)))
        % cd (strcat(srcFolder,"/",FolderName))
        imgs = dir(fullfile(srcFolder,FolderName));
        for z=3:length(imgs)
            img = imread(fullfile(srcFolder,FolderName,imgs(z).name));
            [l,w] = size(img);
            img = imresize(img,uniformSize,"bilinear");
            % delete(imgs(z).name)
            imwrite(img,fullfile(startingFolder,strcat("PreparedDataset",dataSetTitle,"\DataSet"),classNames(k-2), ...
                strcat(num2str(globalIter,'%04.f'),".png")));
            % movefile(imgs(z).name,strcat(num2str(globalIter,'%03.f'),".png"));
            globalIter = globalIter + 1;
            if exist("imgKey")
                imgKey = cat(1,imgKey,[imgs(z).name,strcat(num2str(globalIter-1,'%04.f'),".png"),l,w]);
            else
                imgKey = [imgs(z).name,strcat(num2str(globalIter-1,'%04.f'),".png"),l,w];
            end
        end    

        % cd(startingFolder)
    
    end
    imgSizes = imgKey(:,3:end);
    imgSizes = cat(2,imgSizes,(1:length(imgSizes))');
    writematrix(imgSizes,fullfile(startingFolder,strcat("PreparedDataset",dataSetTitle,"/imgSizes.csv")));
    fid = fopen(strcat(startingFolder,"\imgKey",dataSetTitle,".txt"),'w');
    for z = 1:length(imgKey)
        fprintf(fid,"%s %s\n",imgKey(z,:));
    end
    fclose(fid);
end