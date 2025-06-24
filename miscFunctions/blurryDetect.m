function [magnitude,meanVal] = blurryDetect(imgPath,showVis)
img = imread(imgPath);
% img = imgPath;
% img = imcomplement(img);
[l,w] = size(img);
% img = imresize(img,[max(l,w),max(l,w)]);

cy = ceil(l/2);
cx = ceil(w/2);
radiusSizey = ceil(l/12);
radiusSizex = ceil(w/12);
fftShiftStep = fftshift(fft2(img));

% fftShiftStep(cy - radiusSizey:cy + radiusSizey, cx - radiusSizex:cx + radiusSizex) = 0;
fftShiftStep = removeBorder(fftShiftStep,radiusSizey,radiusSizex);
% imshow(log(abs(fftShiftStep)),[])
unShifted = ifftshift(fftShiftStep);
recon = ifft2(unShifted);
if showVis
    figure
    imshow(img)
    figure
imshow(20*log(abs(recon)),[])
end
magnitude = 20 * log(abs(recon));
meanVal = mean(magnitude(:));
end