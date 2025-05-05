clear
dataSetPrepared = true;
% dataSetPath = "C:\Users\acapalbo\ZooplanktonInterface\PreparedDatasetAugmentedDataSetV_5.1";
% rawDataSetPath = "C:\Users\acapalbo\Desktop\Combined_DataSet_v4.0";
% rawDataSetPath = "C:\Users\acapalbo\ZooplanktonInterface\PreparedDatasetAugmentedDataSetV_5.1";
dataSetPath = "C:\Users\acapalbo\ZooplanktonInterface\PreparedDatasetAugmentedDataSetV_5.2";
rawDataSetPath = "C:\Users\acapalbo\ZooplanktonInterface\PreparedDatasetAugmentedDataSetV_5.2";
DatasetTitle = "AugmentedDataSetV_5.2";
% networkArch = "GoogLe365";
networkArch = "ResNet";
% networkArch = "google365_w_batch";
OODdataPath = "C:\Users\acapalbo\MatlabWorkspace\PreparedDatasetOODdataset600imgs";

if dataSetPrepared
    % dataSetPath = fullfile(pwd,strcat("PreparedDataset",DatasetTitle,"\DataSet"));
    imgSizes = readmatrix(fullfile(dataSetPath,"imgSizes.csv"));
    disp("madeIt!")
