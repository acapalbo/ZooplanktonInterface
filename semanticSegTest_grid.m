clear;clc

netStruct = load("C:\Users\acapalbo\ChamplainContrastAnalysis\diskSegNet_raw.mat");
uniformSize = [240,240,3];

net = netStruct.net;
% net = bisenetv2(uniformSize,2);
% segmentDir = "D:\ChamplainData\UW camera\Champlain 20250805\TimeClusterSorting\102MSDCF(4000_ISO)\12_43_43_profile";
segmentDir = "D:\ChamplainData\UW camera\Champlain 20250805\TimeClusterSorting\102MSDCF(4000_ISO)\12_53_31_profile";

segmentFiles = dir(segmentDir);
%%
% v1 = VideoWriter("semanticSegTest_grid.avi","Uncompressed AVI");
v1 = VideoWriter("semanticSegTest_grid_rawNet_12_53.avi","Motion JPEG AVI");

v1.FrameRate = 15;
open(v1)

for z = 3:length(segmentFiles)
    % for z = 3:15

    % tempImg = raw2rgb(fullfile(segmentDir,segmentFiles(z).name));
    imgRaw = rawread(fullfile(segmentDir,segmentFiles(z).name));
    tempImg = double(imgRaw);
    rData = double(tempImg(1:2:end,1:2:end));
    gData1 = tempImg(1:2:end,2:2:end);
    gData2 =tempImg(2:2:end,1:2:end);
    gData = double((gData1 + gData2)/2);
    bData = double(tempImg(2:2:end,2:2:end));
    rawRgb = cat(3,rData,gData,bData);
    tempImg = uint16(rawRgb);
    diffVal = size(tempImg,2)-size(tempImg,1);
    tempImg = tempImg(:,(ceil(diffVal/2)+1):end-ceil(diffVal/2),:);
    originalImg = tempImg;
    originalSize = size(tempImg);
    adjustVals = [1,0.6,0.4];
    edgeThresh = 0.3;
    contrastVals = [0,0.3,0.6];
    segImgs = {};
    finalFrameX = [];
    finalFrameY = [];
    for i = 1:length(adjustVals)
        for j = 1:length(contrastVals)
            % imgRe = imresize(tempImg,[uniformSize(1),uniformSize(2)]);
            % C = semanticseg(imgRe,net);
            % C1 = labeloverlay(tempImg,imresize(C,[originalSize(1),originalSize(2)]),"Transparency",0.75);

            tempImgAdj = imadjust(tempImg,[0,adjustVals(i)]);
            tempImgAdj = localcontrast(tempImgAdj,edgeThresh,contrastVals(j));
            imgRe = imresize(tempImgAdj,[uniformSize(1),uniformSize(2)]);
            C = semanticseg(imgRe,net);
            C2 = labeloverlay(double(tempImgAdj)./2^14,imresize(C,[originalSize(1),originalSize(2)]),"Transparency",0.5,"Colormap",hsv(2));
            C2 = insertText(C2,[0,0],sprintf("C: %g\nB: %g",contrastVals(j),2-adjustVals(i)),"FontSize",100);
            finalFrameX = cat(2,finalFrameX,C2);
            % error
            % if i == 1 & j == 3
            %     writeVideo(v1,double(imresize(finalFrameX,0.05))./255);
            % end
            %
            % tempImg = imadjust(tempImg,[0,0.3]);
            % imgRe = imresize(tempImg,[uniformSize(1),uniformSize(2)]);
            % C = semanticseg(imgRe,net);
            % C3 = labeloverlay(tempImg,imresize(C,[originalSize(1),originalSize(2)]),"Transparency",0.75);
        end
        finalFrameY = cat(1,finalFrameY,finalFrameX);

        finalFrameX = [];
    end
    outputImg = imresize(finalFrameY,0.25);
    % outputImg = finalFrameY;
    tempImg = imresize(tempImg,[size(outputImg,1),size(outputImg,2)]);
    outputImg = cat(2,outputImg,uint8((double(tempImg)./2^12)*255));
    % writeVideo(v1,double(imresize(finalFrameY,0.5))./255);
    writeVideo(v1,outputImg)
end

close(v1)