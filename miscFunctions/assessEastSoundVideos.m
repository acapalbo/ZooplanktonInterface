clear;clc;close all

ctdFiles = ["Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-00_20_2.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-00_32_5.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-00_35_3.mat" %
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-00_56_0.mat" %
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-01_30_0.mat" %
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-02_11_0.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-03_18_4.mat" %
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-03_41_1.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-04_03_5.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-06_11_3.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-08_09_4.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-08_46_2.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-09_59_3.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-10_28_5.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-11_01_2.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-11_09_3.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-11_53_2.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-12_07_3.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-12_34_3.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-13_01_4.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-13_54_1.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-14_12_4.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-14_58_0.mat"
"Z:\Processing\2024\LUMEX02\DH&P\Processed\Proc3_saved07xx\arc001_2024_05_18-17_01_3.mat"];

pidDir = ["E:\LUMEX2\PID\2024-05-18 00-28-57.597"
"E:\LUMEX2\PID\2024-05-18 00-37-24.560"
"E:\LUMEX2\PID\2024-05-18 00-59-45.637"
"E:\LUMEX2\PID\2024-05-18 03-00-53.701"
"E:\LUMEX2\PID\2024-05-18 03-24-54.218"
"E:\LUMEX2\PID\2024-05-18 03-48-15.239"
"E:\LUMEX2\PID\2024-05-18 05-05-07.302"
"E:\LUMEX2\PID\2024-05-18 05-25-20.188"
"E:\LUMEX2\PID\2024-05-18 05-46-09.303"
"E:\LUMEX2\PID\2024-05-18 06-07-04.209"
"E:\LUMEX2\PID\2024-05-18 06-14-56.114"
"E:\LUMEX2\PID\2024-05-18 08-15-53.373"
"E:\LUMEX2\PID\2024-05-18 08-35-21.477"
"E:\LUMEX2\PID\2024-05-18 08-51-38.712"
"E:\LUMEX2\PID\2024-05-18 10-03-46.041"
"E:\LUMEX2\PID\2024-05-18 10-34-31.237"
"E:\LUMEX2\PID\2024-05-18 11-06-18.458"
"E:\LUMEX2\PID\2024-05-18 11-15-12.638"
"E:\LUMEX2\PID\2024-05-18 11-55-55.209"
"E:\LUMEX2\PID\2024-05-18 12-12-24.583"
"E:\LUMEX2\PID\2024-05-18 12-29-27.052"
"E:\LUMEX2\PID\2024-05-18 13-07-26.440"
"E:\LUMEX2\PID\2024-05-18 13-56-43.320"
"E:\LUMEX2\PID\2024-05-18 14-15-06.170"
"E:\LUMEX2\PID\2024-05-18 14-36-10.794"
"E:\LUMEX2\PID\2024-05-18 15-03-16.613"
"E:\LUMEX2\PID\2024-05-18 17-05-40.659"];


%%
    tempVideos = dir(pidDir(27));

    s = load(ctdFiles(end));
    data = s.arc001.sensors.ctd49059.data.data.raw;
    depthData = data(:,2);
    tempData = data(:,3);
    conductData = data(:,4);
    salData = data(:,5);
    sigmaTdata = data(:,6);
    startT = datetime(2024,5,18,17,1,3);
v1 = VideoWriter("eastSoundDepthProfile_v2.avi","Motion JPEG AVI");

v1.FrameRate = 15;
open(v1)
    timeVals = startT + milliseconds(data(:,1));
    allDepths = [];
    allTemp = [];
    allConductivity = [];
    allSalinity = [];
    allSigmaT = [];
    allVals = {};
