% NOTE: Less accurate than other version as it rounds to even 0.5
function insertScaleBarStaticFolder(imgDirectory, scaleFactor, conversionFactor,measuredLength,barThickness)
    folder = dir(imgDirectory);
    for k = 3:size(folder,1)
        fileName = folder(k).name;
        img = imread(strcat(imgDirectory,"\",fileName));
        [l,w] = size(img);

        pixelLength = measuredLength*conversionFactor;
        % barPos = [(l - 6)*scaleFactor,(l - 5)*scaleFactor,(w - floor(pixelLength) - 5)*scaleFactor,(w - 5)*scaleFactor];
        % img = imresize(img,scaleFactor,"bilinear");
        [l,w] = size(img);
        % quad1 = mean(mean(img(1:floor(l/2),1:ceil(w/2):end)));
        % quad2 = mean(mean(img(1:floor(l/2),1:floor(w/2))));
        % quad3 = mean(mean(img(ceil(l/2):end,1:floor(w/2))));
        % quad4 = mean(mean(img(ceil(l/2):end,ceil(w/2):end)));
        % pixelLength = floor(pixelLength*scaleFactor);
        disp(floor(0.95*l))
        disp((w - floor(pixelLength) - floor(0.05*w)))
        img(floor(0.95*l):floor(0.95*l)+barThickness,(w - floor(pixelLength) - floor(0.05*w)):(w - floor(0.05*w))) = 0;

        imwrite(img,strcat(imgDirectory,"\",fileName(1:end-4),"scaleBar.png"))
    end
end