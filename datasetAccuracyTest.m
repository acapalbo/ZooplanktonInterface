function [b1,b2,R1,R2,allScores,numImgs] = datasetAccuracyTest(uncertaintyDirPath,datasetPath,imgKeyPath)
    uncertaintyFiles = dir(uncertaintyDirPath);
    imds = imageDatastore(datasetPath,"IncludeSubfolders",true,"LabelSource","foldernames");
    % imgKey = readmatrix(fullfile(datasetPath,"imgSizes.csv"));
    % imgSizes = arrayDatastore(double(imgKey(:,1:2)));
    imgKey = readtable(imgKeyPath);
    % arr(1:2,:)
    % arr = arr(2:2:end,:);
    % imgKey = strcat(arr(:,1),repmat(" ",size(arr,1),1),arr(:,2));
    % imgKey = cat(2,imgKey,arr(:,3));
    imgSizes = arrayDatastore(datasetImgSizes(datasetPath,imgKey));
    % size(imgSizes)
    % imgSizes = arrayDatastore([imgKey.length,imgKey.width]);%arrayDatastore(datasetImgSizes(datasetPath,rawDatasetPath,imgKey));
    data = combine(imds,imgSizes);
    numImgs = length(imds.Labels);
    allScores = {};
    for z = 3:length(uncertaintyFiles)
        netStruct = load(fullfile(uncertaintyDirPath,uncertaintyFiles(z).name));
        tempNet = netStruct.trainedNet;
        % data
        % tempNet
        scores = minibatchpredict(tempNet,data);        
        allScores = cat(1,allScores,{scores});
    end
    M = length(uncertaintyFiles) - 2;
    N = (M - 1)/2;
    b1 = zeros(N+1,6);
    b2 = zeros(N+1,1);
    for z = 1:numImgs
        networkScores = cellfun(@(x) x(z,:),allScores,"UniformOutput",false);
        networkScores = cell2mat(networkScores);
        % positiveScores = networkScores >= 0.5;
        [~,predLabels] = max(networkScores,[],2);
        % tempLabels = scores2label(networkScores,unique(imdsTest.Labels));
        cumX = [];
        for k = 1:6
            x = nnz(predLabels == k);
            if nnz(x <= N)
                b1(x+1,k) = b1(x+1,k) + 1;
            else
                b1(2*N+2-x,k) = b1(2*N+2-x,k) + 1;
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
    R1 = cumsum(b1)/numImgs;
    R2 = cumsum(b2)/numImgs;
end