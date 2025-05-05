%% Read in Data
clear; clc;
% dataSetPath = "C:\Users\acapalbo\Desktop\SimulatedDataset";
dataSetPath = "C:\Users\acapalbo\Desktop\sortingTesting_043025\DataSet_MyCamera-004-2024-08-28 20-53-36.366precise_ff";

imds = imageDatastore(dataSetPath, ...
IncludeSubfolders=true, ...
LabelSource="foldernames");

numBins = 90;
numImages = length(imds.Labels);
[totalYMag,totalYDir,datasetForm,imageFiles] = fitImageGradientHists(dataSetPath,numBins);
%% Seperate bubbles

x = linspace(-180,180,numBins);
bubbleMarker = [];
maxDirs = [];
for z = 1:length(totalYDir)
    tempDir = cell2mat(totalYDir(z));
    idx = find(tempDir == max(tempDir));
    if idx >= 45 & idx <= 46 & max(tempDir)*100 >= 1
        bubbleMarker = cat(1,bubbleMarker,1);
    else
        bubbleMarker = cat(1,bubbleMarker,0);
    end
    maxDirs = cat(1,maxDirs,max(tempDir));
end

bubbleImgs = imageFiles(logical(bubbleMarker));
resizedImgs = [];
for z = 1:length(bubbleImgs)
    tempImg = cell2mat(bubbleImgs(z));
    tempImg = imresize(tempImg,[100,100]);
    resizedImgs = cat(3,resizedImgs,tempImg);
% imshow(cell2mat(bubbleImgs(z)))
% pause(1.5)
end
% tiledImg = imtile(resizedImgs);
% imshow(tiledImg)
%% Gradient threshold

maxMags = [];
maxDirs = [];
meanmags = [];
cellImds = {};

while imds.hasdata
    tempImg = imds.read;
    
    [Gmag,Gdir] = imgradient(tempImg);
    maxMags = cat(1,maxMags,max(Gmag(:)));
    maxDirs = cat(1,maxDirs,max(Gdir(:)));
    meanMags = cat(1,meanmags,mean(Gmag(:)));
    cellImds = cat(1,cellImds,{tempImg});
end

% Sort based on gradients
gradientThresh = mean(maxMags) - std(maxMags);
imds.reset;
focusMarker = [];
mkdir GradientThresholdSort
mkdir GradientThresholdSort\lowFocus
mkdir GradientThresholdSort\highFocus
z = 1;
while imds.hasdata
    tempimg = imds.read;
    maxG = maxMags(z);
    if maxG < gradientThresh
        imwrite(tempimg,strcat("GradientThresholdSort/lowFocus/",string(z),".png"))
        focusMarker = cat(1,focusMarker,1);
    else
        imwrite(tempimg,strcat("GradientThresholdSort/highFocus/",string(z),".png"))
        focusMarker = cat(1,focusMarker,0);
    end
    z= z + 1;
end
focusMarker = logical(focusMarker);

%% Minimum interior

% imds = imagedatastore(fullfile(pwd,"GradientThresholdSort/highFocus/"), ...
% IncludeSubfolders=true, ...
% LabelSource="foldernames");
imds.reset;
lineMarker = [];
data = [];
se0 = strel('line',2,0);
se90 = strel('line',2,90);
poolObj = parpool("Threads");
% while imds.hasdata
parImages = pararllel.pool.Costant(cellImds);
parfor(z=1:numImages,poolObj)
    tempImg = imds.read;
    tempBw = tempImg/256 < graythresh(tempImg);
    tempDil = imdilate(tempBw,[se0,se90]);
    tempOpen = bwareaopen(tempDil,50,4);
    tempFill = imfill(tempOpen,"holes");
    CC = bwconncomp(tempFill);
    p = regionprops(CC,"Area");
    if size(p,1) > 1
    [maxArea,maxIdx] = max([p.Area]);
    BW2 = cc2bw(CC,ObjectsToKeep=maxIdx);
    tempFill = BW2;
    end
    perimBw = bwperim(tempFill);
    % figure
    % imshow(perimBw)
    % pause
    % close all

    [tempDistance,tempEndPoints,tempCoords] = perimeterDist(perimBw);
    % tempIdx = sub2ind(size(perimBw),tempEndPoints(:,2),tempEndPoints(:,1));
    % tempLineImg = perimBw;
    % tempLineImg(tempCoords) = 1;
    % imshow(tempLineImg)
    % pause
    tempHyp = sqrt((size(perimBw,1)^2)+(size(perimBw,2)^2));
    tempDistance;
    if tempDistance / tempHyp < 0.3
        lineMarker = cat(1,lineMarker,1);
    else
        lineMarker = cat(1,lineMarker,0);
    end
    data = cat(1,data,[tempDistance,tempHyp]);
end
lineMarker = logical(lineMarker);
%% End of algorithm

trashMarkers = bubbleMarker | focusMarker | lineMarker;
organismMarkers = ~trashMarkers;

trashImgs = cellImds(trashMarkers);

focusImgs = cellImds(focusMarker);
lineImgs = cellImds(lineMarker);
organismImgs = cellImds(organismMarkers);
resizedTrash = [];
for z = 1:length(trashImgs)
    tempImg = cell2mat(trashImgs(z));
    tempResized = imresize(tempImg,[100,100]);
    resizedTrash = cat(3,resizedTrash,tempResized);
end
resizedOrganisms = [];
for z = 1:length(organismImgs)
    tempImg = cell2mat(organismImgs(z));
    tempResized = imresize(tempImg,[100,100]);
    resizedOrganisms = cat(3,resizedOrganisms,tempResized);
end

resizedFocus = [];
for z = 1:length(focusImgs)
    tempImg = cell2mat(focusImgs(z));
    tempResized = imresize(tempImg,[100,100]);
    resizedFocus = cat(3,resizedFocus,tempResized);
end


resizedLine = [];
for z = 1:length(lineImgs)
    tempImg = cell2mat(lineImgs(z));
    tempResized = imresize(tempImg,[100,100]);
    resizedLine = cat(3,resizedLine,tempResized);
end


tiledTrash = imtile(resizedTrash);
tiledOrganisms = imtile(resizedOrganisms);
tiledFocus = imtile(resizedFocus);
tiledLine = imtile(resizedLine);
figure()
imshow(tiledTrash)
title("All Trash")
figure()
imshow(tiledFocus)
title("Out of Focus")
figure()
imshow(tiledLine)
title("Line images")
figure()
imshow(tiledOrganisms)
title("Organism Images")

mkdir SeperatedOrganisms
for z = 1:length(organismImgs)
    tempImg = cell2mat(organismImgs(z));
    imwrite(tempImg,fullfile(pwd,"SeperatedOrganisms",strcat(string(z),".png")))
end