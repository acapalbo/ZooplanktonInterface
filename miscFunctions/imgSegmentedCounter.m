filePath = "C:\Users\acapalbo\ZooplanktonInterface\ZooPlanktonBatchOutput_020525(6)\SegmentationOutput\SegmentationOutput_MyCamera-002-2024-03-04 02-14-09.781precise_ff\TableInfo_02_05_25";
csvFiles = dir(filePath);
allLengths = 0;
for z = 3:length(csvFiles)
    tempCSV = readmatrix(fullfile(filePath,csvFiles(z).name));
    allLengths = cat(1,allLengths,length(tempCSV));
end
allLengths(1)=[];