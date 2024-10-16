function [sortedFilenames,sortedSizes] = imgSort(folderPath,imgSizes)
    imgFiles = dir(folderPath);
    imgFiles = struct2table(imgFiles);
    imgNames = imgFiles.name;
    imgNames(1:2) = [];
    heights = imgSizes(:,1);
    widths = imgSizes(:,2);
    [sortedHeights,sortOrder] = sort(heights,"descend");
    sortedWidths = widths(sortOrder);
    sortedFilenames = imgNames(sortOrder);
    sortedSizes = [sortedHeights,sortedWidths];
    % numel(sortedFilenames)
    % numel(unique(sortedFilenames))
    % pause
    % for i = 3:length(imgFiles)
    % 
    % 
    % 
    %    if exist('fullInfo')
    %        fullInfo = cat(1,fullInfo,[info.Height,info.Width]);
    %    else
    %        fullInfo = [info.Height,info.Width];
    %    end
    % end
end