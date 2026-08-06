clear;clc
vidFolder = "D:\miscFiles\2024-12-04 19-55-33.971_PID_focus_videos\CorrectOrder";

vidFiles = dir(vidFolder);

allVids = {};
allFrames = [];
allMeans = [];
allBw = [];
allBWCirc = {};
allRawCirc = {};
allRad = [];
allRingVals = {};
allFeretVals = [];
allPlots = {};
allRads = [];
for z = 3:length(vidFiles)
    bwThresh = 0.7;
    tempVid = read_avi(fullfile(vidFolder,vidFiles(z).name));
    frame = tempVid(:,:,1);
    frame = frame(100:end-99,100:end-99);
    bw = imbinarize(imcomplement(frame),bwThresh);
    meanFrame = min(tempVid,[],3);
    [circ,rad] = imfindcircles(bw,[50,150]);
    while isempty(rad)
        bwThresh = bwThresh - 0.05;
        bw = imbinarize(imcomplement(frame),bwThresh);
        [circ,rad] = imfindcircles(bw,[50,60]);
    end

    if length(rad) > 1
        [rad,radIdx] = max(rad);
        circ = circ(radIdx,:);
    end

    rawCirc = frame((floor(circ(1,2)) - ceil(rad*1.1)):(floor(circ(1,2)) + ceil(rad*1.1)),(floor(circ(1,1)) - ceil(rad*1.1)):(floor(circ(1,1)) + ceil(rad*1.1)));
    bwCirc = bw((floor(circ(1,2)) - ceil(rad*1.1)):(floor(circ(1,2)) + ceil(rad*1.1)),(floor(circ(1,1)) - ceil(rad*1.1)):(floor(circ(1,1)) + ceil(rad*1.1)));
    bwCirc = bwareafilt(bwCirc,1);
    allRingVals = cat(1,allRingVals,{rawCirc(bwCirc)});
    allRad = cat(1,allRad,rad);
    allBWCirc = cat(1,allBWCirc,{imfill(bwCirc,"holes")});
    filledCircle = imfill(bwCirc,"holes");
    feretProps = regionprops(filledCircle,"MinFeretProperties","MaxFeretProperties");
        minDiameter = feretProps.MinFeretDiameter;
        maxDiameter = feretProps.MaxFeretDiameter;
    feretCoordsMin = feretProps.MinFeretCoordinates;
    feretCoordsMax = feretProps.MaxFeretCoordinates;
    distRad = max(bwdist(imcomplement(filledCircle)),[],"all");
    % figure
    % imshow(rawCirc);hold on
    % plot(feretCoordsMin(:,1),feretCoordsMin(:,2),'--r',"LineWidth",1)
    % plot(feretCoordsMax(:,1),feretCoordsMax(:,2),'--b',"LineWidth",1);
    % 
    % text(mean(feretCoordsMin(:,1)),mean(feretCoordsMin(:,2)),string(minDiameter));
    % text(mean(feretCoordsMax(:,1)),mean(feretCoordsMax(:,2)),string(maxDiameter));
    % ax = gca;
    % f = getframe(ax);
    % allPlots = cat(1,allPlots,f.cdata);
    allRads = cat(1,allRads,distRad);
    allFeretVals = cat(1,allFeretVals,minDiameter);
    allRawCirc = cat(1,allRawCirc,{rawCirc});
    allFrames = cat(3,allFrames,frame);
    allMeans = cat(3,allMeans,meanFrame);
    allBw = cat(3,allBw,bw);
    allVids = cat(1,allVids,{tempVid});
end