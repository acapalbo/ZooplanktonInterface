% Given set of copepods from video:
[file,videoPath] = uigetfile;
if file ~= 0
rawVid = read_avi(fullfile(videoPath,file));

vid = standardFlatfield_v2(rawVid,1);
numFrames = size(vid,3);
fps = 21;

vidTime = numFrames*(1/fps);

flowRate = 18.0; % liters per s

parallelPool = parpool("Threads");

% MaxFrequency,MinArea,ExpansionDistance,CropPadding,FrameDepth
h_vars = [0.2,15,5,5,5];
saveTrashImages = true;
minLength = 100;
minWidth = 100;
BWthresh = 0.6;
classCounts = getClassDists(vid,BWthresh,h_vars,videoPath,saveTrashImages,minLength,minWidth,outputDir,parallelPool);

% Example: classCounts = [500, 100, 50, 50, 300, 200];

liters = flowRate * vidTime;

densities = classCounts./liters;

end