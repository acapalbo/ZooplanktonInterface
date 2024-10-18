function [finalImg,scaleImage] = dataSetPDFCompare(folderPath)
    import matlab.io.spreadsheet.internal.columnLetter
    if exist(fullfile(folderPath,"insertedBars"))
        rmdir(fullfile(folderPath,"insertedBars"),"s")
    end
    images = dir(folderPath);
    xMax = 0;
    [finalImg,sortedFiles] = generateTileGraphicV4(folderPath,4);
    dataLabels = {};
    for i = 1:length(sortedFiles)
        dataLabels = cat(1,dataLabels,columnLetter(i));
    end
    % x = 0:0.001:0.25;
    maxGmag = 0;
    for i = 1:length(sortedFiles)
        % images(i).name
        tempimg = imread(fullfile(folderPath,sortedFiles(i)));
        % size(tempimg(:))
        [Gmag,~] = imgradient(tempimg);
        if max(Gmag(:)) > maxGmag
            maxGmag = max(Gmag(:));
        end

    end
    for i = 1:length(sortedFiles)

        tempimg = imread(fullfile(folderPath,sortedFiles(i)));

        [Gmag,~] = imgradient(tempimg);

        % Gmag(Gmag == 0) = 0.001;
        % histogram(Gmag(:)/numel(Gmag(:)),200)
        % figure
        % histogram(Gmag(:),200)
        % pause
        % close gcf

        pd = fitdist((Gmag(:)/max(Gmag(:))),'Kernel','Kernel',"epanechnikov");
        x = 0:0.001:1;

        % pd = fitdist((Gmag(:)/max(Gmag(:)))*100,'Kernel','Kernel',"epanechnikov");
        % x = 0:0.01:100;
        % 
        % 

        if exist('xTot')
            xTot = cat(1,xTot,{x});
        else
            xTot = {x};
        end
        y = pdf(pd,x);
        if exist('yTot')
            yTot = cat(1,yTot,{y});
        else
            yTot = {y};
        end

        % x2 y2 

        pd = fitdist(Gmag(:),'Kernel','Kernel',"epanechnikov");
        x = 0:0.1:max(Gmag(:));

        if exist('xTot2')
            xTot2 = cat(1,xTot2,{x});
        else
            xTot2 = {x};
        end
        y = pdf(pd,x);
        if exist('yTot2')
            yTot2 = cat(1,yTot2,{y});
        else
            yTot2 = {y};
        end
        % if max(Gmag(:)) > xMax
        %     xMax = ceil(max(Gmag(:)));
        % end
    end
    fig = figure;
    cmap = colormap(hsv(size(yTot,1)));
    % cmap = cat(2,cmap,[1:1/length(yTot):1])
    opa = 0.45;
    iter = 1:size(yTot,1);
    
    for i = 1:size(yTot,1)
        tempY = cell2mat(yTot(i,:));
        tempX = cell2mat(xTot(i,:));
        if exist('labelPoints')
            labelPoints = cat(1,labelPoints,[tempX(tempY == max(tempY)),max(tempY)]);

        else
            labelPoints = [tempX(tempY == max(tempY)),max(tempY)];
        end
    end
 
    [~,sortOrder] = sort(labelPoints(:,2),"descend");
    for i = 1:size(yTot,1)
        idx = sortOrder(i);
        tempY = cell2mat(yTot(idx,:));
        tempX = cell2mat(xTot(idx,:));

        tempY2 = cell2mat(yTot2(idx,:));
        tempX2 = cell2mat(xTot2(idx,:));

        
        % trapz(tempX2,tempY2)
        area = trapz(tempX,tempY);
        fprintf("Area 1: %0.3d; Area 2: %0.4d\n",trapz(tempX,tempY),trapz(tempX2,tempY2))
        % hold on
        tiledlayout(1,2)
        nexttile
        plot(tempX,tempY,"Color",cat(2,cmap(i,:),opa),"LineWidth",2);
        % max(tempY(:))
        [~,locs,w,~] = findpeaks(tempY,tempX,'Annotate','extents','MinPeakHeight',2);
        nexttile
        plot(tempX2,tempY2,"Color",cat(2,cmap(i,:),opa),"LineWidth",2)
        pause
        close gcf
        if size(w,2) > 1
            w = max(w);

        end
        % [~,~,w,~] = findpeaks(tempY,x,'Annotate','extents')
        % pause
        if exist('totalW')
            totalW = cat(1,totalW,w);
        else
            totalW = w;
        end
    end

    hold on 
    
    for i = 1:length(labelPoints)
        text(labelPoints(i,1),labelPoints(i,2),dataLabels(i),"FontSize",15,"HorizontalAlignment","center","VerticalAlignment","baseline")
    end
    % lgd = legend(dataLabels(sortOrder));
    % lgd.NumColumns = 6;
    [sortedPoints,pointOrder] = sort(labelPoints(:,2),"descend");
    % [sortedPoints,pointOrder] = sort(totalW,"ascend");
    scaleImage = generateScaleImage(sortedPoints,pointOrder,sortedFiles,fullfile(folderPath,"insertedBars"),dataLabels);
end

function scaleImage = generateScaleImage(sortedPoints,pointOrder,sortedFiles,folderPath,dataLabels)
    imgSizes = imgFolderSizes(folderPath);
    maxHeight = 0;
    for i = 1:length(imgSizes)
        if imgSizes(i,1) > maxHeight
            maxHeight = imgSizes(i,1);
        end
    end
    newImgOrder = sortedFiles(pointOrder);
    for z =1:length(imgSizes)
        tempImg = imread(fullfile(folderPath,newImgOrder(z)));
    if isinteger((maxHeight - size(tempImg,1))/2)
        newImg = padarray(tempImg,[ceil(maxHeight-size(tempImg,1)/2),0],0);
    else
        preZero = floor((maxHeight - size(tempImg,1))/2);
        postZero = ceil((maxHeight - size(tempImg,1))/2);
        newImg = padarray(tempImg,[preZero,0],0,"pre");
        newImg = padarray(newImg,[postZero,0],0,"post");
    end
    if exist('scaleImage')
        scaleImage = cat(2,scaleImage,newImg);
    else
        scaleImage = newImg;
    end
    end
end