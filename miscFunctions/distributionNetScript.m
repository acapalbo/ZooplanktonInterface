%% Read in Data
clc; clear;
% 
% [organismGradMag,organismGradDir,organismDatasets] = fitImageGradientHists("C:\Users\acapalbo\Desktop\PID_histogram_dataset\organisms");
% [noiseGradMag,noiseGradDir,noiseDatasets] = fitImageGradientHists("C:\Users\acapalbo\Desktop\PID_histogram_dataset\noiseImages");

organismPixelHist = fitImageHists("C:\Users\acapalbo\Desktop\PID_histogram_dataset\organisms",128);
noisePixelHist = fitImageHists("C:\Users\acapalbo\Desktop\PID_histogram_dataset\noiseImages",128);
%% Setup network + train/test split
x = cat(1,cell2mat(organismPixelHist),cell2mat(noisePixelHist));
y = cat(1,repmat([0 1],length(organismPixelHist),1),repmat([1 0],length(noisePixelHist),1));

[coeff,score,latent,tsquared,explained] = pca(x);
scatter3(score(:,1),score(:,2),score(:,3))
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
idx = find(cumsum(explained)>95,1);
pcaX = score(:,1:idx);

trainRatio = 0.7;
valRatio = 0.1;
testRatio = 1 - trainRatio+valRatio;
n_samples = length(x);
% Randomly shuffle the data indices
randIndices = randperm(n_samples);
trainInd = randIndices(1:round(trainRatio * n_samples)); % Training data
valInd = randIndices(round(trainRatio * n_samples) + 1:round((trainRatio+valRatio) * n_samples));
testInd = randIndices(round((trainRatio+valRatio) * n_samples) + 1 : end); % Testing data

xtrain =x(trainInd,:);
ytrain = y(trainInd,:);
xVal =x(valInd,:);
yVal = y(valInd,:);
xtest =x(testInd,:);
ytest = y(testInd,:);

dlXtrain = dlarray(reshape(xtrain',1,1,128,[]),"SSCB");
dlYtrain = dlarray(ytrain',"CB");
dlXVal = dlarray(reshape(xVal',1,1,128,[]),"SSCB");
dlYVal = dlarray(yVal',"CB");
dlXtest = dlarray(reshape(xtest',1,1,128,[]),"SSCB");
dlYtest = ytest;

xtrainPCA =pcaX(trainInd,:);
ytrainPCA = y(trainInd,:);
xValPCA = pcaX(valInd,:);
yValPCA = y(valInd,:);
xtestPCA =pcaX(testInd,:);
ytestPCA = y(testInd,:);


numHidden = 256;

options = trainingOptions("sgdm", ...
"MaxEpochs", 100, ...
"MiniBatchSize", numHidden, ...
"InitialLearnRate", 0.0001, ...
"ValidationData",{xVal,yVal},...
"ValidationPatience",50,...
"Shuffle", "every-epoch", ...
"Verbose", true, ...
"Plots", "training-progress",...
Metrics="accuracy");

options2 = trainingOptions("sgdm", ...
"MaxEpochs", 100, ...
"MiniBatchSize", numHidden, ...
"InitialLearnRate", 0.0001, ...
"ValidationData",{dlXVal,dlYVal},...
"ValidationPatience",50,...
"Shuffle", "every-epoch", ...
"Verbose", true, ...
"Plots", "training-progress",...
Metrics="accuracy");

optionsPCA = trainingOptions("sgdm", ...
"MaxEpochs", 100, ...
"MiniBatchSize", numHidden, ...
"InitialLearnRate", 0.0001, ...
"ValidationData",{xValPCA,yValPCA},...
"ValidationPatience",50,...
"Shuffle", "every-epoch", ...
"Verbose", true, ...
"Plots", "training-progress",...
Metrics="accuracy");


net_1 = setup_distributionNet(128,numHidden);
net_2 = setup_distributionNetV2(128);
pcaNet = setup_distributionNet(idx,numHidden);
%% Train network

net = trainnet(xtrain,ytrain,net_1,"crossentropy",options);
net_2 = trainnet(dlXtrain,dlYtrain,net_2,"crossentropy",options2);
netPCA = trainnet(xtrainPCA,ytrainPCA,pcaNet,"crossentropy",optionsPCA);

%% Predictions
preds = predict(net,xtest);
preds2 = predict(net_2,dlXtest);
predsPCA = predict(netPCA,xtestPCA);

[~,idx] = max(preds,[],2);
[~,idx2] = max(preds2,[],1);
[~,idxPCA] = max(predsPCA,[],2);

extractedIdx = extractdata(idx2);
[~,correctIdx] = max(ytest,[],2);
[~,correctIdx2] = max(ytest,[],2);
[~,correctIdxPCA] = max(ytestPCA,[],2);

accuracy = mean(idx == correctIdx)
accuracy2 = mean(extractedIdx ==  correctIdx2')
accuracyPCA = mean(idxPCA == correctIdxPCA)


