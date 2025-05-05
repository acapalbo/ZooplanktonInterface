function [totalYMag,totalYDir,datasetForm,imageFiles] = fitImageGradientHists(varargin)
    numSamples = 90;
    maxGmag = 0;
    maxGdir = 0;
    minGdir = 0;
    if isempty(varargin)
        imgPath = uigetdir;
    else
        imgPath = string(varargin(1));
    end
    imgFiles = dir(imgPath);
    totalYMag = {};
    totalYDir = {};
    totalGmag = {};
    totalGdir = {};
    datasetForm = {};
    imageFiles = {};
    for z = 3:length(imgFiles)
        tempImg = imread(fullfile(imgPath,imgFiles(z).name));
        imageFiles = cat(1,imageFiles,tempImg);
        [Gmag,Gdir] = imgradient(tempImg(:,:,1));
        totalGmag = cat(1,totalGmag,{Gmag});
        totalGdir = cat(1,totalGdir,{Gdir});
    end
    xValuesMag = linspace(0,400,numSamples);
    xValuesDir = linspace(-180,180,numSamples);
    for z = 1:length(totalGmag)
        tempGmag = cell2mat(totalGmag(z));
        tempGdir = cell2mat(totalGdir(z));
        pdMag = fitdist(tempGmag(:),"Kernel");
        pdDir = fitdist(tempGdir(:),"Kernel");
        yValuesMag = pdMag.pdf(xValuesMag);
        yValuesDir = pdDir.pdf(xValuesDir);
        totalYMag = cat(1,totalYMag,yValuesMag);
        totalYDir = cat(1,totalYDir,yValuesDir);
        datasetForm = cat(1,datasetForm,{cat(2,yValuesMag,yValuesDir)});
    end
    figure()
    hold on
    for z = 1:length(totalYMag)
        plot(linspace(0,400,numSamples),cell2mat(totalYMag(z)),'.');
    end
    figure()
    hold on
    for z = 1:length(totalYDir)
        plot(linspace(-180,180,numSamples),cell2mat(totalYDir(z)),'.');
    end
end