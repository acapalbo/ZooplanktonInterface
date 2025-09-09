%% Choose Video
close all;clear;clc;

neuralNet = "C:\Users\acapalbo\HBOI_Work\trainedNetworks\adaptedXception_DS_v6.1.mat";

classNames = ["Chaetognaths","Crustaceans","DetritusA","DetritusB","Gelatinous","Larvaceans"];
videoDirPath = uigetdir("*.*");

baseOutputDir = "D:\ZooPlanktonOutputs";
outputTable = [];
%% Begin Algorithm
if videoDirPath ~= 0 
    tTotal = tic;
    dirDate = strsplit(videoDirPath,"\");
    dirDate = dirDate(end);
    dirPath = dir(videoDirPath);
    netTable = load(neuralNet);
    outputTitle = strcat("OrganismDensityCalc_",string(dirDate));
    % setup output directory
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
    disp(baseOutputDir)
    % Parameters
    % MaxFrequency,MinArea,ExpansionDistance,CropPadding,FrameDepth
    h_vars = [0.2,50,5,5,0];
    saveTrashImages = true;
    minLength = 70;
    minWidth = 70;
    BWthresh = 0.4;
    fps = 21;
    flowRate = 18.0; % liters per s

    delete(gcp("nocreate"))
    parallelPool = parpool("Threads");

    for z = 3:length(dirPath)
        tStart = tic;
        file = dirPath(z).name;
        outputDir = fullfile(baseOutputDir,strcat(file,"_OrganismDensityCalc"));
        rawVid = read_avi(fullfile(videoDirPath,file));

        vid = standardFlatfield_v2(rawVid,1);
        numFrames = size(vid,3);

        vidTime = numFrames*(1/fps);
        liters = flowRate * vidTime;

        classCounts = getClassDists(vid,BWthresh,h_vars,fullfile(videoDirPath,file),saveTrashImages,minLength,minWidth,outputDir,netTable,parallelPool);
        classCounts = classCounts(:,1:6);

        densities = classCounts./liters;

        spacerStr = sprintf("%s",repmat("+",[1,40]));
        fprintf("%s Counts: <strong>%0.2f</strong> instances\n",cat(1,classNames,(classCounts)))
        fprintf("%s\nAssuming a flow-rate of %g L/s:\n%s\n",spacerStr,flowRate,spacerStr)
        fprintf("%s Density: <strong>%0.2e</strong> counts/L\n",cat(1,classNames,(densities)))
        tempOutput = struct("Filename",fullfile(videoDirPath,file),"NumFrames",numFrames,"Counts",classCounts,"LitersProcessed",liters,"Densities",densities);
        outputTable = cat(1,outputTable,tempOutput);
        clearvars -except tTotal dirDate BWthresh outputTable classNames videoDirPath dirPath originalDir baseOutputDir tStart file fps h_vars flowRate netTable parallelPool saveTrashImages minLength minWidth
        tEnd = toc(tStart);
        fprintf("%s took %0.2f s or %0.2f min to complete\n",file,tEnd,tEnd/60);
    end
    tTotalEnd = toc(tTotal);
    writetable(struct2table(outputTable),fullfile(baseOutputDir,"densityOutput.csv"))
    densityData = cat(1,outputTable.Densities);
    fprintf("%s took %0.2f s or %0.2f min to complete\n",string(dirDate),tTotalEnd,tTotalEnd/60);
    
    fig = figure(Position=[488,338,780,420]);
    dirDateSpecific = datetime(extract(dirDate,digitsPattern(4)+"-"+digitsPattern(2)+"-"+digitsPattern(2)),"InputFormat","yyyy-MM-dd","Format","MM/dd/uuuu");
    firstTime = extract(dirPath(3).name," "+digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2));
    firstTime = strjoin(strsplit(string(firstTime),"-"),":");
    lastTime = extract(dirPath(end).name," "+digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2));
    lastTime = strjoin(strsplit(string(lastTime),"-"),":");
    x = [repmat(categorical(classNames(1)),[size(densityData,1),1]),repmat(categorical(classNames(2)),[size(densityData,1),1]),repmat(categorical(classNames(5)),[size(densityData,1),1]),repmat(categorical(classNames(6)),[size(densityData,1),1])];
    cmap = winter(size(densityData,1));
    swarmchart(x,densityData(:,[1,2,5,6]),20,"filled",'MarkerFaceAlpha',0.5,'CData',cmap,'MarkerEdgeAlpha',0.5,'XJitter','density','XJitterWidth',0.5)
    c = colorbar;
    colormap winter
    c.Ticks = [0 1];
    c.TickLabels = [firstTime;lastTime];
    ylabel("Abudance (Instances/Liter)")
    title("Calculated PID Abundances",sprintf("for %s %s to %s",dirDateSpecific,firstTime,lastTime))
    plottingClasses = [1,2,5,6];
    iter = 0;
    for z = plottingClasses
        iter = iter + 1;
        hold on
        tempDensity = densityData(:,z);
        ci_ppm = bootci(1000,{@mean,tempDensity},'type','per','alpha',.05);
        plot([iter-.25,iter+.25],repmat(ci_ppm(1),[1,2]),'--r');
        text(iter+.25,ci_ppm(1),sprintf("%0.3f",ci_ppm(1)),"FontSize",10,Rotation=45,VerticalAlignment="bottom")
        plot([iter-.25,iter+.25],repmat(ci_ppm(2),[1,2]),'--r');
        text(iter+.25,ci_ppm(2),sprintf("%0.3f",ci_ppm(2)),"FontSize",10,Rotation=45,VerticalAlignment="bottom")
    end
    exportgraphics(gcf,fullfile(baseOutputDir,strcat(dirDate,"_abundancePlot.png")));
end