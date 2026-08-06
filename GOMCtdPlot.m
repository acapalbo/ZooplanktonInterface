clear;close all;clc

mkdir GOMInterpPIDdepths

arrDirPath = ["Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_02_26-09_40_15.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_02_27-02_15_17.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_02_27-07_37_40.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_02_27-07_56_38.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_02_28-12_38_24.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_02_29-01_57_27.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_02_29-02_29_24.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_02_29-12_48_45.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_01-01_18_27.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_01-03_59_11.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_02-09_06_17.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_03-01_05_40.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_03-02_09_14.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_03-02_38_09.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_03-02_50_52.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_03-03_28_01.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_03-04_01_55.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_04-02_19_52.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_04-04_00_23.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_04-07_12_07.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_04-07_27_47.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_05-01_04_28.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_05-04_04_21.mat",...
"Z:\Processing\2024\LUMEX1\DH&P\arc1_3_5logger_run_2024_03_05-04_26_59.mat"];
vis = true;
allDepthData = {};
allVideoDirs = [];
videoDirPath = "E:\202402XX_LUMEX1\PID";
videoFiles = dir(videoDirPath);
videoTab = struct2table(videoFiles);
fileNames = videoTab.name;
fileNames(1:2) = [];
videoDateTimes = datetime(fileNames,"InputFormat","yyyy-MM-dd HH-mm-ss.SSS");
ctdDateTimes = [];
allInterpProfiles = {};
cohesiveX = {};
cohesiveProfile = {};
allCTDtimes = {};
allUbatData = {};
C = orderedcolors("gem");
for j = 1:length(arrDirPath)
    z = load(arrDirPath(j));
    if isempty(fieldnames(z))
        continue
    end
    tab = struct2table(z);
    depthData = tab.Variables;
    depthData = depthData.sensors;
    % ubatData = depthData.UBAT.Var6;
    % ubatTime = depthData.UBAT.Var1;
    % ubatDepth = depthData.UBAT.Var2;
    ctdData = depthData.ctd49059.data.data.raw;
    timeData = ctdData(:,1);
    depthData = ctdData(:,2);

    timeInS = milliseconds(timeData);
    [~,fileName] = fileparts(arrDirPath(j));
    startT = extract(fileName,digitsPattern(4)+"_"+digitsPattern(2)+"_"+digitsPattern(2)+"-"+digitsPattern(2)+"_"+digitsPattern(2)+"_"+digitsPattern(2));
    startDateTime = datetime(startT,"InputFormat","yyyy_MM_dd-HH_mm_ss");
    ctdDateTimes = cat(1,ctdDateTimes,startDateTime);
    timeInS = startDateTime + timeInS;
    % ubatTimeInS = milliseconds(ubatTime);
    % ubatTimeInS = startDateTime + ubatTimeInS;
    depthData(isnat(timeInS)) = [];
    % ubatDepth(isnat(timeInS)) = [];
    % ubatData(isnat(timeInS)) = [];
    % ubatDepth(isnat(timeInS)) = [];
    timeInS(isnat(timeInS)) = [];
    endDateTime = timeInS(end);
    vidIdx = find(videoDateTimes >= startDateTime & videoDateTimes <= endDateTime);
    if vis & ~isempty(vidIdx)
        % hold off
        figure
        plot(timeInS,depthData)
        hold on
    end
    allDepthData = cat(1,allDepthData,[{arrDirPath(j)},{depthData}]);
    allCTDtimes = cat(1,allCTDtimes,{timeInS});
    tempCohesiveProfile = [];
    tempCohesiveX = [];
    % allUbatData = cat(1,allUbatData,[{ubatData},{ubatTimeInS},{ubatDepth}]);
    
    for k = 1:length(vidIdx)

        allTimes = getVidTimes(fullfile(videoDirPath,cell2mat(fileNames(vidIdx(k)))));
        allVideoDirs = cat(1,allVideoDirs,fullfile(videoDirPath,cell2mat(fileNames(vidIdx(k)))));
        
        interpProfile = interp1(timeInS,depthData,allTimes,"nearest");
        allInterpProfiles = cat(1,allInterpProfiles,{interpProfile});
        tempCohesiveProfile = cat(1,tempCohesiveProfile,interpProfile);
        tempCohesiveX = cat(1,tempCohesiveX,allTimes);
        if any(isnan(interpProfile))
            % fprintf("NaN on %g %g profile\n",j,k)
        end
        if vis
            xline(allTimes,"--","Color",C(k,:));
            plot(allTimes,interpProfile,"*","Color",C(k,:))
        end
        writetable(table(allTimes,interpProfile,'VariableNames',["DateTimes","InterpDepth"]),fullfile("GOMInterpPIDdepths",strcat(cell2mat(fileNames(vidIdx(k))),"_interpProfile.csv")))
    end
    cohesiveX = cat(1,cohesiveX,{tempCohesiveX});
    cohesiveProfile = cat(1,cohesiveProfile,{tempCohesiveProfile});

end

[~,tempFileParts] = fileparts(allVideoDirs);
videoDirDateTimes = datetime(tempFileParts,"InputFormat","uuuu-MM-dd HH-mm-ss");