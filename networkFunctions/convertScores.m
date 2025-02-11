function [posFrequency,xVals] = convertScores(stepSize,a,b)
    OOstep = 1/stepSize;
    halfStep = OOstep/2;
    allBins = 0;
    binCounts = 0;

    for i = 0:OOstep:1-OOstep
        if i ~= 1-OOstep
        targetLabels = b(a >= i & a < i + OOstep);
        else
        targetLabels = b(a >= i & a <= i + OOstep);
        end
        binFreq = mean(targetLabels);
        binCount = nnz((a >= i & a < i + OOstep));
        allBins = cat(1,allBins,binFreq);
        binCounts = cat(1,binCounts,binCount);
    end
    allBins(1) = [];
    binCounts(1) = [];
    posFrequency = allBins;
    xVals = halfStep:OOstep:1-halfStep;
    posFrequency(isnan(posFrequency)) = 0;
end