allTimes = [];
allPaths = [];
videoTitle = tempVideos(3).name;
tempTime = extract(videoTitle,digitsPattern(4)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+ " " + digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+"."+digitsPattern(3));
startTime = datetime(string(tempTime),"InputFormat","yyyy-MM-dd HH-mm-ss.SSS");
tStart = tic;
figure("Theme","Light")
allAreaVals = zeros(1,256);
allMeanVals = zeros(1,256);
delete(gcp("nocreate"))
pool = parpool("Threads");
totalAreaVals = [];
totalMeanVals = [];
for z = 27
    tempVideos = dir(pidDir(z));
    tempVals = [];
    nbytes = fprintf("Beginning Process...\n");
    for k = 3:length(tempVideos)
        try
            vid = read_avi(fullfile(pidDir(z),tempVideos(k).name));
        catch
            % fprintf(repmat('\b',1,nbytes))
            fprintf("%s failed\n",tempVideos(k).name);
            nbytes = fprintf('Processing %d of %d (%0.2f min elasped)\n', k-3,length(tempVideos)-2,tTotal/60);
            continue
        end
    tTotal = toc(tStart);
    %
    fprintf(repmat('\b',1,nbytes))
    nbytes = fprintf('Processing %d of %d (%0.2f min elasped)\n', k-3,length(tempVideos)-2,tTotal/60);
        allPaths = cat(1,allPaths,fullfile(pidDir(z),tempVideos(k).name));
        ffVid = standardFlatfield_v2(vid,1,50);
        videoTitle = tempVideos(k).name;
        tempTime = extract(videoTitle,digitsPattern(4)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+ " " + digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+"."+digitsPattern(3));
        tempTime = datetime(string(tempTime),"InputFormat","yyyy-MM-dd HH-mm-ss.SSS");
        if k ~= length(tempVideos)
            nextTitle = tempVideos(k+1).name;
            nextTime = extract(nextTitle,digitsPattern(4)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+ " " + digitsPattern(2)+"-"+digitsPattern(2)+"-"+digitsPattern(2)+"."+digitsPattern(3));
            nextTime = datetime(string(nextTime),"InputFormat","yyyy-MM-dd HH-mm-ss.SSS");
            timePerFrame = linspace(tempTime,nextTime,size(vid,3));
        else
            fps = 22;
            numFrames = size(vid,3);
            timeElapsed = numFrames/fps;
            timePerFrame = linspace(tempTime,tempTime + seconds(timeElapsed),numFrames);
        end
        % tempTime = tempTime(2);
        allTimes = cat(1,allTimes,timePerFrame');
        allDepths = cat(1,allDepths,interp1(timeVals,depthData,timePerFrame)');
        allTemp = cat(1,allTemp,interp1(timeVals,tempData,timePerFrame)');
        allConductivity = cat(1,allConductivity,interp1(timeVals,conductData,timePerFrame)');
        allSalinity = cat(1,allSalinity,interp1(timeVals,salData,timePerFrame)');
        allSigmaT = cat(1,allSigmaT,interp1(timeVals,sigmaTdata,timePerFrame)');
        cellVid = squeeze(mat2cell(ffVid,2048,2440,repmat(1,size(vid,3),1)));
        meanVals = cellfun(@(x) mean(x(:)),cellVid);
        stdVals = cellfun(@(x) std(double(x(:))),cellVid);
        entropyVals = cellfun(@(x) entropy(x(:)),cellVid);
        tempVals = cat(1,tempVals,[meanVals,stdVals,entropyVals]);
        
        for j = 1:size(vid,3)
              img = ffVid(:,:,j);
        parfor x = 0:255

            bw = bwmorph(img <= x,"Majority",5);
            % CC = bwconncomp(bw,8);
            areaProp = regionprops(bw,"Area");
            areaVal = cat(1,areaProp.Area);

            % val = CC.NumObjects;
            % allVals = cat(1,allVals,[length(areaVal),mean(areaVal),std(areaVal)]);
            % tempVals = cat(2,tempVals,length(areaVal));
            allAreaVals(x+1) = length(areaVal);
            allMeanVals(x+1) = std(areaVal);
        end
        % allVals = cat(1,allVals,tempVals);
        % tempVals = [];
        [maxVal,maxIdx] = max(allAreaVals);
            bw = bwmorph(img <= maxIdx,"Majority",5);
        totalAreaVals = cat(1,totalAreaVals,allAreaVals);
        totalMeanVals = cat(1,totalMeanVals,allMeanVals);

            plot(timeVals,-depthData,"LineWidth",5);
            plotLim = xlim;
            xlim([startTime,plotLim(2)])
            xline(timePerFrame(j),"LineWidth",3);
            f = getframe(gcf);
            plotData = f.cdata;
            % outImg = cat(3,ffVid(:,:,j),ffVid(:,:,j),ffVid(:,:,j));
            outImg = labeloverlay(img,bwlabel(bw));
            plotData = imresize(plotData,0.75);
            outImg(1:size(plotData,1),(end-size(plotData,2)+1):end,:) = plotData;
            writeVideo(v1,outImg);
        end
    end
    allVals = cat(1,allVals,{tempVals});
end
close(v1)
%%

% for z = 24
%     figure
%     s = load(ctdFiles(z));
%     data = s.arc001.sensors.ctd49059.data.data.raw;
%     plot(data(:,2))
%     pause(2)
% 
% end
%%
% startT = datetime(2024,5,18,17,1,3);
% 
% timeVals = startT + milliseconds(data(:,1));
% plot(timeVals,data(:,2));
% xline(allTimes)