clc

% imgPath ="D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 23-05-27.396\MyCamera-001-2024-08-28 23-05-27.395.avi_OrganismDensityCalc\PreparedDatasetMyCamera-001-2024-08-28 23-05-27.395\DataSet\1\0008.png";
% imgPath ="D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 23-05-27.396\MyCamera-003-2024-08-28 23-06-54.207.avi_OrganismDensityCalc\PreparedDatasetMyCamera-003-2024-08-28 23-06-54.207\DataSet\1\0133.png";
imgPath = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 23-05-27.396\MyCamera-003-2024-08-28 23-06-54.207.avi_OrganismDensityCalc\PreparedDatasetMyCamera-003-2024-08-28 23-06-54.207\DataSet\1\0137.png";
imgPath = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 23-05-27.396\MyCamera-003-2024-08-28 23-06-54.207.avi_OrganismDensityCalc\PreparedDatasetMyCamera-003-2024-08-28 23-06-54.207\DataSet\1\0608.png";
imgPath = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 23-05-27.396\MyCamera-003-2024-08-28 23-06-54.207.avi_OrganismDensityCalc\PreparedDatasetMyCamera-003-2024-08-28 23-06-54.207\DataSet\1";
imgFiles = dir(imgPath);
networkArr = {};
imgArr = [];
savedNets = ["C:\Users\acapalbo\HBOI_Work\trainedNetworks\adaptedXception_290725_13_42_43_.mat","C:\Users\acapalbo\ZooplanktonInterface\adapted_xception_singleInput.mat",...
    "C:\Users\acapalbo\HBOI_Work\trainedNetworks\adaptedGoogLe365_280725_18_30_13_.mat","C:\Users\acapalbo\ZooplanktonInterface\adapted_google365_singleInput.mat"];
networkTitles = ["Xception Dual Input","Xception Single Input","Google Dual Input","Google Single Input"];
outputLayers = ["block14_sepconv2_act","block14_sepconv2_act","inception_5b-output","inception_5b-output"];
for k = 1:length(savedNets)
loadedNet = load(savedNets(k));
networkArr = cat(1,networkArr,{loadedNet.trainedNet});
end

for z = 3:length(imgFiles)
    tempOutput = [];
    for k = 1:length(savedNets)
img = imread(fullfile(imgPath,imgFiles(z).name));
tempData = combine(imageDatastore(fullfile(imgPath,imgFiles(z).name)),arrayDatastore([0,0]));

imageActivations = minibatchpredict(cell2mat(networkArr(k)),tempData,"Outputs",outputLayers(k));

scores = squeeze(mean(imageActivations,[1 2]));


[~,classIds] = maxk(scores,3);
classActivationMap = imageActivations(:,:,classIds(1));

combImg = CAMshow(img,classActivationMap,false);
combImg = insertText(uint8(combImg),[0,229],networkTitles(k),"AnchorPoint","LeftBottom");
    tempOutput = cat(2,tempOutput,combImg);
    end
    imshow(uint8(tempOutput))
    pause
    imgArr = cat(3,imgArr,tempOutput);
end

function combinedImage = CAMshow(im,CAM,vis)
imSize = size(im);
CAM = imresize(CAM,imSize(1:2));
CAM = normalizeImage(CAM);
CAM(CAM<0.2) = 0;
cmap = jet(255).*linspace(0,1,255)';
CAM = ind2rgb(uint8(CAM*255),cmap)*255;

combinedImage = double(im)/1.25 + CAM;
combinedImage = normalizeImage(combinedImage)*255;
if vis
imshow(uint8(combinedImage));
end
end

function N = normalizeImage(I)
minimum = min(I(:));
maximum = max(I(:));
N = (I-minimum)/(maximum-minimum);
end
