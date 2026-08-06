%% Choose Video
close all;clear;clc;

neuralNet = "D:\HBOI_Work\trainedNetworks\adaptedXception_DS_v6.1.mat";
% "E:\LUMEX03\2024-08-29 21-40-59.672"
% "E:\LUMEX03\2024-08-29 22-02-38.422"
% "E:\LUMEX03\2024-08-29 22-13-08.952"
% "E:\LUMEX03\2024-08-29 22-32-44.251"
% "E:\LUMEX03\2024-08-29 22-53-47.940",...
% "E:\LUMEX03\2024-08-29 23-12-15.468",...
% "E:\LUMEX03\2024-08-29 23-29-51.979",...
% "E:\LUMEX03\2024-08-29 23-48-02.876",...
% "E:\LUMEX03\2024-08-30 00-05-43.051",...
videoDirPath = ["E:\LUMEX2\PID\2024-05-18 17-05-40.659"];
if isempty(videoDirPath)
    videoDirPath = uigetdir("*.*");
end

classNames = ["Chaetognaths","Crustaceans","DetritusA","DetritusB","Gelatinous","Larvaceans"];
baseOutputDir = "D:\ZooPlanktonOutputs";
outputTable = [];

errorMessages = {};
%% Begin Algorithm
    tStart = tic;
    dirDateStart = strsplit(videoDirPath(1),"\");
    dirDateStart = dirDateStart(end);
    dirDateEnd = strsplit(videoDirPath(end),"\");
    dirDateEnd = dirDateEnd(end);
    netTable = load(neuralNet);
    outputTitle = strcat("OrganismDensityCalc_",string(dirDateStart),"_",string(dirDateEnd));
% end
    if exist(fullfile(baseOutputDir,outputTitle))
        k=1;
        while exist(fullfile(baseOutputDir,strcat(outputTitle,"(",num2str(k),")")))
            k = k + 1;
        end
        mkdir(fullfile(baseOutputDir,strcat(outputTitle,"(",num2str(k),")")))
        baseOutputDir = fullfile(baseOutputDir,strcat(outputTitle,"(",num2str(k),")"));
    else
        mkdir(fullfile(baseOutputDir,outputTitle))
        baseOutputDir = fullfile(baseOutputDir,outputTitle);
    end

    delete(gcp("nocreate"))
    parallelPool = parpool("Threads");
    % outputTable = struct("Filename","","NumFrames",0,"Counts",0,"LitersProcessed",0,"Densities",0);
for k = 1:length(videoDirPath)
allTimes = getVidTimes(videoDirPath(k));
if isstring(videoDirPath)
dirPath = dir(videoDirPath(k));
    % setup output directory
%     nbytes = fprintf('processing %d of %d\n', 0,length(z));
% for nz = z
%     fprintf(repmat('\b',1,nbytes))
%     nbytes = fprintf('processing %d of %d\n', nz, length(z));
%       % YOUR PROCESS HERE
%       %
%       %
%       %
%       % pause(0.5)

    % disp(baseOutputDir)
    % Parameters
    % MaxFrequency,MinArea,ExpansionDistance,CropPadding,FrameDepth
    h_vars = [0.2,50,10,15,0];
    saveTrashImages = true;
    minLength = 70;
    minWidth = 70;
    BWthresh = 0.3;
    fps = 21;
    flowRate = 18.0; % liters per s
    tempOutputTable = struct("Filename","","NumFrames",0,"Counts",0,"LitersProcessed",0,"Densities",0);
    tempOutputTable =  repmat(tempOutputTable,length(dirPath)-2,1);
    nbytes = fprintf('Processing 0 of %d', length(dirPath)-2);
    numVids = length(dirPath);
    z = 3;
    while z <= numVids
        tTotal = toc(tStart);
        % tStart = tic;
            fprintf(repmat('\b',1,nbytes))
            nbytes = fprintf('Processing %d of %d (%0.2f min elasped)\n', z-2,length(dirPath)-2,tTotal/60);
        % tStart = tic;
        file = dirPath(z).name;
        outputDir = fullfile(baseOutputDir,strcat(file,"_OrganismDensityCalc"));
        try
        rawVid = read_avi(fullfile(videoDirPath(k),file));
        catch ME
            errorMessages = cat(1,errorMessages,{sprintf("\nUnable to read %s\n%s\n",file,ME.message)});          
            tempOutputTable(z-2) = [];
            allTimes(z-2) = [];
            dirPath(z-2) = [];
            numVids = numVids - 1;
            continue
        end
        vid = standardFlatfield_v2(rawVid,1);
        numFrames = size(vid,3);

        vidTime = numFrames*(1/fps);
        liters = flowRate * vidTime;

        classCounts = getClassDists(vid,BWthresh,h_vars,fullfile(videoDirPath(k),file),saveTrashImages,minLength,minWidth,outputDir,netTable,parallelPool);
        classCounts = classCounts(:,1:6);

        densities = classCounts./liters;

        % spacerStr = sprintf("%s",repmat("+",[1,40]));
        % fprintf("%s Counts: <strong>%0.2f</strong> instances\n",cat(1,classNames,(classCounts)))
        % fprintf("%s\nAssuming a flow-rate of %g L/s:\n%s\n",spacerStr,flowRate,spacerStr)
        % fprintf("%s Density: <strong>%0.2e</strong> counts/L\n",cat(1,classNames,(densities)))
        tempOutputTable(z-2) = struct("Filename",fullfile(videoDirPath(k),file),"NumFrames",numFrames,"Counts",classCounts,"LitersProcessed",liters,"Densities",densities);
        % outputTable = cat(1,outputTable,tempOutput);
        % clearvars -except tTotal dirDate BWthresh outputTable classNames videoDirPath dirPath originalDir baseOutputDir tStart file fps h_vars flowRate netTable parallelPool saveTrashImages minLength minWidth
        % tEnd = toc(tStart);
        % fprintf("%s took %0.2f s or %0.2f min to complete\n",file,tEnd,tEnd/60);
        % fprintf("%0.2f%% Complete (%g/%g)\n",(z-2)/(length(dirPath)-2),z-2,length(dirPath)-2)
        z = z+1;
    end
    % writetable(struct2table(tempOutputTable),fullfile(outputDir,"densityOutput.csv"))
    outputTable = cat(1,outputTable,tempOutputTable);
end
end
    %%
    tTotalEnd = toc(tStart);
    writetable(struct2table(outputTable),fullfile(baseOutputDir,"densityOutput.csv"))
    % densityData = cat(1,outputTable.Densities);
    % fprintf("%s took %0.2f s or %0.2f min to complete\n",string(dirDateStart),tTotalEnd,tTotalEnd/60);
    % fig = figure(Position=[488,338,780,420]);
    % dirDateSpecific = datetime(extract(dirDateStart,digitsPattern(4)+"-"+digitsPattern(2)+"-"+digitsPattern(2)),"InputFormat","yyyy-MM-dd","Format","MM/dd/uuuu");
    % firstTime = extract(dirPath(3).name," "+digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2));
    % firstTime = strjoin(strsplit(string(firstTime),"-"),":");
    % lastTime = extract(dirPath(end).name," "+digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2));
    % lastTime = strjoin(strsplit(string(lastTime),"-"),":");
    % x = [repmat(categorical(classNames(1)),[size(densityData,1),1]),repmat(categorical(classNames(2)),[size(densityData,1),1]),repmat(categorical(classNames(5)),[size(densityData,1),1]),repmat(categorical(classNames(6)),[size(densityData,1),1])];
    % cmap = winter(size(densityData,1));
    % tiledlayout(2,1)
    % nexttile
    % swarmchart(x,densityData(:,[1,2,5,6]),20,"filled",'MarkerFaceAlpha',0.5,'CData',cmap,'MarkerEdgeAlpha',0.5,'XJitter','density','XJitterWidth',0.5)
    % c = colorbar;
    % colormap winter
    % c.Ticks = [0 1];
    % c.TickLabels = [firstTime;lastTime];
    % ylabel("Abudance (Instances/Liter)")
    % title("Calculated PID Abundances",sprintf("for %s %s to %s",dirDateSpecific,firstTime,lastTime))
    % plottingClasses = [1,2,5,6];
    % iter = 0;
    % for z = plottingClasses
    %     iter = iter + 1;
    %     hold on
    %     tempDensity = densityData(:,z);
    %     ci_ppm = bootci(1000,{@mean,tempDensity},'type','per','alpha',.05);
    %     plot([iter-.25,iter+.25],repmat(ci_ppm(1),[1,2]),'--r');
    %     text(iter+.25,ci_ppm(1),sprintf("%0.3f",ci_ppm(1)),"FontSize",10,Rotation=45,VerticalAlignment="bottom")
    %     plot([iter-.25,iter+.25],repmat(ci_ppm(2),[1,2]),'--r');
    %     text(iter+.25,ci_ppm(2),sprintf("%0.3f",ci_ppm(2)),"FontSize",10,Rotation=45,VerticalAlignment="bottom")
    % end
    % exportgraphics(gcf,fullfile(baseOutputDir,strcat(dirDateStart,"_abundancePlot.png")),"Padding","figure");
    % [~,plotOrder] = sort(mean(densityData,1),"descend");
    % % plotOrder = plotIdx(1,:);
    % plotOrder(plotOrder == 3 | plotOrder == 4) = [];
    % nexttile
    % % figure(Position=[488,338,780,420]);
    % hold on
    % for z = plotOrder
    %     a = area(allTimes,densityData(:,z));
    %     a.FaceAlpha = 0.6;
    % end
    % legend(classNames(plotOrder),"Location","northwest")
    % title("Abundance Time Series")
    % ylabel("Abundance (Organisms/Liter)")
    % xlim([allTimes(1),allTimes(end)])
    % % exportgraphics(gcf,fullfile(baseOutputDir,strcat(dirDate,"_abundancePlot_area.png")),"Padding","figure");
    % % yscale("log")
    % % title("Abundance Time Series Log Scale")
    % % exportgraphics(gcf,fullfile(baseOutputDir,strcat(dirDate,"_abundancePlot_area_logScale.png")),"Padding","figure");
    % % exportgraphics(gcf,fullfile(baseOutputDir,strcat(dirDateStart,"_abundancePlots_tiledLayout.png")),"Padding","figure");

