clear; clc;
dirPath ="E:\LUMEX2\PID\2024-05-18 17-05-40.659";

vidFiles = dir(dirPath);

vid = read_avi(fullfile(dirPath,vidFiles(3+13).name));
ffVid = standardFlatfield_v2(vid,1);
frame1 = vid(:,:,1);
frame2 = vid(:,:,2);
vidRaw = vid;
vid = ffVid;
%%
allDistanceVals = [];
for z = 1:size(vid,3)-1
    frame = vid(:,:,[z,z+1]);
     % = vid(:,:,z+1);
     allFeatures = {};
     allCorners = {};
    for j = 1:2
        corners = detectSURFFeatures(frame(:,:,j));
        [features,valid_corners] = extractFeatures(frame(:,:,j),corners);
        allFeatures = cat(1,allFeatures,{features});
        allCorners = cat(1,allCorners,{valid_corners});
    end
    [indexPairs,matchMetric] = matchFeatures(cell2mat(allFeatures(1)),cell2mat(allFeatures(2)),"MatchThreshold",0.5);
    meanMetric = mean(matchMetric(:));
    [sortedVals,sortIdx] = sort(matchMetric);
    indexPairs = indexPairs(sortIdx,:);
    indexPairs = indexPairs(1:min(5,size(indexPairs,1)),:);
    % indexPairs(matchMetric > meanMetric - std(matchMetric(:)),:) = [];
    matchedPoints1 = cell2mat(allCorners(1));
    matchedPoints1 = matchedPoints1(indexPairs(:,1));
    matchedPoints2 = cell2mat(allCorners(2));
    matchedPoints2 = matchedPoints2(indexPairs(:,2));
    matchedPoints2 = matchedPoints2.Location;
matchedPoints1 = matchedPoints1.Location;
    xDistances = matchedPoints2(:,1) - matchedPoints1(:,1);
    yDistances = matchedPoints2(:,2) - matchedPoints1(:,2);
    slopeDistances = sqrt(xDistances.^2 + yDistances.^2);
    % figure; showMatchedFeatures(frame(:,:,1),frame(:,:,2),matchedPoints1,matchedPoints2);
    % pause
    % close all
    distanceVals = {xDistances,yDistances,slopeDistances};
    allDistanceVals = cat(1,allDistanceVals,distanceVals);
end