% NOTE: Less accurate than other version as it rounds to even 0.5
function insertScaleBarAdaptiveFolder_with_labeling(imgDirectory, scaleFactor, conversionFactor,units)
    import matlab.io.spreadsheet.internal.columnLetter
    folder = dir(imgDirectory);
    mkdir(fullfile(imgDirectory,"insertedBars"))
    labelFont = 20;
    for k = 3:size(folder,1)
        fileName = folder(k).name;
        img = imread(strcat(imgDirectory,"\",fileName));
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
        insertedScaleBar = insertText(insertedScaleBar,labelPos,columnLetter(k),FontSize = labelFont, AnchorPoint="LeftBottom",BoxOpacity=0,FontColor="magenta");
        imwrite(insertedScaleBar,strcat(imgDirectory,"\insertedBars\",fileName(1:end-4),"scaleBar.png"))
    end
end