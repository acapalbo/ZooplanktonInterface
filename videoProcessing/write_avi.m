% takes filename and grayscaled video (length, width, frame), creates file
function write_avi(frames,filename)
    v = VideoWriter(filename,"Grayscale AVI");
    open(v)
    writeVideo(v, frames)
    close(v)
end