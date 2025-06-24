function [allData,patchImgs,contrastImg,qImg] = imgLocalContrastMeasure(imgPath,patchSize)
    tau = 25;
    epsilon = 0.1;
    img = imread(imgPath);
    if size(img,1) ~= size(img,2)
        img = imresize(img,[max(size(img,1),size(img,2)),max(size(img,1),size(img,2))]);
    end
    img = double(img)/256;
    n = size(img,1);
    remainder = mod(n,patchSize);
    if remainder ~= 0
        img = img(1:end-remainder,1:end-remainder);
        n = size(img,1);
    end
    
    iterSteps = n/patchSize;
    % Start of patch calc
    allData = {};
    patchImgs = {};
    contrastImg = zeros(n,n);
    qImg = zeros(n,n);
    for i = 1:iterSteps
        for j = 1:iterSteps
            tempPatch = img((patchSize*(i-1))+1:(patchSize*(i)),(patchSize*(j-1))+1:(patchSize*(j)));
            [tempGmag,~] = imgradient(tempPatch);
            % normGmag = (tempGmag(:) - mean(tempGmag(:)))/(mean(tempGmag(:))-min(tempGmag(:)));
            % [histVals,edgeVals] = histcounts(normGmag(:),20);
            [histVals,edgeVals] = histcounts(tempGmag(:),20);
            binVals = 0.5 * (edgeVals(2:end)+edgeVals(1:end-1));
            localC = (max(tempPatch(:)-min(tempPatch(:))))/(max(tempPatch(:)+min(tempPatch(:))));
            x = cat(1,-flip(binVals(2:end))',binVals');
            y = cat(1,flip(histVals(2:end))',histVals');
            % if histVals(1) < histVals(2)
            % 
            % else
            %     x = cat(1,-flip(binVals)',binVals');
            %     y = cat(1,flip(histVals)',histVals');
            % end
            try
                % f = fit(x,y,"gauss2","StartPoint",[max(histVals(:)),mean(binVals),range(binVals),max(histVals(:)),mean(binVals),range(binVals)]);
                f = fit(x,y,"gauss2");
                % plot(f,x,y)
                % pause(0.5)
                % close all
            catch ME
                figure
                plot(x,y)
                figure
                imshow(imresize(tempPatch,4))
                rethrow(ME)
            end
            sigmaVal = max(f.c1/2,f.c2/2);
            q2 = (sigmaVal*tau)/(localC+epsilon^2);
            % plot(histVals)
            % histogram(normGmag)
            % figure
            % imshow(imresize(tempPatch,4))
            % pause
            % close all
            allData = cat(1,allData,cat(2,{[histVals',binVals']},{localC},{q2}));
            patchImgs = cat(1,patchImgs,{tempPatch});
            contrastImg((patchSize*(i-1))+1:(patchSize*(i)),(patchSize*(j-1))+1:(patchSize*(j))) = localC;
            qImg((patchSize*(i-1))+1:(patchSize*(i)),(patchSize*(j-1))+1:(patchSize*(j))) = q2;
        end
    end
end