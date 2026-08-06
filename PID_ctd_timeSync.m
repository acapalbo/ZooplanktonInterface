z = load("Z:\Processing\2024\LUMEX03\DH&P\LUMEX3 Tables\arc001_2024_08_28_20_44_57.mat");
% allTimes = getVidTimes("E:\LUMEX03\2024-08-28 21-14-42.900");
tab = struct2table(z);
depthData = tab.Variables;
timeData = depthData.ctd49059.("Time (ms)");
depthData = depthData.ctd49059.("Depth (db)");
timeInS = milliseconds(timeData);
fileName = "arc001_2024_08_28_20_44_57";
startT = extract(fileName,digitsPattern(4)+"_"+digitsPattern(2)+"_"+digitsPattern(2)+"_"+digitsPattern(2)+"_"+digitsPattern(2)+"_"+digitsPattern(2));
startDateTime = datetime(startT,"InputFormat","yyyy_MM_dd_HH_mm_ss");
timeInS = startDateTime + timeInS;
depthData(isnat(timeInS)) = [];
timeInS(isnat(timeInS)) = [];
endDateTime = timeInS(end);
interpDepth = interp1(timeInS,-depthData,allTimes,"pchip");
plot(timeInS,-depthData)
hold on
plot(allTimes,interpDepth,"*r")

writematrix(interpDepth,"interpolatedDepthProfile_20_44.csv");
%%
% % allTimes(end) = [];
% % interpDepth(end) = [];
% plot(timeInS,-depthData)
% hold on
% plot(allTimes,interpDepth,"*r")
% interpDepth = interp1(timeInS,-depthData,allTimes,"pchip");
% plot(timeInS,-depthData)
% hold on
% plot(allTimes,interpDepth,"*r")
% % interpDepth(end) = interpDepth(end-1);
% plot(timeInS,-depthData)
% hold on
% plot(allTimes,interpDepth,"*r")