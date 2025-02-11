function scores = classifySegmentedImages(trainedNet,imds,confidenceThreshold,plotHist,appAxis,dirLocation)
    if isMATLABReleaseOlderThan("R2024a")
        X = readall(imds);
        [l,w] = size(imds.preview);
        Xtrain = reshape(cat(3,X{:}),[l,w,1,length(X)]);
        scores = trainedNet.predict(dlarray(double(Xtrain),'SSCB'));
        [a,b] = max(scores,[],1);
        if confidenceThreshold == 0
            classCounts = zeros(1,size(scores,1));
        else
            % include trash category
            classCounts = zeros(1,size(scores,1) + 1);
        end
        % make className directories
        mkdir ClassificationOutput
        for z = 1:size(classCounts,2)
            mkdir(strcat(dirLocation,'\ClassificationOutput\',num2str(z)))
        end
        % scores = reshape(scores,size(scores,2),[])
        b = categorical(b);
        scores = b;
        for i = 1:length(scores)
            if a(i) > confidenceThreshold
                % save image to directory
                classCounts(b(i)) = classCounts(b(i)) + 1;
                copyfile(cell2mat(imds.Files(i)),strcat(dirLocation,'\ClassificationOutput\',string(b(i))))
            else
                class = size(scores,2) + 1;
                classCounts(class) = classCounts(class) + 1;
                copyfile(cell2mat(imds.Files(i)),strcat(dirLocation,'\ClassificationOutput\',num2str(class)))
                % move to low confidence folder
            end
        end
    else

        [l,w] = size(imds.preview);
        scores = minibatchpredict(trainedNet,imds);
        [a,b] = max(scores,[],2);
        
        if confidenceThreshold == 0
            classCounts = zeros(1,size(scores,2));
        else
            % include trash category
            classCounts = zeros(1,size(scores,2) + 1);
        end
        % make className directories
        mkdir ClassificationOutput
        for z = 1:size(classCounts,2)
            mkdir(strcat(dirLocation,'/ClassificationOutput/',num2str(z)))
        end
        % scores = reshape(scores,size(scores,2),[])
        bCat = categorical(b);
        scores = bCat;
        for i = 1:length(scores)
            a(i)
            if a(i) > confidenceThreshold
                % save image to directory
                classCounts(b(i)) = classCounts(b(i)) + 1;
                copyfile(cell2mat(imds.Files(i)),strcat(dirLocation,'/ClassificationOutput/',string(b(i))));
            else
                class = size(classCounts,2);
                classCounts(class) = classCounts(class) + 1;
                copyfile(cell2mat(imds.Files(i)),strcat(dirLocation,'/ClassificationOutput/',num2str(class)));
                % move to low confidence folder
            end
        end
    end
    if plotHist
    b = bar(appAxis,1:size(classCounts,2),classCounts);
    xtips2 = b.XEndPoints;
    ytips2 = b.YEndPoints;
    labels2 = string(b.YData);
    text(appAxis,xtips2,ytips2,labels2,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
    end
end