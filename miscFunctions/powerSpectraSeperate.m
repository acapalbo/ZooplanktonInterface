% imgDir = "C:\Users\acapalbo\HBOI_Work\CompiledDataset\3";
imgDir = "C:\Users\acapalbo\ZooplanktonInterface\testDir";

imgFiles = dir(imgDir);
allData = {};
allSlopes = [];
for z = 3:length(imgFiles)
    tempImg = imread(fullfile(imgDir,imgFiles(z).name));
    % tempImg = imresize(tempImg,2);
    [data,fitSlope] = fftPowerSpectrum(tempImg,false);
    allData = cat(1,allData,{data});
    allSlopes = cat(1,allSlopes,fitSlope);
end

msgbox("Section Complete")
%%
allImgs = {};
for z = 3:length(imgFiles)
    [~,~,contrastImg,qImg] = imgLocalContrastMeasure(fullfile(imgDir,imgFiles(z).name),10);
    allImgs = cat(1,allImgs,[{contrastImg},{qImg}]);
end

msgbox("Section Complete")
%% q2 max extraction
allQVals = [];
for z = 1:length(allImgs)
    tempImg = cell2mat(allImgs(z,2));
    tempQ = max(tempImg(:));
    allQVals = cat(1,allQVals,tempQ);
end
%%
sampleIDX = randsample(length(allData),200);
cmap = jet(200);
for j = 1 : 200
    tempData = cell2mat(allData(sampleIDX(j)));
    plot(tempData(:,1),tempData(:,2),"Color",cmap(j,:));
    hold on
end
    yscale("log")
xscale("log")

%% Seperate based on slope

histogram(allSlopes)
xline(mean(allSlopes),"--r",string(mean(allSlopes)));
xline(mean(allSlopes)-std(allSlopes),"--r",string(mean(allSlopes)-std(allSlopes)));
xline(mean(allSlopes)-2*std(allSlopes),"--r",string(mean(allSlopes)-2*std(allSlopes)));
outputDir = "FFT_Power_Spectrum_Focus_Sort";
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
mkdir(fullfile(outputDir,"InFocus"))
mkdir(fullfile(outputDir,"Blurry"))
thresh = mean(allSlopes)+std(allSlopes);
for z = 3:length(imgFiles)
    if allSlopes(z-2) < thresh
        copyfile(fullfile(imgDir,imgFiles(z).name),fullfile(outputDir,"Blurry"))
    else
        copyfile(fullfile(imgDir,imgFiles(z).name),fullfile(outputDir,"InFocus"))
    end
end

%% Contrast Measurement

localC = (max(pixelVals(:)) - min(pixelVals(:)))/ (max(pixelVals(:)) + min(pixelVals(:)));
[Gmag,Gdir] = imgradient(pixelVals);


