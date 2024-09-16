[~,sheets] = xlsfinfo(statFilePath);
for i = 1:length(sheets)
    maxVal = 0;
    csv = readmatrix(statFilePath,"Sheet",i);
    if exist('fullCsv') == 0
        fullCsv = csv;
    else
        fullCsv = cat(1,fullCsv,csv);
    end
end