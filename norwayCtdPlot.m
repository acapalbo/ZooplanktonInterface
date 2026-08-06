clear;close all;clc

mkdir norwayInterpPIDdepths

arrDirPath = ["Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_27_22_20_17.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_28_20_44_57.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_28_21_32_56.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_28_23_01_20.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_29_22_10_51.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_30_00_11_13.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_30_01_21_28.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_30_21_31_12.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_30_22_12_58.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_31_18_01_12.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_31_18_11_18.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_31_21_27_13.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_31_22_30_12.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_09_01_19_22_48.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_09_01_19_37_42.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_09_01_21_55_12.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_09_03_17_32_28.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_09_03_19_15_12.mat",...
"Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_09_03_22_39_28.mat"];
vis = true;
allDepthData = {};
allVideoDirs = [];
videoDirPath = "E:\LUMEX03";
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
    tab = struct2table(z);
    depthData = tab.Variables;
    ubatData = depthData.UBAT.Var6;
    ubatTime = depthData.UBAT.Var1;
    ubatDepth = depthData.UBAT.Var2;
    timeData = depthData.ctd49059.("Time (ms)");
    depthData = depthData.ctd49059.("Depth (db)");

    timeInS = milliseconds(timeData);
    [~,fileName] = fileparts(arrDirPath(j));
    startT = extract(fileName,digitsPattern(4)+"_"+digitsPattern(2)+"_"+digitsPattern(2)+"_"+digitsPattern(2)+"_"+digitsPattern(2)+"_"+digitsPattern(2));
    startDateTime = datetime(startT,"InputFormat","yyyy_MM_dd_HH_mm_ss");
    ctdDateTimes = cat(1,ctdDateTimes,startDateTime);
    timeInS = startDateTime + timeInS;
    ubatTimeInS = milliseconds(ubatTime);
    ubatTimeInS = startDateTime + ubatTimeInS;
    depthData(isnat(timeInS)) = [];
    % ubatDepth(isnat(timeInS)) = [];
    % ubatData(isnat(timeInS)) = [];
    % ubatDepth(isnat(timeInS)) = [];
    timeInS(isnat(timeInS)) = [];
    endDateTime = timeInS(end);
    vidIdx = find(videoDateTimes >= startDateTime & videoDateTimes <= endDateTime);
    if vis
        % hold off
        figure
        plot(timeInS,depthData)
        hold on
    end
    allDepthData = cat(1,allDepthData,[{arrDirPath(j)},{depthData}]);
    allCTDtimes = cat(1,allCTDtimes,{timeInS});
    tempCohesiveProfile = [];
    tempCohesiveX = [];
    allUbatData = cat(1,allUbatData,[{ubatData},{ubatTimeInS},{ubatDepth}]);
    
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
        writetable(table(allTimes,interpProfile,'VariableNames',["DateTimes","InterpDepth"]),fullfile("norwayInterpPIDdepths",strcat(cell2mat(fileNames(vidIdx(k))),"_interpProfile.csv")))
    end
    cohesiveX = cat(1,cohesiveX,{tempCohesiveX});
    cohesiveProfile = cat(1,cohesiveProfile,{tempCohesiveProfile});

end

[~,tempFileParts] = fileparts(allVideoDirs);
videoDirDateTimes = datetime(tempFileParts,"InputFormat","uuuu-MM-dd HH-mm-ss");