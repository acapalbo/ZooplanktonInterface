function [totalY,toWriteimgFiles] = fitImageHists(varargin)
    if isempty(varargin)
        imgPath = uigetdir;
        numBins = 50;
    elseif isscalar(varargin)
        imgPath = string(varargin(1));
        numBins = 50;
    else
        imgPath = string(varargin(1));
        numBins = cell2mat(varargin(2));
    end
    imgFiles = dir(imgPath);
    totalY = {};
    toWriteimgFiles = {};
    for z = 3:length(imgFiles)
        tempImg = imread(fullfile(imgPath,imgFiles(z).name));
        yValues = histcounts(double(tempImg(:))/256,numBins,"BinLimits",[0,1]);
        toWriteimgFiles = cat(1,toWriteimgFiles,tempImg);
        totalY = cat(1,totalY,(yValues)/max(yValues(:)));
    end

    figure()
    hold on
    cmap = jet(length(totalY));
    for z = 1:length(totalY)
        plot(linspace(0,1,numBins),cell2mat(totalY(z)),"Color",cat(2,cmap(z,:),0.5));
    end
end