dataSetFilePath = "C:\Users\acapalbo\Desktop\CombinedDataset";
imds = imageDatastore(dataSetFilePath,"IncludeSubfolders",true,"LabelSource","foldernames");
[imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,0.6,0.2,0.2,"randomized");
% poolobj = gcp("nocreate");
% delete(poolobj);
% pool = parpool("Processes");
options = trainingOptions("sgdm", ...
MaxEpochs=70, ...
ValidationData=imdsValidation, ...
ValidationFrequency=15, ...
Plots="training-progress", ...
Metrics="accuracy", ...
ExecutionEnvironment="gpu",...
Verbose=false);
net = trainnet(imdsTrain,net_2,"crossentropy",options);
scores = minibatchpredict(net,imdsTest);
% classList = (repmat([1,2,3,4,5,6],309,1))';
% labels = classList(max(scores) == scores);
classNames = categories(imds.Labels);
correctLabels = imdsTest.Labels;
predictedLabels = scores2label(scores,classNames);
%YTest = categorical(labels);
accuracy = mean(correctLabels == predictedLabels)
plotconfusion(predictedLabels,imdsTest.Labels)
