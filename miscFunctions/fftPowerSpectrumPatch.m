function [patchAlphas,patchAlphasDifferences,tempImg] = fftPowerSpectrumPatch(imgPath,patchSize)

    img = imread(imgPath);
    if size(img,1) ~= size(img,2)
        img = imresize(img,[max(size(img,1),size(img,2)),max(size(img,1),size(img,2))]);
    end
    img = double(img)/256;
    n = size(img,1);
    remainder = mod(n,patchSize);
    if remainder ~= 0
        padding = patchSize - remainder;
        img = [img ones(n,padding)];
        img = [img; ones(padding,n+padding)];
        n = size(img,1);
    end
    
    size(img)
    max(img(:))
    globalAlpha = fftPowerSpectrum(img);
    iterSteps = n/patchSize;
    patchAlphas = zeros(iterSteps,iterSteps);
    patchAlphasDifferences = zeros(iterSteps,iterSteps);
    tempImg = zeros(n,n);
    % Start of patch calc
    for i = 1:iterSteps
        for j = 1:iterSteps
            tempPatch = img((patchSize*(i-1))+1:(patchSize*(i)),(patchSize*(j-1))+1:(patchSize*(j)));
            tempAlpha = fftPowerSpectrum(tempPatch);
            patchAlphas(i,j) = tempAlpha;
            patchAlphasDifferences(i,j) = (tempAlpha - globalAlpha)/globalAlpha;
            tempImg((patchSize*(i-1))+1:(patchSize*(i)),(patchSize*(j-1))+1:(patchSize*(j))) = mean(tempPatch(:));
        end
    end
end