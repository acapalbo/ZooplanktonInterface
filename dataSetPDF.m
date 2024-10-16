function [finalImg,scaleImage] = dataSetPDF(folderPath)
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
    x = 0:0.001:0.25;
    for i = 1:length(sortedFiles)
        % images(i).name
        tempimg = imread(fullfile(folderPath,sortedFiles(i)));
        % size(tempimg(:))
        [Gmag,~] = imgradient(tempimg);
        pd = fitdist(Gmag(:)/max(Gmag(:)),'Kernel','Kernel',"epanechnikov");
        y = pdf(pd,x);
        if exist('yTot')
            yTot = cat(1,yTot,y);
        else
            yTot = y;
        end
        % if max(Gmag(:)) > xMax
        %     xMax = ceil(max(Gmag(:)));
        % end
    end
    fig = figure;
    cmap = colormap(hsv(size(yTot,1)));
    % cmap = cat(2,cmap,[1:1/length(yTot):1])
    opa = 0.45;
    iter = 1:size(yTot,1)
    for i = 1:size(yTot,1)
        tempY = yTot(i,:);
        exist('labelPoints')
        if exist('labelPoints')
            labelPoints = cat(1,labelPoints,[x(tempY == max(tempY)),max(tempY)]);

        else
            labelPoints = [x(tempY == max(tempY)),max(tempY)];
        end
    end
    labelPoints
    [~,sortOrder] = sort(labelPoints(:,2),"descend")
    for i = 1:size(yTot,1)
    idx = sortOrder(i)
        tempY = yTot(idx,:);
    hold on
    plot(x,tempY,"Color",cat(2,cmap(i,:),opa),"LineWidth",2)

    end
    hold on 
    for i = 1:length(labelPoints)
        x = [labelPoints(i,1),labelPoints(i,1)+0.2];
        y = [labelPoints(i,2)/max(labelPoints(:,2)),labelPoints(i,2)/max(labelPoints(:,2))];
        % annotation(fig,'textarrow',x,y,'String',dataLabels(i))
        % insertShape("line")
    text(labelPoints(i,1),labelPoints(i,2),dataLabels(i),"FontSize",15,"HorizontalAlignment","center","VerticalAlignment","baseline")
    end
    lgd = legend(dataLabels(sortOrder));
    lgd.NumColumns = 6;
    [sortedPoints,pointOrder] = sort(labelPoints(:,2),"descend");
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