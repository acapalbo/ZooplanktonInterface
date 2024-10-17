% NOTE: Less accurate than other version as it rounds to even 0.5
function barDirectory = insertScaleBarAdaptiveFolder_with_labelingV2(imgDirectory, scaleFactor, conversionFactor,units,sortedFiles)
    import matlab.io.spreadsheet.internal.columnLetter
    % folder = dir(imgDirectory);
    if exist(fullfile(imgDirectory,"insertedBars"))
        rmdir(fullfile(imgDirectory,"insertedBars"))
    end
    mkdir(fullfile(imgDirectory,"insertedBars"))
    barDirectory = fullfile(imgDirectory,"insertedBars");
    labelFont = 20;
    
    for k = 1:length(sortedFiles)
        img = imread(fullfile(imgDirectory,string(sortedFiles(k))));
        fileName = char(sortedFiles(k));
        [l,w] = size(img);
        barThickness = floor(w/150);
        if barThickness < 2
            barThickness = 2;
        end
            pixelLength = floor(w/2);
            measuredLength = pixelLength*conversionFactor;
        % barPos = [(l - 6)*scaleFactor,(l - 5)*scaleFactor,(w - floor(pixelLength) - 5)*scaleFactor,(w - 5)*scaleFactor];
        img = imresize(img,scaleFactor,"bilinear");
        [l,w] = size(img);
        % quad1 = mean(mean(img(1:floor(l/2),1:ceil(w/2):end)));
        % quad2 = mean(mean(img(1:floor(l/2),1:floor(w/2))));
        % quad3 = mean(mean(img(ceil(l/2):end,1:floor(w/2))));
        % quad4 = mean(mean(img(ceil(l/2):end,ceil(w/2):end)));
        pixelLength = floor(pixelLength*scaleFactor);
        img(floor(0.95*l):floor(0.95*l)+barThickness,(w - floor(pixelLength) - floor(0.05*w)):(w - floor(0.05*w))) = 0;
        textPos = [(w-(floor(pixelLength)/2)-floor(0.05*w)),floor(0.97*l)]; 
        labelPos = [((floor(pixelLength)/8)),floor(0.97*l)];
        deci = mod(measuredLength,floor(measuredLength));
        deci = round(deci / 0.5 ) * 0.5;
        measuredLength = deci + floor(measuredLength);
        fontSize = max(min(floor(w*0.03),200),15);
        insertedScaleBar = insertText(img, textPos,strcat(num2str(measuredLength)," ",units),FontSize = fontSize, AnchorPoint="CenterBottom",BoxOpacity=0);
        insertedScaleBar = insertText(insertedScaleBar,labelPos,columnLetter(k),FontSize = labelFont, AnchorPoint="LeftBottom",BoxOpacity=0.6,BoxColor = "yellow");
        imwrite(insertedScaleBar,strcat(imgDirectory,"\insertedBars\",fileName))
    end
end