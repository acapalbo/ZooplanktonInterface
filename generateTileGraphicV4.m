function [finalImage,sortedNames] = generateTileGraphicV4(folderPath,prefRowSize)
    directory = dir(folderPath);
    numImages = length(directory)-2;

    imgSizes = imgFolderSizes(folderPath);
    [sortedNames,sortedSizes] = imgSort(folderPath,imgSizes);
    barDirectory = insertScaleBarAdaptiveFolder_with_labelingV2(folderPath,1.5,1/26.9,"mm",sortedNames);
    folderPath = barDirectory;
    maxWidth = 0;
    maxHeight = 0;
    totalWidth = 0;
    % first idx after the first row
    iter = prefRowSize + 1;
    % first row images
    for z = 1:prefRowSize
        tempImg = imread(fullfile(folderPath,sortedNames(z)));
        if size(tempImg,1) > maxHeight
            maxHeight = size(tempImg,1);
        end
        if exist('rowCells')
            rowCells = cat(2,rowCells,{tempImg});
        else
            rowCells = {tempImg};
        end
        totalWidth = totalWidth + size(tempImg,2);
    end
    
    for z = 1:size(rowCells,2)
        tempImg = cell2mat(rowCells(z));
        if size(tempImg,1) < maxHeight
            newImg = padarray(tempImg,[maxHeight-size(tempImg,1),0],0,"pre");
        else
            newImg = tempImg;
        end
        if exist('rowImage')
            rowImage = cat(2,rowImage,newImg);
        else
            rowImage = newImg;
        end

        if size(rowImage,2) > maxWidth
            maxWidth = size(rowImage,2);
        end
        % size(rowImage)
    end
    completedRowImages = {rowImage};
    % imshow(rowImage)
    % pause
    rowImage = [];
    rowCells = [];
    % moving on to other rows
    while true & iter < numImages
        maxHeight = 0;
        currentRowWidth = 0;
        nextWidth = 0;
        while currentRowWidth + nextWidth < totalWidth

            if iter <= numImages
                tempImg = imread(fullfile(folderPath,sortedNames(iter)));
                if size(tempImg,1) > maxHeight
                    maxHeight = size(tempImg,1);
                end
                if exist('rowCells')
                    rowCells = cat(2,rowCells,{tempImg});
                else
                    rowCells = {tempImg};
                end
                    iter = iter + 1;
                
                if iter < numImages
                    info = imfinfo(fullfile(folderPath,sortedNames(iter)));
                    nextWidth = info.Width;
                end

            else
                tempImg = zeros(size(tempImg));
                rowCells = cat(2,rowCells,{tempImg});
            end
            currentRowWidth = currentRowWidth + size(tempImg,2);
            
        end

        % logic for: currentWidth + next >= totalWidth
        nextWidth = totalWidth - currentRowWidth;
        rowCells = cat(2,rowCells,{zeros([maxHeight,nextWidth,3])});
        % rowCells
        % pause



        for z = 1:size(rowCells,2)
            tempImg = cell2mat(rowCells(z));
            if size(tempImg,1) < maxHeight
                if isinteger((maxHeight - size(tempImg,1))/2)
                newImg = padarray(tempImg,[ceil(maxHeight-size(tempImg,1)/2),0],0);
                else
                preZero = floor((maxHeight - size(tempImg,1))/2);
                postZero = ceil((maxHeight - size(tempImg,1))/2);
                newImg = padarray(tempImg,[preZero,0],0,"pre");
                newImg = padarray(newImg,[postZero,0],0,"post");
                end
            else
                newImg = tempImg;
            end
            if exist('rowImage')
                rowImage = cat(2,rowImage,newImg);
            else
                rowImage = newImg;
            end

            if size(rowImage,2) > maxWidth
                maxWidth = size(rowImage,2);
            end
            % size(rowImage)
        end 

        if exist('completedRowImages')
             completedRowImages = cat(1,completedRowImages,{rowImage});
             % disp("Jeh")
        else
            completedRowImages = {rowImage};
        end
        rowImage = [];
        rowCells = [];
    end
    % final combination 

    for z = 1:size(completedRowImages,1)
        tempImg = cell2mat(completedRowImages(z));

        if size(tempImg,2) < maxWidth
            newImg = padarray(tempImg,[0,maxWidth-size(tempImg,2)],0,"post");
        else
            newImg = tempImg;
        end
        if exist('finalImage')
            finalImage = cat(1,finalImage,newImg);
        else
            finalImage = newImg;
        end
    end
end