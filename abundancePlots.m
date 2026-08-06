clear;clc;close all

% outputFolders = ["D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 20-51-18.659(3)",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-27 22-24-32.259(1)",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 21-35-16.951",...
% "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 21-14-42.900"];
outputFolders = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-08-28 23-05-27.396";
outputTimes = extract(outputFolders,digitsPattern(4)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+ " " + digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+"."+digitsPattern(3));
depthCSVfolder = "C:\Users\acapalbo\ZooplanktonInterface\norwayInterpPIDdepths";
for k = 1:length(outputFolders)

densityData = readmatrix(fullfile(outputFolders(k),"densityOutput.csv"));
depthVals = readmatrix(fullfile(depthCSVfolder,strcat(outputTimes(k),"_interpProfile.csv")));

classNames = ["Chaetognaths","Crustaceans","Gelatinous","Larvaceans"];
x = -depthVals(:,2);
y = densityData(:,[10,11,14,15]);
tiledlayout(2,2)
if size(y,1) ~= size(x,1)
    x = x(1:end-(size(x,1)-size(y,1)));
end
% x(end) = [];
for z = 1:size(y,2)
    nexttile
    tempY = y(:,z);
    tempX = x;
    tempY(isnan(x)) = [];
    tempX(isnan(x)) = [];
    X = [ones(length(tempX),1) tempX];
    tempB = tempY'/X';
    yCalc = X*tempB';
    Rsq2 = 1 - sum((tempY - yCalc).^2)/sum((tempY - mean(tempY)).^2);
    scatter(tempX,tempY,20,"filled","MarkerEdgeAlpha",0.7,"MarkerFaceAlpha",0.7)
    hold on
    plot(tempX,yCalc,"--r");
    % p.Ylim
    text(max(x),max(tempY),sprintf("R^2: %0.3f\nSlope: %0.2e",Rsq2,tempB(2)),"HorizontalAlignment","right","VerticalAlignment","top")
    text()
    title(sprintf("Profile Depth vs %s Abundance",classNames(z)))
    xlabel("Depth (m)")
    ylabel("Abundance (counts/L)")
    % atand(-tempB(2))
end
exportgraphics(gcf,strcat(outputTimes(k),"abundancePlots.png"))

end