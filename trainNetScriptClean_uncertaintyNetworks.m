clear;clc;close all
dataSetPrepared = true;
tStart = tic;
% dataSetPath = "C:\Users\acapalbo\ZooplanktonInterface\PreparedDatasetAugmentedDataSetV_5.1";
% rawDataSetPath = "C:\Users\acapalbo\Desktop\Combined_DataSet_v4.0";
% rawDataSetPath = "C:\Users\acapalbo\ZooplanktonInterface\PreparedDatasetAugmentedDataSetV_5.1";

% dataSetPath = "C:\Users\acapalbo\HBOI_Work\PreparedDatasetAugmentedDataSetV_6.1";

% dataSetPath = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 23-05-27.396\MyCamera-003-2024-08-28 23-06-54.207.avi_OrganismDensityCalc\PreparedDatasetMyCamera-003-2024-08-28 23-06-54.207";
dataSetPath = "C:\Users\acapalbo\HBOI_Work\PreparedDatasetAugmentedDataSet_NicheNetwork";
DatasetTitle = "AugmentedDataSet_niche";
networkArch = "GoogLe365";
% networkArch = "ResNet";
% networkArch = "DarkNet";
% networkArch = "Xception";
% networkArch = "google365_w_batch";
N = 10;
M = 2*N + 1;
basePath = "uncertaintyNetworksNiche";

mkdir(basePath)
if dataSetPrepared
    imgSizes = readmatrix(fullfile(dataSetPath,"imgSizes.csv"));
    disp("madeIt!")
else
    [imgKey,dataSetPath] = prepareDataset(pwd,dataSetPath,[229,229],string(1:6),DatasetTitle);
    imgSizes = double(imgKey(:,3:4));
    imgSizes = cat(2,imgSizes,(1:length(imgSizes))');
end

% net_1 = setupNetworkAdaptedXceptionDualInput();
%net_1 = setupNetworkAdaptedXceptionDualInput();
% net_1 = setupNetworkAdaptedResnetDualInput([229,229],6);
% net_1 = setupNetworkAdaptedDarkNetDualInput([229,229],6);


imds = imageDatastore(fullfile(dataSetPath,"DataSet"), ...
    IncludeSubfolders=true, ...
    LabelSource="foldernames");

[imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,0.7,0.15,0.15,"randomized");

trainingSizes = [0,0];
for z = 1:length(imdsTrain.Files)
    strParts = strsplit(string(imdsTrain.Files(z)),'\');
    trainingSizes = cat(1,trainingSizes,[imgSizes(imgSizes(:,3) == double(extract(strParts(end),digitsPattern)),1:2)]);
end
trainingSizes = trainingSizes(2:end,:);
validationSizes = [0,0];
for z = 1:length(imdsValidation.Files)
    strParts = strsplit(string(imdsValidation.Files(z)),'\');
    validationSizes = cat(1,validationSizes,[imgSizes(imgSizes(:,3) == double(extract(strParts(end),digitsPattern)),1:2)]);
end
validationSizes = validationSizes(2:end,:);
testingSizes = [0,0];
for z = 1:length(imdsTest.Files)
    strParts = strsplit(string(imdsTest.Files(z)),'\');
    testingSizes = cat(1,testingSizes,[imgSizes(imgSizes(:,3) == double(extract(strParts(end),digitsPattern)),1:2)]);
end
testingSizes = testingSizes(2:end,:);

valData = combine(imdsValidation,arrayDatastore(validationSizes),arrayDatastore(imdsValidation.Labels));
trainingData = combine(imdsTrain,arrayDatastore(trainingSizes),arrayDatastore(imdsTrain.Labels));
testingData = combine(imdsTest,arrayDatastore(testingSizes));

TrainingOptions = trainingOptions("sgdm", ...
    MaxEpochs=15, ...
    MiniBatchSize=128, ...
    ValidationData=valData, ...
    ValidationFrequency=25, ...
    Metrics="accuracy", ...
    InitialLearnRate=0.1, ...
    ExecutionEnvironment="gpu",...
    Shuffle="every-epoch",...
    OutputNetwork="best-validation",...
    Verbose=true,...
    ValidationPatience=50, ...
    Plots="none");
    % LearnRateSchedule="piecewise",...
    % LearnRateDropPeriod=5,...
    % LearnRateDropFactor=0.2,...
tEnd = toc(tStart);
fprintf("Time taken to prepare datastore: %.2f s or %.2f min\n",tEnd,tEnd/60);
% save(strcat("netTrainingVars\",string(datetime("now","Format","ddMMyy_HH_mm_ss")),"_",networkArch,"trainingVars.mat"),"TrainingOptions","imdsTest","imdsTrain","imdsValidation","valData","trainingData","testingData","imgSizes");
%% train network
% load netTrainingVars\100625_10_15_43_XceptiontrainingVars.mat% 15 epochs
% net_1 = setupNetworkAdaptedDarkNetDualInput([229,229],6);
% networkArch = "Xception";
allScores = {};
netDirPath = "C:\Users\acapalbo\ZooplanktonInterface\uncertaintyNetworks";
netDir = dir(netDirPath);
for z = 1:M
    % net_1 = setupNetworkAdaptedXceptionDualInput([229,229],6);
    net_1 = setupNetworkAdaptedGoogle365DualInput([229,229],6);
trainedNet = trainnet(trainingData,net_1,"crossentropy",TrainingOptions);

save(fullfile(basePath,sprintf("uncertaintyNet_%g",z)),"trainedNet");
scores = minibatchpredict(trainedNet,testingData);
allScores = cat(1,allScores,{scores});
correctLabels = categorical(imdsTest.Labels);
labels = scores2label(scores,unique(imdsTest.Labels));
accuracy = mean(labels == correctLabels);

% fprintf("PreCalibrated Accuracy: %.2f\n",accuracy);

accPrecRec = classAccPreRec(correctLabels,labels);
fprintf("Network %g Accuracy: %.2f\n",z,accuracy);
end

%% 

b = zeros(N+1,6);

for z = 1:size(correctLabels,1)
    networkScores = cellfun(@(x) x(z,:),allScores,"UniformOutput",false);
    networkScores = cell2mat(networkScores);
    % positiveScores = networkScores >= 0.5;
    [~,predLabels] = max(networkScores,[],2);
    % tempLabels = scores2label(networkScores,unique(imdsTest.Labels));
    for k = 1:6
        x = nnz(predLabels == k);
        if nnz(x <= N)
            b(x+1,k) = b(x+1,k) + 1;
        else
            b(2*N+2-x,k) = b(2*N+2-x,k) + 1;
        end
    end
end

