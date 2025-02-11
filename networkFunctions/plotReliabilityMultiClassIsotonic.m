function [confidenceBoundaries,theta] = plotReliabilityMultiClassIsotonic(trainedNet,imds,stepSize)
    [l,w] = size(imds.preview);
    [imdsTest1,imdsTest2] = splitEachLabel(imds,0.50,0.50,"randomized");

    % setup = 1;
    %One Over StepSize; must be even multiple
    correctLabelstest1 = uint16(imdsTest1.Labels);
    correctLabelstest2 = uint16(imdsTest2.Labels);

    scores = minibatchpredict(trainedNet,imdsTest1);
    scores2 = minibatchpredict(trainedNet,imdsTest2);
    classNames = 1:size(scores,2);

    for i = 1:size(scores,2)
        fprintf("<strong>Class %d:\n</strong>",i)
        tempScores1 = scores(:,i);
        tempCorrect1 = correctLabelstest1 == i;
        tempScores2 = scores2(:,i);
        tempCorrect2 = correctLabelstest2 == i;
        tempOthers = sum(scores(:,classNames ~= i));
        tempOthers2 = sum(scores2(:,classNames ~= i));
        
        predLabels = tempScores1 >= 0.5;
        fprintf("PreCalibration Accuracy Sample Set 1: %.2f\n",mean(tempCorrect1 == predLabels));
        predLabels = tempScores2 >= 0.5;
        fprintf("PreCalibration Accuracy Sample Set 2: %.2f\n",mean(tempCorrect2 == predLabels));
        [posFrequency,confXvalues]= convertScores(stepSize,tempScores1,tempCorrect1);
    
    
        confXvalues(posFrequency == 0) = [];
        posFrequency(posFrequency == 0) = [];
    
        [~,boundaries] = isotonicReg(posFrequency,1:length(posFrequency));
    
        [calibratedConf, theta] = histogramBin(tempCorrect1,tempScores1,tempScores2,confXvalues(boundaries));
        confidenceBoundaries = confXvalues(boundaries);
        predLabels = calibratedConf > 0.5;
        % predLabels = predLabels - 1;
        fprintf("Final Accuracy: %.2f\n",mean(tempCorrect2 ==predLabels));
        plotBinsStatic(stepSize,tempScores1,tempCorrect1,"Noncalibrated Reliability")
        plotBinsIsotonic(confXvalues(boundaries),calibratedConf,tempCorrect2,"Calibrated Reliability")
        if exist("totalConf")
            totalConf = cat(2,totalConf,calibratedConf);
        else
            totalConf = calibratedConf;
        end
    end
    [~,newLabels] = max(totalConf,[],2);
    fprintf("<strong>Final Accuracy: %.2f\n</strong>",mean(newLabels == correctLabelstest2))
end


function [calibratedPreds,theta] = histogramBin(correctLabels,calibrationScores,testingScores,boundaries)
theta = zeros(length(boundaries)+1,1);
p = calibrationScores;
for z = 0:length(boundaries)
    if z == 0
        indicatorFunc = p < boundaries(z+1);
    elseif z == length(boundaries)
        indicatorFunc = p >= boundaries(z);
    else
        indicatorFunc = p >= boundaries(z) & p < boundaries(z+1);
    end
    sampleCount = nnz(indicatorFunc);
    theta(z+1) = double(nnz((double(correctLabels).*indicatorFunc)))/double(sampleCount); 
end

% printing here
p = testingScores;

for z = 0:length(theta)-1
    if z == 0
        testingScores(p < boundaries(z+1)) = theta(z+1);
    elseif z == length(theta)-1
        testingScores(p >= boundaries(z)) = theta(z+1);
    else
        testingScores(p >= boundaries(z) & p < boundaries(z+1)) = theta(z+1);
    end
end
calibratedPreds = testingScores;
end

% function plotBinsStatic(stepSize,a,b,plotTitle)
%     figure
%     OOstep = 1/stepSize;
%     halfStep = OOstep/2;
%     allBins = 0;
%     binCounts = 0;
%     for i = 0:OOstep:1-OOstep
%         if i ~= 1-OOstep
%         targetLabels = b(a >= i & a < i + OOstep);
%         binCount = nnz((a >= i & a < i + OOstep));
%         else
%         targetLabels = b(a >= i & a <= i + OOstep);
%         binCount = nnz((a >= i & a <= i + OOstep));
%         end
%         binFreq = mean(targetLabels);
% 
%         allBins = cat(1,allBins,binFreq);
%         binCounts = cat(1,binCounts,binCount);
%     end
%     allBins(1) = [];
%     binCounts(1) = [];
%     allBins(isnan(allBins)) = 0;
%     xVals = halfStep:OOstep:1-halfStep;
%     xVals(allBins == 0) = [];
%     allBins(allBins == 0) = [];
%     tiledlayout(2,1)
%     nexttile
%     plot(xVals,allBins,"--diamond","LineWidth",1.5,Color="black",MarkerFaceColor="black");
% 
%     hold on
%     plot(halfStep:OOstep:1-halfStep,halfStep:OOstep:1-halfStep,"--","LineWidth",2,"Color",[0.4660 0.6740 0.1880])
%     xlim([0,1])
%     title(plotTitle)
%     nexttile
%     bar(halfStep:OOstep:1-halfStep,binCounts)
%     title("Sample Size")
%     xlim([0,1])
% end
% 
% function plotBinsIsotonicLoca(boundaries,a,b,plotTitle)
%     figure
%     allBins = 0;
%     binCounts = 0;
%     xVals = 0;
%     for z = 0:length(boundaries)
%         if z == 0
%             targetLabels = b(a < boundaries(z+1));
%             binCount = nnz(a < boundaries(z+1));
%         elseif z == length(boundaries)
%             targetLabels = b(a >= boundaries(z));
%             binCount = nnz(a >= boundaries(z));
%             xVals = cat(1,xVals,1);
%         else
%             targetLabels = b(a >= boundaries(z) & a < boundaries(z+1));
%             binCount = nnz(a >= boundaries(z) & a < boundaries(z+1));
%             xVals = cat(1,xVals,(boundaries(z+1)+boundaries(z))/2);
%         end
% 
%             binFreq = mean(targetLabels);
% 
%             allBins = cat(1,allBins,binFreq);
%             binCounts = cat(1,binCounts,binCount);
%     end
% 
%     allBins(1) = [];
%     binCounts(1) = [];
%     allBins(isnan(allBins)) = 0;
%     binXvals = xVals;
%     xVals(allBins == 0) = [];
%     allBins(allBins == 0) = [];
% 
%     tiledlayout(2,1)
%     nexttile
%     plot(xVals,allBins,"--diamond","LineWidth",1.5,Color="black",MarkerFaceColor="black");
% 
%     hold on
%     plot(0:1,0:1,"--","LineWidth",2,"Color",[0.4660 0.6740 0.1880])
%     xlim([0,1])
%     title(plotTitle)
%     nexttile
%     bar(binXvals,binCounts)
%     title("Sample Size")
%     xlim([0,1])
% end