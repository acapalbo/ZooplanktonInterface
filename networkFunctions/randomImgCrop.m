function randomImgCrop(imgPath)
    img = imread(imgPath);
    inputSize = size(img);
    scale = [0.5 0.9];
    targetSize = [227 227];
    rect = randomWindow2d(inputSize,"Scale",scale,DimensionRatio=[1 1; 1 1]);
    %rect = randomWindow2d(inputSize,targetSize);
    Icrop = imcrop(img,rect);
    imshow(Icrop);
    size(Icrop)
end