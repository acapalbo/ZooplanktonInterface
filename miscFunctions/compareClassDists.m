%% Make Dists
numBins = 100;
[crustHistMag,crustHistDir,datasetForm,imageFiles] = fitImageGradientHists("D:\Datasets\CombinedDataset_v5.0\Crustaceans",numBins);
close all
[detAHistMag,detAHistDir,datasetForm,imageFiles]= fitImageGradientHists("D:\Datasets\CombinedDataset_v5.0\DetritusA",numBins);
close all
[detBHistMag,detBHistDir,datasetForm,imageFiles]= fitImageGradientHists("D:\Datasets\CombinedDataset_v5.0\DetritusB",numBins);
close all
[chatHistMag,chatHistDir,datasetForm,imageFiles]= fitImageGradientHists("D:\Datasets\CombinedDataset_v5.0\Chaetognaths",numBins);
close all
[bubHistMag,bubHistDir,datasetForm,imageFiles]= fitImageGradientHists("D:\Datasets\CombinedDataset_v5.0\Bubbles",numBins);
close all
[gelHistMag,gelHistDir,datasetForm,imageFiles]= fitImageGradientHists("D:\Datasets\CombinedDataset_v5.0\Gelatinous",numBins);
close all
[larvHistMag,larvHistDir,datasetForm,imageFiles]= fitImageGradientHists("D:\Datasets\CombinedDataset_v5.0\Larvaceans",numBins);
close all
imageHists = table({bubHistDir},{chatHistDir},{crustHistDir},{detAHistDir},{detBHistDir},{gelHistDir},{larvHistDir});
imageHists2 = table({bubHistMag},{chatHistMag},{crustHistMag},{detAHistMag},{detBHistMag},{gelHistMag},{larvHistMag});
%% Plot dir
figure();
hold on
for z = 1:width(imageHists)
    tempClass = table2cell(imageHists(:,z));
    tempClass = tempClass{1};
    plot(max(cell2mat(tempClass)));
end
legend(["Bubble Max", "Chaetognath Max","Crustacean Max","DetA Max", ...
    "DetB Max","Gel Max","Larv Max"])

figure()
hold on
for z = 1:width(imageHists)
    tempClass = table2cell(imageHists(:,z));
    tempClass = tempClass{1};  
    plot(linspace(-180,180,length(mean(cell2mat(tempClass)))),mean(cell2mat(tempClass)));
end
legend(["Bubble Mean","Chaetognath Mean","Crustacean Mean","DetA Mean", ...
    "DetB Mean","Gel Mean","Larv Mean"])
figure();
hold on
%% Plot Mag
for z = 1:width(imageHists2)
    tempClass = table2cell(imageHists2(:,z));
    tempClass = tempClass{1};
    plot(max(cell2mat(tempClass)));
end
legend(["Bubble Max", "Chaetognath Max","Crustacean Max","DetA Max", ...
    "DetB Max","Gel Max","Larv Max"])

figure()
hold on
for z = 1:width(imageHists2)
    tempClass = table2cell(imageHists2(:,z));
    tempClass = tempClass{1};  
    plot(linspace(-180,180,length(mean(cell2mat(tempClass)))),mean(cell2mat(tempClass)));
end
legend(["Bubble Mean","Chaetognath Mean","Crustacean Mean","DetA Mean", ...
    "DetB Mean","Gel Mean","Larv Mean"])
