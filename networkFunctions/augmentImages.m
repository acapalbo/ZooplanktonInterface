function  augmentImages(imageDir,repeatFactor)
    mkdir AugmentedImages
    images = dir(imageDir);
    outputDir = fullfile(pwd,"AugmentedImages");
    for z = 1:repeatFactor
    for idx = 3:length(images)
        temp = imread(fullfile(imageDir,images(idx).name));
        % Add randomized Gaussian blur
        temp = imgaussfilt(temp,1.5*rand);
        imwrite(temp,fullfile(outputDir,strcat(images(idx).name,"_gaussBlur_",string(z),".png")))
        % Add salt and pepper noise
        temp = imnoise(temp,"gaussian",0,0.05);
        imwrite(temp,fullfile(outputDir,strcat(images(idx).name,"_gaussNoise_",string(z),".png")))

        % temp = imnoise(temp,"salt & pepper");
        % Add randomized rotation and scale
        tform = randomAffine2d("XReflection",true,"YReflection",true,Scale=[0.95,1.05],Rotation=[-30 30]);
        outputView = affineOutputView(size(temp),tform);
        temp = imwarp(temp,tform,OutputView=outputView);
        imwrite(temp,fullfile(outputDir,strcat(images(idx).name,"_scaleRotate_",string(z),".png")))
        imwrite(temp,fullfile(outputDir,strcat(images(idx).name,"_augmented_",string(z),".png")))
    end
    end

end