else
    [imgKey,dataSetPath] = prepareDataset(pwd,rawDataSetPath,[229,229],string(1:2),DatasetTitle);
    imgSizes = double(imgKey(:,3:4));
    imgSizes = cat(2,imgSizes,(1:length(imgSizes))');
end

% net_1 = setupNetworkAdaptedXceptionDualInput();
%net_1 = setupNetworkAdaptedXceptionDualInput();
net_1 = setupNetworkAdaptedResnetDualInput([229,229],2);
% net_1 = setupNetworkAdaptedGoogle365DualInput([229,229],7);
% net_1 = setupNetworkAdaptedXceptionDualInput_batch([229,229],2);

imds = imageDatastore(dataSetPath, ...
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
    MaxEpochs=5, ...
    MiniBatchSize=128, ...
    ValidationData=valData, ...
    ValidationFrequency=50, ...
    LearnRateSchedule="piecewise",...
    Plots="none", ...
    Metrics="accuracy", ...
    InitialLearnRate=0.01, ...
    ExecutionEnvironment="gpu",...
    LearnRateDropPeriod=5,...
    LearnRateDropFactor=0.2,...
    Shuffle="every-epoch",...
    OutputNetwork="best-validation",...
    ValidationPatience=50,...
    Verbose=true);

trainedNet = trainnet(trainingData,net_1,"crossentropy",TrainingOptions);


scores = minibatchpredict(trainedNet,testingData);

correctLabels = categorical(imdsTest.Labels);
labels = scores2label(scores,unique(imdsTest.Labels));
accuracy = mean(labels == correctLabels);

fprintf("PreCalibrated Accuracy: %.2f\n",accuracy);

[imdsTest1,imdsTest2] = splitEachLabel(imdsTest,0.50,0.50,"randomized");

calTestingSizes1 = [0,0];

for z = 1:length(imdsTest1.Files)
    strParts = strsplit(string(imdsTest1.Files(z)),'\');
    calTestingSizes1 = cat(1,calTestingSizes1,[imgSizes(any(imgSizes == double(extract(strParts(end),digitsPattern)),2),1:2)]);
end

calTestingSizes2 = [0,0];
for z = 1:length(imdsTest2.Files)
    strParts = strsplit(string(imdsTest2.Files(z)),'\');
    calTestingSizes2 = cat(1,calTestingSizes2,[imgSizes(any(imgSizes == double(extract(strParts(end),digitsPattern)),2),1:2)]);
end

calTestingSizes1 = arrayDatastore(double(calTestingSizes1(2:end,:)));
calTestingSizes2 = arrayDatastore(double(calTestingSizes2(2:end,:)));

calTestingData1 = combine(imdsTest1,calTestingSizes1,arrayDatastore(imdsTest1.Labels));
calTestingData2 = combine(imdsTest2,calTestingSizes2,arrayDatastore(imdsTest2.Labels));

correctLabelstest1 = uint16(imdsTest1.Labels);
correctLabelstest2 = uint16(imdsTest2.Labels);

scores = minibatchpredict(trainedNet,calTestingData1);
scores2 = minibatchpredict(trainedNet,calTestingData2);

classNames = 1:size(scores,2);
stepSize = 100;

for i = 1:size(scores,2)
    fprintf("<strong>Class %d:\n</strong>",i)
    tempScores1 = scores(:,i);
    tempCorrect1 = correctLabelstest1 == i;
    tempScores2 = scores2(:,i);
    tempCorrect2 = correctLabelstest2 == i;
    tempOthers = sum(scores(:,classNames ~= i));
    tempOthers2 = sum(scores2(:,classNames ~= i));

    predLabels = tempScores1 >= 0.5;
    fprintf("PreCalibration Accuracy Sample Set 1: %.2f\n",mean(tempCorrect1 == predLabels));
    predLabels = tempScores2 >= 0.5;
    fprintf("PreCalibration Accuracy Sample Set 2: %.2f\n",mean(tempCorrect2 == predLabels));
    [posFrequency,confXvalues]= convertScores(stepSize,tempScores1,tempCorrect1);


    confXvalues(posFrequency == 0) = [];
    posFrequency(posFrequency == 0) = [];

    [~,boundaries] = isotonicReg(posFrequency,1:length(posFrequency));

    [theta,calibratedConf] = generateThetaIsotonic(tempCorrect1,tempScores1,tempScores2,confXvalues(boundaries));
    confidenceBoundaries = confXvalues(boundaries);
    predLabels = calibratedConf > 0.5;

    fprintf("Final Accuracy: %.2f\n",mean(tempCorrect2 ==predLabels));
    plotBinsStatic(stepSize,tempScores1,tempCorrect1,"Noncalibrated Reliability")
    plotBinsIsotonic(confXvalues(boundaries),calibratedConf,tempCorrect2,"Calibrated Reliability")

    if exist("totalConf")
        totalTheta = cat(2,totalTheta,{theta});
        totalConf = cat(2,totalConf,calibratedConf);
        totalBoundaries = cat(2,totalBoundaries,{confidenceBoundaries});
    else
        totalConf = calibratedConf;
        totalTheta = {theta};
        totalBoundaries = {confidenceBoundaries};
    end
end

OODimgSet = fullfile(OODdataPath,"DataSet");
OODdata = imageDatastore(OODimgSet, ...
    IncludeSubfolders=true, ...
    LabelSource="foldernames");
OODsizes = readmatrix(fullfile(OODdataPath,"imgSizes.csv"));
OODsizes = OODsizes(:,1:2);
% OODdataSet = combine(OODdata,arrayDatastore(OODsizes),arrayDatastore(OODdata.Labels));
OODdataSet = combine(OODdata,arrayDatastore(OODsizes));
originalTestLabels = imdsTest.Labels;
IDtestingData = imdsTest;

% IDtestingData.Labels = repmat(2,length(IDtestingData.Labels),1);
% ID_ODimgs = 
% IDtestingDataFull = combine(IDtestingData,arrayDatastore(testingSizes),arrayDatastore(IDtestingData.Labels));
IDtestingDataFull = combine(IDtestingData,arrayDatastore(testingSizes));

OODdataSetFull = combine(OODdataSet,IDtestingDataFull,ReadOrder="sequential");


trainingScoresOOD = minibatchpredict(trainedNet,OODdataSet,"Outputs","batchnorm");
trainingScoresID = minibatchpredict(trainedNet,IDtestingDataFull,"Outputs","batchnorm");
% SVMseperator = fitcsvm(trainingScoresOOD,cat(1,OODdata.Labels,categorical(repmat(2,[length(imdsTest.Labels),1]))),"KernelFunction","polynomial","ClassNames",[1 2]);
% SVMseperator = fitclinear(trainingScoresID,categorical(repmat(2,[length(imdsTest.Labels),1])));

[~,newLabels] = max(totalConf,[],2);
fprintf("<strong>Final Accuracy: %.2f\n</strong>",mean(newLabels == correctLabelstest2))
figure
cm = confusionchart(correctLabelstest2,uint16(newLabels));
arr = classAccPreRec(correctLabelstest2,uint16(newLabels));

[coeff,PCAscore,latent,tsquared,explained,mu]  = pca(trainingScoresID);
% [~,OODscores,~,~,~,~] = pca(trainingScoresOOD);
idx_95 = find(cumsum(explained)>95,1);
OODscores = (trainingScoresOOD-mu)*coeff(:,1:idx_95);
% [SVMseperator,tf,SVMscores] = ocsvm(trainingScoresID(double(imdsTest.Labels) == 1,:));
[trainedSeperator,tf,SVMscores] = ocsvm(trainingScoresID);
% save(strcat(DatasetTitle,"_trainedNet_",networkArch,"_",string(datetime("today","Format","DD_MM_yy"))),"")

% % [SVMseperator,tf,SVMscores] = iforest(trainingScoresID);
% % [SVMseperator,tf,SVMscores] = rrcforest(PCAscore(:,1:idx_95));
% [tf,scores] =isanomaly(SVMseperator,OODscores);
% h = histogram(SVMscores);
% [maxcount, whichbin] = max(h.Values);
% hold on
% histogram(scores)
% xline(SVMseperator.ScoreThreshold,"r-",["Threshold" SVMseperator.ScoreThreshold])
% hold off
% title("Full Testing Set vs OOD Images")
% 
% figure
% [SVMseperator,tf,SVMscores] = rrcforest(trainingScoresID);
% [tf,scores] =isanomaly(SVMseperator,trainingScoresOOD);
% h = histogram(SVMscores);
% [maxcount, whichbin] = max(h.Values);
% hold on
% histogram(scores)
% xline(SVMseperator.ScoreThreshold,"r-",["Threshold" SVMseperator.ScoreThreshold])
% hold off
% title("Full Testing Set vs OOD Images")
% for z = 1:numel(classNames)
% subplot(2,2,z);
% 
% [SVMseperator,tf,SVMscores] = rrcforest(PCAscore(imdsTest.Labels == categorical(z),1:idx_95));
% 
% [tf,scores] =isanomaly(SVMseperator,OODscores);
% h = histogram(SVMscores);
% [maxcount, whichbin] = max(h.Values);
% hold on
% histogram(scores)
% xline(SVMseperator.ScoreThreshold,"r-",["Threshold" SVMseperator.ScoreThreshold])
% hold off
% title(sprintf("Class %g vs OOD images",z))
% % text(SVMseperator.ScoreThreshold,maxcount,string(nnz(tf)/length(OODscores)))
% end
% idx = kmeans(PCAscore,4);
% scatter3(score(:,1),score(:,2),score(:,3),20,idx)
% hold on
% scatter3(OODscores(:,1),OODscores(:,2),OODscores(:,3),'.')
% hold off
% mean(double(imdsTest.Labels) == idx)
