% NOTE: Less accurate than other version as it rounds to even 0.5
function insertScaleBarAdaptive(imgDirectory, scaleFactor, conversionFactor,units)
    folder = dir(imgDirectory);
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
        deci = mod(measuredLength,floor(measuredLength));
        deci = round(deci / 0.5 ) * 0.5;
        measuredLength = deci + floor(measuredLength);
        fontSize = max(min(floor(w*0.03),200),15);
        insertedScaleBar = insertText(img, textPos,strcat(num2str(measuredLength)," ",units),FontSize = fontSize, AnchorPoint="CenterBottom",BoxOpacity=0);
        imwrite(insertedScaleBar,strcat(imgDirectory,"\",fileName(1:end-4),"scaleBar.png"))
    end
end