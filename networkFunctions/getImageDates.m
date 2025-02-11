% requires dataset path for first input variable
% optionally can include class names
function dateCounts = getImageDates(varargin)
    dateCounts = 0;
    datasetPath = string(varargin(1));

    classes = dir(datasetPath);
    % check for classNames
    if nargin == 2
        classNames = table2array(cell2table(varargin(2)));
    else
        classNames = string(1:length(classes)-2);
    end
    datePattern = digitsPattern(4) + "-" + digitsPattern(2) + "-" + digitsPattern(2) + " " + digitsPattern(2) + "-" + digitsPattern(2) + "-" + digitsPattern(2);
    for j = 3:length(classes)
        imgs = dir(fullfile(datasetPath,classes(j).name));
        tbl = struct2table(imgs);
        fileNames = tbl.name;
        fileNames(1:2) = [];
        imgDates = extract(fileNames,datePattern);
        uniqueDates = unique(imgDates);
        if exist("totalDates")
            totalDates = cat(1,totalDates,uniqueDates);
        else
            totalDates = uniqueDates;
        end
    end
    possibleDates = unique(totalDates);
    
    sz = [length(possibleDates)+1,length(classNames)+1];
    dateCounts = table('Size',sz,'VariableTypes',["string",repmat("double",[1 length(classNames)])],'VariableNames',["possibleDates",classNames]);
    dateCounts(1:end-1,1) = possibleDates;
    dateCounts(end,1)={"Total"};
    for k = 3:length(classes)
        imgs = dir(fullfile(datasetPath,classes(k).name));
        fprintf("Beginning class <strong>%s</strong>\n",string(classNames(k-2)))
        tbl = struct2table(imgs);
        fileNames = tbl.name;
        fileNames(1:2) = [];
        imgDates = extract(fileNames,datePattern);
        totalCounts = 0;
        for z = 1:length(possibleDates)
            tempCount = nnz(string(imgDates) == string(possibleDates(z)));
            fprintf("<strong>%g</strong> organims for %s\n",tempCount,string(possibleDates(z)))
            dateCounts(z,k-1) = {tempCount};
            totalCounts = totalCounts + tempCount;
        end
        dateCounts(end,k-1)= {totalCounts};
    end
end