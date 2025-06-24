function [data,fitSlope] = fftPowerSpectrum(img,vis)
    if max(img(:)) > 1
        img = double(img)/256;
    end
    if size(img,1) ~= size(img,2)
        img = imresize(img,[max(size(img,1),size(img,2)),max(size(img,1),size(img,2))]);
    end
    imgFFT = fftn(img);
    amplitudes = abs(imgFFT).^2;
    n = size(img,1);
    if mod(n,2) == 0
        kfreq = 0:(n/2)-1;
        kfreq = cat(2,kfreq,-n/2,flip(-kfreq(2:end)));
    else
        kfreq = 0:(n-1)/2;
        kfreq = cat(2,kfreq,flip(-kfreq(1:end-1)));
    end
    
    [freqMeshx,freqMeshY] = meshgrid(kfreq,kfreq);
    knrm = sqrt(freqMeshY.^2 + freqMeshx.^2);

    kbins = 0.5:(n+1)/2;
    kvals = 0.5 * (kbins(2:end)+kbins(1:end-1));
    
    results = py.scipy.stats.binned_statistic(knrm(:),amplitudes(:),statistic="mean",bins=kbins);
    powerSpectra = double(results.statistic).*pi.*((kbins(2:end)).^2 - kbins(1:end-1).^2);
    x = log10(kvals');
    y = log10(powerSpectra');
    X = [ones(length(x),1) x];
    b = X\y;
    data = [kvals',powerSpectra'];
    fitSlope = -b(2);
    yCalc2 = X*(b);
    if vis
        figure;
        scatter(log10(kvals),log10(powerSpectra))
        hold on
        plot(x,yCalc2,"--r")
        text(x(ceil(0.2*length(x))),yCalc2(1),sprintf("Fitted Slope: %0.2f",-b(2)));
        hold off
    end
end
