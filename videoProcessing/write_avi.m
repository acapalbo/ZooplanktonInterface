% takes filename and grayscaled video (length, width, frame), creates file
function write_avi(frames,filename)
    tStart = tic;
    v = VideoWriter(filename,"Grayscale AVI");
    open(v)
    writeVideo(v, frames)
    close(v)
    tEnd = toc(tStart);
    fprintf("<strong>Write Time: %.3f s\n</strong>",tEnd);
end