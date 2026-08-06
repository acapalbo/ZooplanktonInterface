clear;clc;close all
dataSetPrepared = true;
tStart = tic;
% dataSetPath = "C:\Users\acapalbo\ZooplanktonInterface\PreparedDatasetAugmentedDataSetV_5.1";
% rawDataSetPath = "C:\Users\acapalbo\Desktop\Combined_DataSet_v4.0";
% rawDataSetPath = "C:\Users\acapalbo\ZooplanktonInterface\PreparedDatasetAugmentedDataSetV_5.1";

% dataSetPath = "C:\Users\acapalbo\HBOI_Work\PreparedDatasetAugmentedDataSetV_6.1";

topLevel_dataSetPath = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-02-27 20-55-00.071_2024-02-28 00-21-00.363(7)";
% dataSetPath = "C:\Users\acapalbo\Desktop\AugmentedNicheDataset";
DatasetTitle = "AugmentedDataSet_baseNetwork";
% networkArch = "GoogLe365";
% networkArch = "ResNet";
% networkArch = "DarkNet";
networkArch = "Xception";
% networkArch = "google365_w_batch";
N = 10;
M = 2*N + 1;
batchAbundanceFiles = dir(topLevel_dataSetPath);
outputs = {};
finalScores = {};
% mkdir uncertaintyNetworks
for j = 3:length(batchAbundanceFiles)
    dataSetPath = fullfile(topLevel_dataSetPath,batchAbundanceFiles(j).name);
    if exist(dataSetPath) ~= 7
        continue
    end
    files = dir(dataSetPath);
    files = struct2table(files);
    fileNames = files.name;
    uniformFilePath = fileNames(contains(fileNames,"Prepared"));
    sortedFilePath = fileNames(contains(fileNames,"ClassificationOutput"));
    sortedFiles = dir(fullfile(dataSetPath,sortedFilePath));
    imgSizes = readmatrix(fullfile(dataSetPath,uniformFilePath,"imgSizes.csv"),"OutputType","string");

    % net_1 = setupNetworkAdaptedXceptionDualInput();
    %net_1 = setupNetworkAdaptedXceptionDualInput();
    % net_1 = setupNetworkAdaptedResnetDualInput([229,229],6);
    % net_1 = setupNetworkAdaptedDarkNetDualInput([229,229],6);



    % trainingSizes = trainingSizes(2:end,:);
    % validationSizes = [0,0];
    % for z = 1:length(imdsValidation.Files)
    %     strParts = strsplit(string(imdsValidation.Files(z)),'\');
    %     validationSizes = cat(1,validationSizes,[imgSizes(imgSizes(:,3) == double(extract(strParts(end),digitsPattern)),1:2)]);
    % end
    % validationSizes = validationSizes(2:end,:);
    % testingSizes = [0,0];
    % for z = 1:length(imdsTest.Files)
    %     strParts = strsplit(string(imdsTest.Files(z)),'\');
    %     testingSizes = cat(1,testingSizes,[imgSizes(imgSizes(:,3) == double(extract(strParts(end),digitsPattern)),1:2)]);
    % end
    % testingSizes = testingSizes(2:end,:);

    % valData = combine(imdsValidation,arrayDatastore(validationSizes),arrayDatastore(imdsValidation.Labels));

    % testingData = combine(imdsTest,arrayDatastore(testingSizes));


    % fprintf("Time taken to prepare datastore: %.2f s or %.2f min\n",tEnd,tEnd/60);
    % save(strcat("netTrainingVars\",string(datetime("now","Format","ddMMyy_HH_mm_ss")),"_",networkArch,"trainingVars.mat"),"TrainingOptions","imdsTest","imdsTrain","imdsValidation","valData","trainingData","testingData","imgSizes");
    %% train network
    % load netTrainingVars\100625_10_15_43_XceptiontrainingVars.mat% 15 epochs
    % net_1 = setupNetworkAdaptedDarkNetDualInput([229,229],6);
    % networkArch = "Xception";
    allScores = {};
    netDirPath = "C:\Users\acapalbo\ZooplanktonInterface\uncertaintyNetworks";
    netDir = dir(netDirPath);
    sampleImgCount = 25;
    % randomPerm = randi(length(imds.Files),sampleImgCount,1);
    allRandomPermScores = {};
    % filenames = imds.Files;
    for z = 1:M
        % net_1 = setupNetworkAdaptedXceptionDualInput([229,229],6);
        % net_1 = setupNetworkAdaptedGoogle365DualInput([229,229],6);
        load(fullfile(netDirPath,netDir(z+2).name))
        % trainedNet = trainnet(trainingData,net_1,"crossentropy",TrainingOptions);
        tempScores = {};
        for m = 1:6
            if size(dir(fullfile(dataSetPath,sortedFilePath,sortedFiles(m+2).name)),1) == 2
                tempScores = cat(2,tempScores,{NaN});
                continue
            end
            imds = imageDatastore(fullfile(dataSetPath,sortedFilePath,sortedFiles(m+2).name), ...
                IncludeSubfolders=true, ...
                LabelSource="foldernames");

            % [imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,0.7,0.15,0.15,"randomized");

            trainingSizes = [];
            for i = 1:length(imds.Files)
                strParts = strsplit(string(imds.Files(i)),'\');
                trainingSizes = cat(1,trainingSizes,imgSizes(imgSizes(:,2) == strParts(end),3:4));
            end
            trainingSizes = double(trainingSizes);
            trainingData = combine(imds,arrayDatastore(trainingSizes),arrayDatastore(imds.Labels));
            % save(fullfile("uncertaintyNetworks",sprintf("uncertaintyNet_%g",z)),"trainedNet");
            scores = minibatchpredict(trainedNet,trainingData);
            tempScores = cat(2,tempScores,{scores});
            correctLabels = categorical(imds.Labels);
            labels = scores2label(scores,string(1:6));
            textLabels = scores2label(scores,["Chaetognath","Crustacean","DetritusA","DetritusB","Gelatinous","Larvacean"]);
            accuracy = mean(labels == correctLabels);
            % allRandomPermScores = cat(1,allRandomPermScores,{scores(randomPerm,:)});
            % fprintf("PreCalibrated Accuracy: %.2f\n",accuracy);
            % sampleDatasetImages(randomPerm,imds,25,textLabels)
            % pause(0.1)
            % accPrecRec = classAccPreRec(correctLabels,labels);
            % fprintf("Network %g Accuracy: %.2f\n",z,accuracy);

        end
        allScores = cat(1,allScores,tempScores);

    end
    finalScores = cat(1,finalScores,{allScores});
end
%%
outputs = {};
for j = 3:length(batchAbundanceFiles)-3

    tempScores = finalScores{j-2};
    tempOutput = {};
    for z = 1:6
            b = zeros(N+1,6);
            b2 = zeros(N+1,1);
                numImgs = size(cell2mat(tempScores(1,z)),1);
        for n = 1:numImgs

            cumX = [];
            networkScores = cellfun(@(x) x(n,:),tempScores(:,z),"UniformOutput",false);
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
                cumX = cat(1,cumX,x);
            end
            [maxAgreeCount,maxAgreeClass] = max(cumX);
            x = maxAgreeCount;
            if nnz(x <= N)
                b2(x+1) = b2(x+1) + 1;
            else
                b2(2*N+2-x) = b2(2*N+2-x) + 1;
            end

        end
            R1 = cumsum(b)/numImgs;
    R2 = cumsum(b2)/numImgs;
    tempOutput = cat(2,tempOutput,[{R1},{R2},{b},{b2}]);

    end

    outputs = cat(1,outputs,tempOutput);
end

% 
% [networkScores,networkLabels] = cellfun(@(x) max(x,[],2),allRandomPermScores,'UniformOutput',false);
% networkLabels = cell2mat(networkLabels');
% agreedLabels = mode(networkLabels,2);
% networkAvgs = mean(networkLabels == mode(networkLabels,2),2);

% figure
% montage(imgsWithText2)
%%

% b = zeros(N+1,6);
% b2 = zeros(N+1,1);
% for z = 1:size(correctLabels,1)
%     cumX = [];
%     networkScores = cellfun(@(x) x(z,:),allScores,"UniformOutput",false);
%     networkScores = cell2mat(networkScores);
%     % positiveScores = networkScores >= 0.5;
%     [~,predLabels] = max(networkScores,[],2);
%     % tempLabels = scores2label(networkScores,unique(imdsTest.Labels));
%     for k = 1:6
%         x = nnz(predLabels == k);
%         if nnz(x <= N)
%             b(x+1,k) = b(x+1,k) + 1;
%         else
%             b(2*N+2-x,k) = b(2*N+2-x,k) + 1;
%         end
%         cumX = cat(1,cumX,x);
%     end
%     [maxAgreeCount,maxAgreeClass] = max(cumX);
%     x = maxAgreeCount;
%     if nnz(x <= N)
%         b2(x+1) = b2(x+1) + 1;
%     else
%         b2(2*N+2-x) = b2(2*N+2-x) + 1;
%     end
% end
%
% R = cumsum(b)/size(correctLabels,1);
% outputs = cat(1,outputs,[{allScores},{b},{R}]);
%
% % function sampleDatasetImages(randomPerm,imds,sampleImgCount,predLabels)
% % fileNames = imds.Files;
% % montageArr = {};
% % for z = 1:sampleImgCount
% %     tempFilepath = cell2mat(fileNames(randomPerm(z)));
% %     tempLabel = predLabels(randomPerm(z));
% %     tempImg = imread(tempFilepath);
% %     tempImg = insertText(tempImg,[1,229],string(tempLabel),"AnchorPoint","LeftBottom","FontSize",20);
% %     montageArr = cat(1,montageArr,tempImg);
% % end
% % montage(montageArr);
% % end