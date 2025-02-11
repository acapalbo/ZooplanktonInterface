function [previousData,runDate] = check4Dat(filePath,checkFor)
    fileTable = struct2table(dir(filePath));
    fileTable(1:2,:) = [];
    fileNames = fileTable.name;
    if ~any(startsWith(fileNames,checkFor))
        previousData = -1;
        runDate = -1;
        return
    else
        latestDate = max(fileTable.datenum((startsWith(fileNames,checkFor))));
        runDate = fileTable.date(fileTable.datenum == latestDate);
        previousDataFolder = fileTable.name(fileTable.datenum == latestDate)
        if exist(fullfile(filePath,previousDataFolder,"runSettings.dat"))
            previousData = readmatrix(fullfile(filePath,previousDataFolder,"runSettings.dat"),delimitedTextImportOptions('DataLines',[1,Inf]));
        else
            previousData = -1;
            return
        end
        if length(previousData) <= 6
            previousData = -1;
        end
    end

end