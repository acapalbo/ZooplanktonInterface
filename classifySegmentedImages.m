function scores = classifySegmentedImages(trainedNet,imds,confidenceThreshold,appAxis,dirLocation)
    X = readall(imds);
    [l,w] = size(imds.preview);
    Xtrain = reshape(cat(3,X{:}),[l,w,1,length(X)]);
    % scores = minibatchpredict(trainedNet,imds);
    scores = trainedNet.predict(dlarray(double(Xtrain),'SSCB'));
    [a,b] = max(scores,[],1);
    % accuracy = mean(categorical(b)' == imds.Labels)
    % size(scores)
    % classList = (repmat([1:size(scores,1)],length(X),1))';
    % [~,labels] = max(scores,[],2)
    % layer = trainedNet.Layers(length(trainedNet.Layers) - 1);
    % classNames = categories(imds.Labels);
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

    % give dataset stats and mean confidence for each class
    % X = categorical(1:size(classCounts,2));
    % X = reordercats(X,1:size(classCounts,2));
    b = bar(appAxis,1:size(classCounts,2),classCounts);
    xtips2 = b.XEndPoints;
    ytips2 = b.YEndPoints;
    labels2 = string(b.YData);
    text(appAxis,xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
    % close gcf
end