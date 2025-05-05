clear
files = ["E:\basler-videos\MyCamera\2025-03-25 17-03-45.808\MyCamera-006-2025-03-25 17-08-33.181.avi",...
"E:\basler-videos\MyCamera\2025-03-25 17-03-45.808\MyCamera-007-2025-03-25 17-09-03.548.avi",...
"E:\basler-videos\MyCamera\2025-03-25 17-03-45.808\MyCamera-008-2025-03-25 17-09-33.806.avi"];
% filePath = uigetdir();

for z = 1:length(files)
    tempVid = read_avi(fullfile(files(z)));
    frames = size(tempVid,3);
    if exist("frameCounts")
        frameCounts = cat(1,frameCounts,frames);
    else
        frameCounts = frames;
    end
end

fprintf("Total Frames: %g\n",sum(frameCounts));