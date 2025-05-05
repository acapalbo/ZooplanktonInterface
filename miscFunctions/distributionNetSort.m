%% Read in data (PCA variant)

[~,~,gradientData,imgs] = fitImageGradientHists("C:\Users\acapalbo\ZooPlanktonOutputs_Cdrive\ZooPlanktonBatchOutput_033125(1)\SegmentationOutput\SegmentationOutput_MyCamera-079-2024-08-28 22-28-09.173precise_ff\DataSet_MyCamera-079-2024-08-28 22-28-09.173precise_ff");
[coeff,score,latent,tsquared,explained] = pca(cell2mat(gradientData));
pcaData = score(:,1:5);
preds = predict(netPCA,pcaData);

[val,idx] = max(preds,[],2);

mean(idx == 2)
%% Read in data (standard)

[pixelData,imgs] = fitImageHists("C:\Users\acapalbo\ZooPlanktonOutputs_Cdrive\ZooPlanktonBatchOutput_033125(1)\SegmentationOutput\SegmentationOutput_MyCamera-079-2024-08-28 22-28-09.173precise_ff\DataSet_MyCamera-079-2024-08-28 22-28-09.173precise_ff",128);
% newData = cell2mat(pixelData);
dlData = dlarray(reshape(cell2mat(pixelData),1,1,128,[]),"SSCB");

% preds = predict(net,newData);
preds = predict(net_2,dlData);
[val,dlIdx] = max(preds,[],1);
idx = extractdata(dlIdx);
mean(idx == 2)
%% Write predictions
mkdir PredictedValues
mkdir PredictedValues\1
mkdir PredictedValues\2
for z = 1:length(idx)
    tempimg = cell2mat(imgs(z));
    if idx(z) == 1
        imwrite(tempimg,strcat("PredictedValues/1/",string(z),".png"))
    else
        imwrite(tempimg,strcat("PredictedValues/2/",string(z),".png"))
    end
end