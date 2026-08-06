imgDirPath = "D:\HBOI_Work\CumulativeDataset_v2";
classFiles = dir(imgDirPath);
allBw = struct("classes",[]);
allImgs = struct("classes",[]);
idx = [];
allData = [];
for j = 3:length(classFiles)
    tempClassPath = fullfile(imgDirPath,classFiles(j).name);
    imgDirFiles = dir(tempClassPath);
    tempBw = {};
    tempImgs = {};
for z = 3:length(imgDirFiles)
    tempImg = imread(fullfile(tempClassPath,imgDirFiles(z).name));
    bw = logical(mask_object_super_pixel(tempImg));
    tempBw = cat(1,tempBw,bw);
    tempImg(~bw) = 0;
    allData = cat(1,allData,[mean(tempImg(bw)),std(double(tempImg(bw))),nnz(bwperim(bw))]);
    idx = cat(1,idx,j-2);
    tempImgs = cat(1,tempImgs,tempImg);
end
% allBw = cat(1,allBw,struct("classBws",tempBw));
allBw(j-2).classes = tempBw;
allImgs(j-2).classes = tempImgs;
tempBw = {};
tempImgs = {};
end

%%

chImgs = allImgs(1).classes;
chMean = cellfun(@(x)mean(x(:)),chImgs);
crImgs = allImgs(2).classes;
crMean = cellfun(@(x)mean(x(:)),crImgs);
gImgs = allImgs(3).classes;
gMean = cellfun(@(x)mean(x(:)),gImgs);
lImgs = allImgs(4).classes;
lMean = cellfun(@(x)mean(x(:)),lImgs);

chImgs = allImgs(1).classes;
chStd = cellfun(@(x)std(double(x(:))),chImgs);
crImgs = allImgs(2).classes;
crStd = cellfun(@(x)std(double(x(:))),crImgs);
gImgs = allImgs(3).classes;
gStd = cellfun(@(x)std(double(x(:))),gImgs);
lImgs = allImgs(4).classes;
lStd = cellfun(@(x)std(double(x(:))),lImgs);

% chMean = rmoutliers(chMean);
% crMean = rmoutliers(crMean);
% gMean = rmoutliers(gMean);
% lMean = rmoutliers(lMean);
% chStd = rmoutliers(chStd);
% crStd = rmoutliers(crStd);
% gStd = rmoutliers(gStd);
% lStd = rmoutliers(lStd);

chMeanCounts = histcounts(chMean,0:1:45);
crMeanCounts = histcounts(crMean,0:1:45);
gMeanCounts = histcounts(gMean,0:1:45);
lMeanCounts = histcounts(lMean,0:1:45);

chStdCounts = histcounts(chStd,0:1:75);
crStdCounts = histcounts(crStd,0:1:75);
gStdCounts = histcounts(gStd,0:1:75);
lStdCounts = histcounts(lStd,0:1:75);

% chMeanCounts = chMeanCounts./max(chMeanCounts);
% crMeanCounts = crMeanCounts./max(crMeanCounts);
% gMeanCounts = gMeanCounts./max(gMeanCounts);
% lMeanCounts = lMeanCounts./max(lMeanCounts);
chMeanCounts = (chMeanCounts./numel(chMean))*100;
crMeanCounts = (crMeanCounts./numel(crMean))*100;
gMeanCounts = (gMeanCounts./numel(gMean))*100;
lMeanCounts = (lMeanCounts./numel(lMean))*100;
chStdCounts = (chStdCounts./numel(chStd))*100;
crStdCounts = (crStdCounts./numel(crStd))*100;
gStdCounts = (gStdCounts./numel(gStd))*100;
lStdCounts = (lStdCounts./numel(lStd))*100;
figure("Theme","light")
plot(chMeanCounts);
hold on
plot(crMeanCounts)
plot(gMeanCounts)
plot(lMeanCounts)

plot(chMeanCounts,"o");
hold on
plot(crMeanCounts,"o")
plot(gMeanCounts,"o")
plot(lMeanCounts,"o")

figure("Theme","light")
plot(chStdCounts);
hold on
plot(crStdCounts)
plot(gStdCounts)
plot(lStdCounts)

plot(chStdCounts,"o");
hold on
plot(crStdCounts,"o")
plot(gStdCounts,"o")
plot(lStdCounts,"o")
figure("Theme","light")
histogram(crMean)
hold on
histogram(gMean)
histogram(lMean)
histogram(chMean)

figure("Theme","light")

histogram(crStd)
hold on
histogram(gStd)
histogram(lStd)
histogram(chStd)