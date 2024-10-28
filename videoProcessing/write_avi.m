% takes filename and grayscaled video (length, width, frame), creates file
function write_avi(frames,filename)
    tStart = tic;
    v = VideoWriter(filename,"Grayscale AVI");
    open(v)
    writeVideo(v, frames)
    close(v)
    tEnd = toc(tic);
    fprintf("<strong>Write Time: %.3f seconds</strong>",tEnd);
end