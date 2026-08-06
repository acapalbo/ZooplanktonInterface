clear;clc

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



% vid = read_avi("E:\LUMEX2\PID\2024-05-18 03-48-15.239\MyCamera-003-2024-05-18 03-49-51.130.avi");
% ffVid = standardFlatfield_v2(vid,1.2,20);
%%
% img = ffVid(:,:,5);
% allVals = [];
% tempVals = [];
allAreaVals = zeros(1,256);
allMeanVals = zeros(1,256);
delete(gcp("nocreate"))
pool = parpool("Threads");
totalAreaVals = [];
totalMeanVals = [];
tempVideos = dir(pidDir(27));

% for j = 3:length(tempVideos)
for j = 3
    try
        vid = read_avi(fullfile(pidDir(27),tempVideos(j).name));
    catch
        % fprintf(repmat('\b',1,nbytes))
        fprintf("%s failed\n",tempVideos(k).name);
        % nbytes = 0;
        continue
    end
    ffVid = standardFlatfield_v2(vid,1.2,20);
    for z = 1:size(ffVid,3)
        img = ffVid(:,:,z);
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
        totalAreaVals = cat(1,totalAreaVals,allAreaVals);
        totalMeanVals = cat(1,totalMeanVals,allMeanVals);

    end

end