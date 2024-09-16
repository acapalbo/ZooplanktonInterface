% reads an RGB .avi file and saves preprocessed version
function final = preprocess_video(vid, calibration, brightness, flatfielding_method)
    % uses specified flatfielding function
    if (flatfielding_method == "precise")
        % takes ~60 min. total for a 30-second video
        final = precise_flatfield(vid, calibration, brightness);
    elseif (flatfielding_method == "dynamic")
        % takes ~12 min. total for a 30-second video
        final = dynamic_flatfield(vid, calibration, brightness);
    else
        % takes ~8 min. total for a 30-second video
        final = flatfield(vid, calibration, brightness);
    end
end