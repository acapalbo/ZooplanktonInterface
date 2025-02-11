function imageFFTransform(imgPath)
    img = imread(imgPath);
    f2 = img;
    F22 = fft2(f2);
    F222 = log(abs(F22));
    figure
    imshow(ifft2(F22),[],"InitialMagnification","fit");
    figure
    imshow(F222,[],"InitialMagnification","fit");
    colormap(jet); colorbar
    %F22(size(img,1)/2 - 10:size(img,1)/2 + 10,size(img,2)/2 - 10:size(img,2)/2 + 10) = 0;
    F22(img == min(img(:))) = 0;
    figure
    imshow(ifft2(F22),[],"InitialMagnification","fit");

end