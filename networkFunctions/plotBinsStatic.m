function plotBinsStatic(stepSize,a,b,plotTitle)
    figure
    OOstep = 1/stepSize;
    halfStep = OOstep/2;
    allBins = 0;
    binCounts = 0;
    for i = 0:OOstep:1-OOstep
        if i ~= 1-OOstep
        targetLabels = b(a >= i & a < i + OOstep);
        binCount = nnz((a >= i & a < i + OOstep));
        else
        targetLabels = b(a >= i & a <= i + OOstep);
        binCount = nnz((a >= i & a <= i + OOstep));
        end
        binFreq = mean(targetLabels);
        
        allBins = cat(1,allBins,binFreq);
        binCounts = cat(1,binCounts,binCount);
    end
    allBins(1) = [];
    binCounts(1) = [];
    allBins(isnan(allBins)) = 0;
    xVals = halfStep:OOstep:1-halfStep;
    xVals(allBins == 0) = [];
    allBins(allBins == 0) = [];
    tiledlayout(2,1)
    nexttile
    plot(xVals,allBins,"--diamond","LineWidth",1.5,Color="black",MarkerFaceColor="black");

    hold on
    plot(halfStep:OOstep:1-halfStep,halfStep:OOstep:1-halfStep,"--","LineWidth",2,"Color",[0.4660 0.6740 0.1880])
    xlim([0,1])
    title(plotTitle)
    nexttile
    bar(halfStep:OOstep:1-halfStep,binCounts)
    title("Sample Size")
    xlim([0,1])
end
