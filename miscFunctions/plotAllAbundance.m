clear; clc; close all;
directories = ["D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 08-28-04.292",...
    "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 08-49-08.834",...
    "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 09-30-03.814",...
    "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 10-14-42.377",...
    "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-03-02 10-49-04.443"];
dirDateSpecific = "03/02/2024";
fullOutputs = [];    
fig = figure(Position=[488,338,780,420]);
allTimes = [];
for z = directories
    arr = readtable(fullfile(z,"densityOutput.csv"));
    temp = [arr.Densities_1,arr.Densities_2,arr.Densities_5,arr.Densities_6];
    [~,vidTime] = fileparts(arr.Filename);
    vidTime = string(vidTime);
    vidTime = extract(vidTime,digitsPattern(4)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+" "+digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2));
    vidTime = datetime(vidTime,"InputFormat","yyyy-MM-dd HH-mm-ss","Format","HH:mm:ss");
    fullOutputs = cat(1,fullOutputs,temp);
    allTimes = cat(1,allTimes,vidTime);
end
classNames = ["Chaetognaths","Crustaceans","DetritusA","DetritusB","Gelatinous","Larvaceans"];
[fullOutputs,TFrm] = rmoutliers(fullOutputs,"mean");

    x = [repmat(categorical(classNames(1)),[size(fullOutputs,1),1]),repmat(categorical(classNames(2)),[size(fullOutputs,1),1]),repmat(categorical(classNames(5)),[size(fullOutputs,1),1]),repmat(categorical(classNames(6)),[size(fullOutputs,1),1])];
% linMapR = linspace(0.9137,0.3765,size(fullOutputs,1));
% linMapG = linspace(0.4431,0,size(fullOutputs,1));
% linMapB = linspace(0.3490,0.3490,size(fullOutputs,1));
x1 = floor(size(fullOutputs,1)/2);
x2 = ceil(size(fullOutputs,1)/2);
% linMapR = linspace(1,1,x1);
% linMapG = linspace(0.5,0,x1);
% linMapB = linspace(1,0.1961,x1);
% 
% linMapR = cat(2,linMapR,linspace(0.9137+abs(linMapR(2)-linMapR(1)),0,x2));
% linMapG = cat(2,linMapG,linspace(0+abs(linMapG(2)-linMapG(1)),1,x2));
% linMapB = cat(2,linMapB,linspace(0.1961+abs(linMapB(2)-linMapB(1)),0,x2));
linMapR = linspace(0.7,0,size(fullOutputs,1));
linMapG = linspace(0.8,0,size(fullOutputs,1));
linMapB = linspace(1,0,size(fullOutputs,1));

linMap = cat(2,linMapR',linMapG',linMapB');
    
    cmap = winter(size(fullOutputs,1));
% cmap(6,:) = [0,0,0];
    swarmchart(x,fullOutputs,20,"filled",'MarkerFaceAlpha',0.7,'CData',1:size(fullOutputs,1),'MarkerEdgeAlpha',0.5,'XJitter','density','XJitterWidth',0.5)
    c = colorbar;
    colormap(linMap)
    c.Ticks = [1,size(fullOutputs,1)];
    c.TickLabels = [string(allTimes(1)),string(allTimes(end))];
    ylabel("Abudance (Organisms/Liter)")
    title("Calculated PID Abundances",sprintf("for %s",dirDateSpecific))
    % plottingClasses = [1,2,5,6];
    iter = 0;
    for z = 1:4
        iter = iter + 1;
        hold on
        tempDensity = fullOutputs(:,z);
        ci_ppm = bootci(1000,{@mean,tempDensity},'type','per','alpha',.05);
        plot([iter-.25,iter+.25],repmat(ci_ppm(1),[1,2]),'--r');
        lineObj = plot([iter-.25,iter+.25],repmat(ci_ppm(2),[1,2]),'--r');
        text(iter-.25,ci_ppm(1)-0.01,sprintf("%0.3f",ci_ppm(1)),"HorizontalAlignment","right")
        text(iter-.25,ci_ppm(2)+0.01,sprintf("%0.3f",ci_ppm(2)),"HorizontalAlignment","right")
    end
    
    legend(lineObj,"95% Confidence Interval","Location","northwest","IconColumnWidth",25)
    exportgraphics(fig,"swarmChartTotal.png")
    exportgraphics(fig,"swarmChartTotal.png")
    % text(iter+.25+.1,ci_ppm(2),sprintf("%0.3f",ci_ppm(2)),"FontSize",10,Rotation=45,VerticalAlignment="bottom")
    % text(iter+.25,ci_ppm(1),sprintf("%0.3f",ci_ppm(1)),"FontSize",10,Rotation=-45,VerticalAlignment="bottom")
