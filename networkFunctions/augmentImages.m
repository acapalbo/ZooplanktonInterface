function  augmentImages(imageDir,repeatFactor)
    mkdir AugmentedImages
    images = dir(imageDir);
    outputDir = fullfile(pwd,"AugmentedImages");
    for z = 1:repeatFactor
    for idx = 3:length(images)
        temp = imread(fullfile(imageDir,images(idx).name));
        
        % Add randomized Gaussian blur
        temp = imgaussfilt(temp,1.5*rand);
        
        % Add salt and pepper noise
        temp = imnoise(temp,"gaussian",0,0.05);
        % temp = imnoise(temp,"salt & pepper");
        % Add randomized rotation and scale
        tform = randomAffine2d("XReflection",true,"YReflection",true,Scale=[0.95,1.05],Rotation=[-30 30]);
        outputView = affineOutputView(size(temp),tform);
        temp = imwarp(temp,tform,OutputView=outputView);
        
        % Form a two-element cell array with the input image and expected response
        imwrite(temp,fullfile(outputDir,strcat(images(idx).name,"_augmented_",string(z),".png")))
    end
    end

end