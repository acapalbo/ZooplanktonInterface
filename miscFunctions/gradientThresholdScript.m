%% Gradient comparisons
clear meanmags maxMags cellImds
imds = imageDatastore("C:\Users\acapalbo\ZooplanktonInterface\PredictedValues", ...
IncludeSubfolders=true, ...
LabelSource="foldernames");
maxMags = [];
maxDirs = [];
meanmags = [];
cellImds = {};
while imds.hasdata
    tempImg = imds.read;
    
    [Gmag,Gdir] = imgradient(tempImg);
    maxMags = cat(1,maxMags,max(Gmag(:)));
    maxDirs = cat(1,maxDirs,max(Gdir(:)));
    meanMags = cat(1,meanmags,mean(Gmag(:)));
    cellImds = cat(1,cellImds,{tempImg});
end

histogram(maxMags)
xline(mean(maxMags) - std(maxMags),'--r',string(mean(maxMags) -std(maxMags)))
xline(mean(maxMags),'--r',string(mean(maxMags)))
xline(mean(maxMags) - 2*std(maxMags),'--r',string(mean(maxMags) -2*std(maxMags)))
xline(mean(maxMags) - 3*std(maxMags),'--r',string(mean(maxMags) -3*std(maxMags)))

%% Sort based on gradients
gradientThresh = mean(maxMags) - std(maxMags);
imds.reset;

mkdir GradientThresholdSort
mkdir GradientThresholdSort\lowFocus
mkdir GradientThresholdSort\highFocus
while imds.hasdata
    tempimg = imds.read;
    maxG = maxMags(z);
    if maxG < gradientThresh
        imwrite(tempimg,strcat("GradientThresholdSort/lowFocus/",string(z),".png"))
    else
        imwrite(tempimg,strcat("GradientThresholdSort/highFocus/",string(z),".png"))
    end
end

%% 