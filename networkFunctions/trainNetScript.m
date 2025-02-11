clear
dataSetPrepared = true;
%dataSetPath = "C:\Users\acapalbo\ZooplanktonInterface\AugmentedDataset_v4.0";
% rawDataSetPath = "C:\Users\acapalbo\Desktop\Combined_DataSet_v4.0";
rawDataSetPath = "C:\Users\acapalbo\Desktop\Combined_DataSet_v4.0_Augmented";
DatasetTitle = "AugmentedDataSetV4_Google_w_batch";
if dataSetPrepared
    dataSetPath = fullpath(pwd,strcat("PreparedDataset",DatasetTitle));
    imgKey = reconstructKey(fullfile(pwd,strcat("imgKey",DatasetTitle)));
    disp("madeIt!")
else
    [imgKey,dataSetPath] = prepareDataset(pwd,rawDataSetPath,[229,229],string(1:4),DatasetTitle);
end
% net_1 = setupNetworkAdaptedXceptionDualInput();
net_1 = setupNetworkAdaptedGoogle365DualInput([229,229],4);
imds = imageDatastore(dataSetPath, ...
    IncludeSubfolders=true, ...
    LabelSource="foldernames");
trainingSizes = [0,0,0,0];
[imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,0.7,0.15,0.15,"randomized");
for z = 1:length(imdsTrain.Files)
    strParts = strsplit(string(imdsTrain.Files(z)),'\');
    trainingSizes = cat(1,trainingSizes,[imgKey(any(imgKey == strParts(end),2),:)]);
end
validationSizes = [0,0,0,0];
for z = 1:length(imdsValidation.Files)
    strParts = strsplit(string(imdsValidation.Files(z)),'\');
    validationSizes = cat(1,validationSizes,[imgKey(any(imgKey == strParts(end),2),:)]);
end
testingSizes = [0,0,0,0];
for z = 1:length(imdsTest.Files)
    strParts = strsplit(string(imdsTest.Files(z)),'\');
    testingSizes = cat(1,testingSizes,[imgKey(any(imgKey == strParts(end),2),:)]);
end
valSizesOG = validationSizes;
trainSizesOG = trainingSizes;
testingSizesOG = testingSizes;
testingSizes = arrayDatastore(double(testingSizes(2:end,3:4)));
validationSizes = arrayDatastore(double(validationSizes(2:end,3:4)));
trainingSizes = arrayDatastore(double(trainingSizes(2:end,3:4)));

imageAugmenter = imageDataAugmenter( ...
    'RandRotation',[-20,20], ...
    'RandXTranslation',[-3 3], ...
    'RandScale',[1,2],...
    'RandYTranslation',[-3 3],...
    'RandXReflection',1,...
    'RandYReflection',1);
%auimds = augmentedImageDatastore([299,299],imdsTrain,"DataAugmentation",imageAugmenter);
%auimdsVal = augmentedImageDatastore([299,299],imdsValidation,"DataAugmentation",imageAugmenter);
% trainingImgs = imdsTrain.readall;
% imgsCat = cell2mat(trainingImgs);
% imgsCatTrain = reshape(permute(imgsCat,[2 1]),299,299,1,[]);
% 
% valImgs = imdsValidation.readall;
% imgsCat2 = cell2mat(valImgs);
% imgsCatVal = reshape(permute(imgsCat2,[2 1]),299,299,1,[]);
% dsX1train = arrayDatastore(imgsCatTrain,"IterationDimension",4);
% dsX1Val = arrayDatastore(imgsCatVal,"IterationDimension",4);
valData = combine(imdsValidation,validationSizes,arrayDatastore(imdsValidation.Labels));
trainingData = combine(imdsTrain,trainingSizes,arrayDatastore(imdsTrain.Labels));
testingData = combine(imdsTest,testingSizes,arrayDatastore(imdsTest.Labels));
TrainingOptions = trainingOptions("sgdm", ...
    MaxEpochs=15, ...
    MiniBatchSize=64, ...
    ValidationData=valData, ...
    ValidationFrequency=25, ...
    LearnRateSchedule="piecewise",...
    Plots="none", ...
    Metrics="accuracy", ...
    InitialLearnRate=0.01, ...
    ExecutionEnvironment="gpu",...
    LearnRateDropPeriod=5,...
    LearnRateDropFactor=0.2,...
    Shuffle="every-epoch",...
    Verbose=true);
% Uncomment to generate net
%net = setupNetworkAdaptedXception([227,227,1],4);
trainedNet = trainnet(trainingData,net_1,"crossentropy",TrainingOptions);


scores = minibatchpredict(trainedNet,testingData);

correctLabels = categorical(imdsTest.Labels);
labels = scores2label(scores,unique(imdsTest.Labels));
accuracy = mean(labels == correctLabels);

fprintf("PreCalibrated Accuracy: %.2f\n",accuracy);
[imdsTest1,imdsTest2] = splitEachLabel(imdsTest,0.50,0.50,"randomized");
calTestingSizes1 = [0,0,0,0];
for z = 1:length(imdsTest1.Files)
    strParts = strsplit(string(imdsTest1.Files(z)),'\');
    calTestingSizes1 = cat(1,calTestingSizes1,[imgKey(any(imgKey == strParts(end),2),:)]);
end
calTestingSizes2 = [0,0,0,0];
for z = 1:length(imdsTest2.Files)
    strParts = strsplit(string(imdsTest2.Files(z)),'\');
    calTestingSizes2 = cat(1,calTestingSizes2,[imgKey(any(imgKey == strParts(end),2),:)]);
end
calTestingSizes1 = arrayDatastore(double(calTestingSizes1(2:end,3:4)));
calTestingSizes2 = arrayDatastore(double(calTestingSizes2(2:end,3:4)));
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
    % predLabels = predLabels - 1;
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
[~,newLabels] = max(totalConf,[],2);
fprintf("<strong>Final Accuracy: %.2f\n</strong>",mean(newLabels == correctLabelstest2))
figure
cm = confusionchart(correctLabelstest2,uint16(newLabels));
save(strcat(DatasetTitle,"_trainedNet"),"")