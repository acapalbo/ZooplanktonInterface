function classCounts = classifySegmentedImagesIsotonic(trainedNetTable,rawdataSetPath,uniformDatasetPath,confidenceThreshold,dirLocation,DatasetTitle,imgKey,useIsotonic)
    if size(dir(uniformDatasetPath),1) > 2
imds = imageDatastore(uniformDatasetPath, ...
    IncludeSubfolders=true, ...
    LabelSource="foldernames");
    filenames = cat(1,imds.Files);
    
    theta = trainedNetTable.totalTheta;
    
    trainedNet = trainedNetTable.trainedNet;
    boundaries = trainedNetTable.totalBoundaries;
    [l,w] = size(imds.preview);
    imgSizes = arrayDatastore(double(cat(2,imgKey.length,imgKey.width)));
    data = combine(imds,imgSizes);
    scores = minibatchpredict(trainedNet,data);
    % fcScores = minibatchpredict(trainedrNet,data,"Outputs","avg_pool");
    rawScores = scores;
if useIsotonic

    for z = 1:size(scores,2)
        tempBounds = cell2mat(boundaries(z));
        tempTheta  = cell2mat(theta(z));
        calibratedScores = calibrateConfidence(tempBounds,tempTheta,scores(:,z));
        if exist("newScores")
            newScores = cat(2,newScores,calibratedScores);
        else
            newScores = calibratedScores;
        end
    end
    % normScores = scores;
    scores = newScores;

    softMaxScores = scores;
    % for z = 1:length(scores)
    %     for k = 1:size(scores,2)
    %         softMaxScores(z,k) = exp(softMaxScores(z,k))/sum(exp(softMaxScores(z,:)));
    %     end
    % end
    % scores = softMaxScores;
end
    [a,b] = max(scores,[],2);
    if confidenceThreshold == 0
        classCounts = zeros(1,size(scores,2));
    else
        % include trash category
        classCounts = zeros(1,size(scores,2) + 1);
    end
    % make className directories
    mkdir(strcat(dirLocation,"\ClassificationOutput",DatasetTitle))
    % writematrix(fcScores,fullfile(dirLocation,strcat(DatasetTitle,"_fcScores.csv")))
    writematrix(string(filenames),fullfile(dirLocation,strcat(DatasetTitle,"_imageFilenames.csv")))
    for z = 1:size(classCounts,2)
        mkdir(strcat(dirLocation,"\ClassificationOutput",DatasetTitle,"\",num2str(z)))
    end
    % scores = reshape(scores,size(scores,2),[])
    bCat = categorical(b);
    scores = bCat;
    for i = 1:length(scores)
        if a(i) > confidenceThreshold
            % save image to directory
            classCounts(b(i)) = classCounts(b(i)) + 1;
            copyfile(cell2mat(imds.Files(i)),strcat(dirLocation,"\ClassificationOutput",DatasetTitle,"\",string(b(i))));
        else
            class = size(classCounts,2);
            classCounts(class) = classCounts(class) + 1;
            copyfile(cell2mat(imds.Files(i)),strcat(dirLocation,"\ClassificationOutput",DatasetTitle,"\",num2str(class)));
            % move to low confidence folder
        end
    end


    mkdir(strcat(dirLocation,"\ClassifiedRawImages_",DatasetTitle))
    classificationDir = strcat(dirLocation,"\ClassifiedRawImages_",DatasetTitle);
    predictionDir = strcat(dirLocation,"\ClassificationOutput",DatasetTitle);
    predictionClasses = dir(strcat(dirLocation,"\ClassificationOutput",DatasetTitle));
    for j = 3:length(predictionClasses)
        tempClass = fullfile(predictionDir,predictionClasses(j).name);
        tempPredictions = dir(tempClass);
        mkdir(fullfile(classificationDir,num2str(j-2)))
        for z = 3:length(tempPredictions)
            tempUniImg = tempPredictions(z).name;
            % imgKey.uniformFileName
            % idx = find(imgKey.uniformFileName == tempUniImg);
            tempRawImg = imgKey((string(imgKey.uniformFileName) == tempUniImg),:).rawFileName;
            copyfile(fullfile(rawdataSetPath,tempRawImg),fullfile(classificationDir,string(j-2),tempRawImg))
                   % copyfile(fullfile(rawdataSetPath,"5",tempRawImg),fullfile(classificationDir,string(j-2),tempRawImg))

        end
    end
    else
            if confidenceThreshold == 0
        classCounts = zeros(1,6);
    else
        % include trash category
        classCounts = zeros(1,6 + 1);
    end
    end
        
end