% takes filename and grayscaled video (length, width, frame), creates file
function write_avi_rgb(frames,filename)
    tStart = tic;
    v = VideoWriter(filename);
    open(v)
    writeVideo(v, frames)
    close(v)
    tEnd = toc(tStart);
    fprintf("<strong>Write Time: %.3f s\n</strong>",tEnd);
end