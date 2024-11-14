function frames = read_avi(filename)
    tStart = tic;
    v = VideoReader(filename);
    frames = read(v, [1, Inf]);
    if size(size(frames),2) == 4
        if size(frames,3) == 3
            frames = frames(:,:,1,:);
        end
        frames = reshape(frames,size(frames,1),size(frames,2),size(frames,4));
    end
    % frames = reshape(frames,[l,w,frameNum]);
    clear v
    tEnd = toc(tStart);
    fprintf("<strong>Read Time: %.3f s</strong>\n",tEnd)
end