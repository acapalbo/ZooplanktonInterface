nicheOutputs = "D:\ZooPlanktonOutputs\OrganismDensityCalc_2024-09-03 19-13-28.040_2024-09-04 00-01-51.219(1)_niche(4)";
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
% for k = 13:length(dataFiles)
    tempOutputDir = fullfile(dataFolders);
    tableData = readtable(fullfile(tempOutputDir,"densityOutput.csv"));
    nicheTableData = readtable(fullfile(nicheOutputs,"densityOutput.csv"));
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
