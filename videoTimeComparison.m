% video read time test script
filename = "C:\Users\acapalbo\Desktop\RawGOM\MyCamera-061-2024-03-03 11-48-16.975.avi";
tstart = tic;
    v = VideoReader(filename);
    frames1 = read(v, [1, Inf]);
    if size(size(frames1),2) == 4
        if size(frames1,3) == 3
            frames1 = frames1(:,:,1,:);
        end
        frames1 = reshape(frames1,size(frames1,1),size(frames1,2),size(frames1,4));
    end
    % frames1 = reshape(frames1,[l,w,frameNum]);
    clear v
tEnd = toc(tstart);
fprintf("<strong>Elapsed Time %f s</strong>\n",tEnd)

filename = "C:\Users\acapalbo\Desktop\precise_ff_MyCamera-061-2024-03-03 11-48-16.975.avi";
tstart = tic;
    v = VideoReader(filename);
    frames2 = read(v, [1, Inf]);
    if size(size(frames2),2) == 4
        if size(frames2,3) == 3
            frames2 = frames2(:,:,1,:);
        end
        frames2 = reshape(frames2,size(frames2,1),size(frames2,2),size(frames2,4));
    end
    % frames = reshape(frames,[l,w,frameNum]);
    clear v
tEnd = toc(tstart);
fprintf("<strong>Elapsed Time %f s</strong>\n",tEnd)

filename = "C:\Users\acapalbo\ZooplanktonInterface\layered.avi";
tstart = tic;
    v = VideoReader(filename);
    frames3 = read(v, [1, Inf]);
    clear v
tEnd = toc(tstart);
fprintf("<strong>Elapsed Time %f s</strong>\n",tEnd)