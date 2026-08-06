clear;clc;close all
dataSetPrepared = true;
tStart = tic;
% dataSetPath = "C:\Users\acapalbo\ZooplanktonInterface\PreparedDatasetAugmentedDataSetV_5.1";
% rawDataSetPath = "C:\Users\acapalbo\Desktop\Combined_DataSet_v4.0";
% rawDataSetPath = "C:\Users\acapalbo\ZooplanktonInterface\PreparedDatasetAugmentedDataSetV_5.1";

% dataSetPath = "C:\Users\acapalbo\HBOI_Work\PreparedDatasetAugmentedDataSetV_6.1";

% dataSetPath = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 23-05-27.396\MyCamera-003-2024-08-28 23-06-54.207.avi_OrganismDensityCalc\PreparedDatasetMyCamera-003-2024-08-28 23-06-54.207";
outputPath = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 20-51-18.659_2024-08-29 00-32-23.495_niche";
scoreOutputPath = "D:\NicheUncertainties";
dataTitle = split(outputPath,"\");
dataTitle = dataTitle(end);
outputFiles = dir(outputPath);
baseOutput = split(outputPath,"_niche");
baseOutput = baseOutput(1);
baseFiles = dir(baseOutput);
totalScores = {};
totalB = {};
N = 10;
M = 2*N + 1;
for z = 3:length(outputFiles)
    tempFiles = dir(fullfile(baseOutput,baseFiles(z).name));
    tempFiles = struct2table(tempFiles);
    tempNames = tempFiles.name;
    preparedPath = tempNames(contains(tempNames,"Prepared"));
    if ~isempty(preparedPath)
        imgSizes = readmatrix(fullfile(baseOutput,baseFiles(z).name,preparedPath,"imgSizes.csv"),"OutputType","string");

        tempDataset = fullfile(outputPath,outputFiles(z).name);
        datasetFiles = struct2table(dir(tempDataset));
        dataNames = datasetFiles.name;
        datasetPath = dataNames(contains(dataNames,"ClassificationOutput"));
        imds = imageDatastore(fullfile(tempDataset,datasetPath), ...
            IncludeSubfolders=true, ...
            LabelSource="foldernames");

        % [imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,0.7,0.15,0.15,"randomized");


        testingSizes = [0,0];
        for k = 1:length(imds.Files)
            strParts = strsplit(string(imds.Files(k)),'\');
            testingSizes = cat(1,testingSizes,[imgSizes(imgSizes(:,2) == strParts(end),1:2)]);
        end
        testingSizes = double(testingSizes(2:end,:));

        testingData = combine(imds,arrayDatastore(testingSizes));

        allScores = {};
        allB = {};
        netDirPath = "C:\Users\acapalbo\ZooplanktonInterface\uncertaintyNetworksNiche";
        netDir = dir(netDirPath);
        for k = 1:M
            % net_1 = setupNetworkAdaptedXceptionDualInput([229,229],6);
            % net_1 = setupNetworkAdaptedGoogle365DualInput([229,229],6);
            load(fullfile(netDirPath,netDir(k+2).name))
            % trainedNet = trainnet(trainingData,net_1,"crossentropy",TrainingOptions);

            % save(fullfile("uncertaintyNetworks",sprintf("uncertaintyNet_%g",z)),"trainedNet");
            scores = minibatchpredict(trainedNet,testingData);




            allScores = cat(1,allScores,{scores});

        end
        totalScores = cat(1,totalScores,{allScores});
    end
end
save(fullfile(scoreOutputPath,strcat(dataTitle,"_uncertainties.mat")),"totalScores")
%%
% 
% b = zeros(N+1,6);
% [~,predLabels] = max(scores,[],2);
% for l = 1:size(predLabels,1)
%     % positiveScores = networkScores >= 0.5;
%     % tempLabels = scores2label(networkScores,unique(imdsTest.Labels));
%     for m = 1:6
%         x = nnz(predLabels == m);
%         if nnz(x <= N)
%             b(x+1,m) = b(x+1,m) + 1;
%         else
%             b(2*N+2-x,m) = b(2*N+2-x,m) + 1;
%         end
%     end
% end
% allB = cat(1,allB,{b});
% 
% totalB = cat(1,totalB,{allB});