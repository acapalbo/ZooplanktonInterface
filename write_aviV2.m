% takes filename and grayscaled video (length, width, frame), creates file
function write_aviV2(frames,filename)
    v = VideoWriter(filename);
    open(v)
    writeVideo(v, frames)
    close(v)
end