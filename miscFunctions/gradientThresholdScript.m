%% Gradient comparisons
clear
imds = imageDatastore("C:\Users\acapalbo\HBOI_Work\CompiledDataset\3", ...
IncludeSubfolders=true, ...
LabelSource="foldernames");
maxMags = [];
maxDirs = [];
meanMags = [];
cellImds = {};
cellHistCounts = {};
histPeaks = [];
while imds.hasdata
    tempImg = imds.read;
    [Gmag,Gdir] = imgradient(tempImg,"central");
    tempHistCounts = histcounts(Gmag(:),100,"BinLimits",[0,50])/numel(Gmag);
    peakLocation = find(tempHistCounts == max(tempHistCounts));
    if numel(peakLocation) > 1
        peakLocation = mean(peakLocation);
    end
    histPeaks = cat(1,histPeaks,peakLocation);
    cellHistCounts = cat(1,cellHistCounts,{tempHistCounts});
    maxMags = cat(1,maxMags,max(Gmag(:)));
    maxDirs = cat(1,maxDirs,max(Gdir(:)));
    meanMags = cat(1,meanMags,mean(Gmag(:)));
    cellImds = cat(1,cellImds,{tempImg});
end
maxHistCounts = max(cell2mat(cellHistCounts),[],2);
cmap = parula(length(maxHistCounts));
x = linspace(0,50,100);
for z = 1:length(cellHistCounts)
plot(x,cell2mat(cellHistCounts(z)),"Color",cat(2,cmap(z,:),0.3))
hold on
end
yline(mean(maxHistCounts),'--b',string(mean(maxHistCounts)))
yline(mean(maxHistCounts)+std(maxHistCounts),'--c',string(mean(maxHistCounts)+std(maxHistCounts)))
yline(mean(maxHistCounts)+2*std(maxHistCounts),'--r',string(mean(maxHistCounts)+2*std(maxHistCounts)))
yline(mean(maxHistCounts)+3*std(maxHistCounts),'--m',string(mean(maxHistCounts)+3*std(maxHistCounts)))
yline(mean(maxHistCounts)-std(maxHistCounts),'--c',string(mean(maxHistCounts)-std(maxHistCounts)))
yline(mean(maxHistCounts)-2*std(maxHistCounts),'--r',string(mean(maxHistCounts)-2*std(maxHistCounts)))
yline(mean(maxHistCounts)-3*std(maxHistCounts),'--m',string(mean(maxHistCounts)-3*std(maxHistCounts)))
xline(mean(histPeaks),'--',string(mean(histPeaks)))
xline(mean(histPeaks)+std(histPeaks),'--',string(mean(histPeaks)+std(histPeaks)))
xline(mean(histPeaks)-std(histPeaks),'--',string(mean(histPeaks)-std(histPeaks)))
% 
% figure
% histogram(maxMags)
% xline(mean(maxMags) - std(maxMags),'--r',string(mean(maxMags) -std(maxMags)))
% xline(mean(maxMags),'--r',string(mean(maxMags)))
% xline(mean(maxMags) - 2*std(maxMags),'--r',string(mean(maxMags) -2*std(maxMags)))
% xline(mean(maxMags) - 3*std(maxMags),'--r',string(mean(maxMags) -3*std(maxMags)))
% figure
% histogram(meanMags)
% xline(mean(meanMags) - std(meanMags),'--r',string(mean(meanMags) -std(meanMags)))
% xline(mean(meanMags),'--r',string(mean(meanMags)))
% xline(mean(meanMags) - 2*std(meanMags),'--r',string(mean(meanMags) -2*std(meanMags)))
% xline(mean(meanMags) - 3*std(meanMags),'--r',string(mean(meanMags) -3*std(meanMags)))

%% Sort based on gradients
% gradientThresh = mean(maxMags) - std(maxMags);
% gradientThresh = mean(maxMags);

% gradientThresh = mean(meanMags) - std(meanMags);
% gradientThresh = mean(maxHistCounts) - std(maxHistCounts);
gradientThresh = mean(maxHistCounts)+std(maxHistCounts);
gradientThresh2 = mean(histPeaks) - 2*std(histPeaks);
imds.reset;
outputDir = "GradientThresholdSort";
tempoutputDir = outputDir;
if exist(outputDir)
    z = 0;
    while exist(tempoutputDir)
        z = z + 1;
        tempoutputDir = strcat(outputDir,"(",string(z),")");    
    end
end

outputDir = tempoutputDir;
mkdir(outputDir)
mkdir(fullfile(outputDir,"lowFocus"))
mkdir(fullfile(outputDir,"highFocus"))
z = 1;
imgNames = imds.Files;
while imds.hasdata
    tempimg = imds.read;
    % maxG = meanMags(z);
    % maxG = maxMags(z);
    maxG = maxHistCounts(z);
    tempPeak = histPeaks(z);
    tempName = imgNames(z);
    [~,fileName,~] = fileparts(tempName);
    if maxG < gradientThresh & tempPeak > gradientThresh2 
        imwrite(tempimg,strcat(fullfile(outputDir,"lowFocus"),"/",fileName,".png"))
    else
        imwrite(tempimg,strcat(fullfile(outputDir,"highFocus"),"/",fileName,".png"))
    end
    z = z + 1;
end

%% 