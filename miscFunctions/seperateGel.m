%% Seperate Gelatinous

gelPath = "C:\Users\acapalbo\HBOI_Work\CumulativeDataset_v2\6";
gelImgs = dir(gelPath);
gelImgs = struct2table(gelImgs);
fileNames = gelImgs.name;
fileNames(1:2) = [];

datePattern = digitsPattern(4) + "-" + digitsPattern(2) + "-" + digitsPattern(2) + " " + digitsPattern(2) + "-" + digitsPattern(2) + "-" + digitsPattern(2);
imgDates = extract(fileNames,datePattern);
possibleDates = unique(imgDates);

imgDates = char(imgDates);

m = double(string(imgDates(:,7)));

GoMdates = fileNames(m >= 2 & m <= 3);
NorwayDates = fileNames(m >= 8 & m <= 9);
SargassoDates = fileNames(m == 5);
mkdir GoMGel
mkdir NorwayGel
mkdir SargassoGel

for z = 1:length(GoMdates)
copyfile(fullfile(gelPath,GoMdates(z)),fullfile("GoMGel",GoMdates(z)))
end
for z = 1:length(NorwayDates)
copyfile(fullfile(gelPath,NorwayDates(z)),fullfile("NorwayGel",NorwayDates(z)))
end
for z = 1:length(SargassoDates)
copyfile(fullfile(gelPath,SargassoDates(z)),fullfile("SargassoGel",SargassoDates(z)))
end
