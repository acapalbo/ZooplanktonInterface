close all;clear;clc

s = load("colorblindCmap.mat");
load("uncertaintyNetworksOutput02_27_02_28.mat")
colorblindCmap = s.colorblindCmap;
uncertaintyColumns = outputs(:,2:4:24);
tempArr = cell2mat(uncertaintyColumns');
uncertaintyVals = tempArr(1:11:66,:)';
% dataFolders = ["D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 10-49-04.443",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 10-29-22.429",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 10-14-42.377",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 09-54-29.140",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 09-39-30.374",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 09-30-03.814",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 09-10-33.199",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 08-49-08.834",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 08-28-04.292"];
% %

% dataFolders = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-02-27 20-55-00.071_2024-02-28 00-21-00.363(7)";
% dataFolders = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-03 11-07-05.392_2024-03-03 11-48-16.975(4)";
% nicheOutputs = "D:\ZooPlanktonOutputs\BatchProcess_niche(41)";
nicheOutputs = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-27 22-24-32.259_2024-08-28 00-46-35.354(5)_niche";
dataFolders = split(nicheOutputs,"_niche");
dataFolders = dataFolders(1);
% ,...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 04-48-47.543",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 04-28-54.499",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 04-08-40.060"];
nicheFiles = dir(nicheOutputs);
dataFiles = dir(dataFolders);

allTimes = [];
allData = [];
allNicheData = [];
for k = 13:length(dataFiles)
    tempOutputDir = fullfile(dataFolders,dataFiles(k).name);
    tableData = readtable(fullfile(tempOutputDir,"densityOutput.csv"));
    nicheTableData = readtable(fullfile(nicheOutputs,nicheFiles(k).name,"densityOutput.csv"));
    densityData = [tableData.Densities_1,tableData.Densities_2,...
        tableData.Densities_3,tableData.Densities_4,...
        tableData.Densities_5,tableData.Densities_6];
    nicheDensities = [nicheTableData.Densities_1,nicheTableData.Densities_2,...
        nicheTableData.Densities_3,nicheTableData.Densities_4,...
        nicheTableData.Densities_5,nicheTableData.Densities_6];
    vidFilenames = tableData.Filename;
    tempTime = extract(vidFilenames,digitsPattern(4)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+ " " + digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+"."+digitsPattern(3));
    tempTime = datetime(string(tempTime),"InputFormat","yyyy-MM-dd HH-mm-ss.SSS");
    vidTimes = tempTime(:,2);
    allData = cat(1,allData,densityData);
    allNicheData = cat(1,allNicheData,nicheDensities);
    allTimes = cat(1,allTimes,vidTimes);
end
allTimes_full = allTimes;
% uncertaintyVals = uncertaintyVals(1:581,:);

nicheData = allNicheData;
densityData = allData;
% densityData = allData(1:581,:);
% nicheData = nicheDensities(1:581,:);
% allTimes = allTimes(1:581);
allTimes = datetime(allTimes,"Format","HH:mm:ss");
% plot(allTimes)
% pause
% hardcoded for 208 datapoints
binSize =5;
numElem = floor(size(densityData,1)/binSize)*binSize;
numGroups = floor(size(densityData,1)/binSize);
elementDiff = size(densityData,1)-numElem;
shortenedData = densityData(1:end-elementDiff,:);
allTimes = allTimes(1:end-elementDiff);
nicheData = nicheData(1:end-elementDiff,:);
% uncertaintyVals = uncertaintyVals(1:end-elementDiff,:);
g = repelem(1:numGroups,binSize);
densityData = shortenedData;
binnedData = [];
binnedUncertainty = [];
binnedNicheData = [];
for z = 1:6
    binnedData = cat(2,binnedData,splitapply(@mean,densityData(:,z),g'));
    % binnedUncertainty = cat(2,binnedUncertainty,splitapply(@mean,uncertaintyVals(:,z),g'));
    binnedNicheData = cat(2,binnedNicheData,splitapply(@mean,nicheData(:,z),g'));
end
% binnedUncertainty = 1 - binnedUncertainty;
% binnedData = splitapply(@mean,densityData(:,1),densityData(:,2),densityData(:,3),densityData(:,4),densityData(:,5),densityData(:,6),g);
binnedTime = splitapply(@mean,allTimes,g');
% binnedNiche = splitapply(@mean,nicheData,g');
radiolariaMSL = (binnedNicheData(:,5).*1.150e+11)./1000;
annelidMSL = (binnedNicheData(:,1).*5.38e+10)./1000;
doliolidMSL = (binnedNicheData(:,3).*1.263e11)./1000;
siphonophoraMSL = (binnedNicheData(:,6).*1.15e10)./1000;

larvaceanData = densityData(:,enmd);

binnedLarvacean = (splitapply(@mean,larvaceanData,g').*3.456e+09)./1000;
densityData = binnedData;
allTimes = binnedTime;
classNames = ["Chaetognaths","Crustaceans","DetritusA","DetritusB","Gelatinous","Larvaceans"];
uncertaintyStrings = ["Chaetognath Uncertainty","Crustacean Uncertainty","DetA Uncertainty","DetB Uncertainty","Gelatinous Uncertainty","Larvacean Uncertainty"];
fig = figure(Position=[0,0,900,900],Theme="Light");

x = [repmat(categorical(classNames(1)),[size(densityData,1),1]),repmat(categorical(classNames(2)),[size(densityData,1),1]),repmat(categorical(classNames(5)),[size(densityData,1),1]),repmat(categorical(classNames(6)),[size(densityData,1),1])];
cmap = colorblindCmap(floor(linspace(1,256,size(densityData,1))),:);
tiledlayout(2,1)
nexttile
swarmchart(x,densityData(:,[1,2,5,6]),20,"filled",'MarkerFaceAlpha',0.8,'Cdata',cmap,'MarkerEdgeAlpha',0.8,'XJitter','density','XJitterWidth',0.5)
c = colorbar;
colormap(colorblindCmap)
c.Ticks = [0 1];
c.TickLabels = [string(allTimes(1));string(allTimes(end))];
c.Label.String = "Time Series (HH:mm:ss)";
c.Label.Position = [2.5167 0.5151 0];
ylabel("Abudance (Instances/Liter)")
title("Abundance Data Distribution")
plottingClasses = [1,2,5,6];
iter = 0;
for z = plottingClasses
    iter = iter + 1;
    hold on
    tempDensity = densityData(:,z);
    ci_ppm = bootci(1000,{@mean,tempDensity},'type','per','alpha',.05);
    plot([iter-.25,iter+.25],repmat(ci_ppm(1),[1,2]),'--r');
    text(iter+.25,ci_ppm(1),sprintf("%0.3f",ci_ppm(1)),"FontSize",10,Rotation=45,VerticalAlignment="top")
    plot([iter-.25,iter+.25],repmat(ci_ppm(2),[1,2]),'--r');
    text(iter+.3,ci_ppm(2) + 0.01,sprintf("%0.3f",ci_ppm(2)),"FontSize",10,Rotation=45,VerticalAlignment="bottom")
end
% exportgraphics(gcf,fullfile(baseOutputDir,strcat(dirDate,"_abundancePlot.png")),"Padding","figure");
[~,plotOrder] = sort(mean(densityData,1),"descend");
% plotOrder = plotIdx(1,:);
plotOrder(plotOrder == 3 | plotOrder == 4) = [];
nexttile
% figure(Position=[488,338,780,420]);
hold on
arr = densityData(:,plotOrder);
classNames = classNames([1,2,5,6]);
% arr2 = binnedUncertainty(:,plotOrder);
% A = classNames(plotOrder);
% B = uncertaintyStrings(plotOrder);

% legendText = reshape([A;B], size(A,1), []);
% cumSumArr = cumsum(arr,2);
plotOrder = 1:4;
% plotOrder = flip(plotOrder);
markers = ["square","o","pentagram","diamond"];
cmapGem = orderedcolors("gem");
% arr2 = arr.*arr2;
% for z = plotOrder
% yyaxis left
% plot(allTimes,arr(:,z),"LineWidth",2,"Marker",markers(z));
% yyaxis right
% plot(allTimes,arr2(:,z),"LineWidth",2,"Marker",markers(z));

% errorbar(allTimes,arr(:,z),arr2(:,z))


% a.FaceAlpha = 0.6;
% end

% pause
% plots = {};
for z = plotOrder
    plot(allTimes,arr(:,z),"Color",cmapGem(z,:),"LineWidth",2)
    % plots
    % x = cat(1,allTimes,flip(allTimes));
    % y = cat(1,arr(:,z) + arr2(:,z),flip(arr(:,z)-arr2(:,z)));
    hold on
    % patch(x',y',cmapGem(z,:),"FaceAlpha",0.5,"EdgeColor","none")
    % plot(x',y',"Color",cmapGem(z,:),"LineStyle","none","Marker",markers(z))
end

legend(classNames(plotOrder),"Location","northwest","NumColumns",2)

title("Abundance Data Time Series")
ylabel("Abundance (Organisms/Liter)")
xlim([allTimes(1),allTimes(end)])
% exportgraphics(gcf,fullfile(baseOutputDir,strcat(dirDate,"_abundancePlot_area.png")),"Padding","figure");
% yscale("log")
% title("Abundance Time Series Log Scale")
% exportgraphics(gcf,fullfile(baseOutputDir,strcat(dirDate,"_abundancePlot_area_logScale.png")),"Padding","figure");
% exportgraphics(gcf,fullfile(baseOutputDir,strcat(dirDate,"_abundancePlots_tiledLayout.png")),"Padding","figure");
%

figure(Position=[0,0,900,450],Theme="Light");
plot(allTimes,cumsum(binnedLarvacean),"LineWidth",2)
hold on
plot(allTimes,cumsum(annelidMSL),"LineWidth",2)
plot(allTimes,cumsum(doliolidMSL),"LineWidth",2)
plot(allTimes,cumsum(siphonophoraMSL),"LineWidth",2)
plot(allTimes,cumsum(radiolariaMSL),"LineWidth",2)
total = sum([binnedLarvacean,annelidMSL,doliolidMSL,siphonophoraMSL,radiolariaMSL],2);
plot(allTimes,cumsum(total),"LineWidth",2)
% a = area(allTimes,radiolariaMSL+binnedLarvacean);
% % a.FaceAlpha = 0.7;
% % a.EdgeColor = "none";
% a.EdgeAlpha = 0.3;
% hold on
% a = area(allTimes,radiolariaMSL);
% % a.FaceAlpha = 0.7;
% % a.EdgeColor = "none";
% a.EdgeAlpha = 0.3;

legend(["Oikopleura Contribution","Annelid Contribution","Doliolid Contribution","Siphonophora Contribution","Collodaria Contribution","Total Latent MSL"],"Location","northwest")
xlim([allTimes(1),allTimes(end)])
% ylim([0,15e7])
title("Total Latent MSL")
ylabel("Latent MSL (photons/m^-3)")