% inputs video (3-D uint8 array), outputs calibration frame (2-D array)
function calibration_frame = calibrateV2(original)
    tStart = tic;

    % initialize variables
    [~,~,num_frames] = size(original);

    % sort 3-D array in ascending order w/ respect to time
    sorted_video = sort(original,3,'ascend');
    % return frame w/ avg. of top 80% of values
    calibration_frame = mean(sorted_video(:,:, uint16(0.2*num_frames):end),3);
    tEnd = toc(tStart);
    fprintf("<strong>Elapsed Time %f s</strong>\n",tEnd)
end