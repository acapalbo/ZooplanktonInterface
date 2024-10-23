function batchFlatField() 
    addpath assets\
    addpath networkFunctions\
    addpath videoProcessing\
    filePath = uigetdir();
    videoFiles = dir(filePath);
    for z = 1:length(videoFiles)
        fprintf("%d\n",z);
    end
end