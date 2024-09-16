imgFolder = "C:\Users\acapa\HBOI_work\EastSoundAnalysis\UncategorizedDataset";

mkdir netPredictions
cd netPredictions
Files = dir(imgFolder);
z = 3;

classLabels = unique(labelScores(:));
for j = 1:length(classLabels)
    mkdir(string(classLabels(j)));
end    

for i = 1:length(labelScores)
        predictionDir = string(labelScores(i));
        tempImg = Files(z).name;
        movefile(strcat(imgFolder,"\",Files(z).name),strcat(".\",predictionDir,"\",Files(z).name));
        z = z + 1;

end    