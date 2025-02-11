function plotBinsIsotonic(boundaries,a,b,plotTitle)
    figure
    allBins = 0;
    binCounts = 0;
    xVals = 0;
    for z = 0:length(boundaries)
        if z == 0
            targetLabels = b(a < boundaries(z+1));
            binCount = nnz(a < boundaries(z+1));
        elseif z == length(boundaries)
            targetLabels = b(a >= boundaries(z));
            binCount = nnz(a >= boundaries(z));
            xVals = cat(1,xVals,1);
        else
            targetLabels = b(a >= boundaries(z) & a < boundaries(z+1));
            binCount = nnz(a >= boundaries(z) & a < boundaries(z+1));
            xVals = cat(1,xVals,(boundaries(z+1)+boundaries(z))/2);
        end
    
            binFreq = mean(targetLabels);
            
            allBins = cat(1,allBins,binFreq);
            binCounts = cat(1,binCounts,binCount);
    end

    allBins(1) = [];
    binCounts(1) = [];
    allBins(isnan(allBins)) = 0;
    binXvals = xVals;
    xVals(allBins == 0) = [];
    allBins(allBins == 0) = [];
    
    tiledlayout(2,1)
    nexttile
    plot(xVals,allBins,"--diamond","LineWidth",1.5,Color="black",MarkerFaceColor="black");

    hold on
    plot(0:1,0:1,"--","LineWidth",2,"Color",[0.4660 0.6740 0.1880])
    xlim([0,1])
    title(plotTitle)
    nexttile
    bar(binXvals,binCounts)
    title("Sample Size")
    xlim([0,1])
end