function stats = object_metrics(img, mask)
    [l,w] = size(img);
    for i = 1:l
        for j = 1:w
            if mask(i,j) ~= 1
                img(i,j) = 0;
            end
        end
    end
    valid = img(img ~= 0);
    if valid ~= 0
        CC = bwconncomp(mask);
        props = regionprops(CC, 'Area', 'Perimeter','Extent','Eccentricity','Extrema');
        allAreas = cat(1,props.Area);
        allPerims = cat(1,props.Perimeter);
        allEccentricity = cat(1,props.Eccentricity);
        extrema = cat(1,props.Extrema);
        if length(allAreas) > 1
            [~,maxIdx] = max([props.Area]);
            allAreas = allAreas(maxIdx);
            allPerims = allPerims(maxIdx);
            allEccentricity = allEccentricity(maxIdx);
            extrema = extrema(maxIdx:maxIdx+7,:);
        end
        points = extrema([1,3,5,7],:);
        crossVal_1 = sqrt((points(1,1)-points(3,1))^2+((points(1,2)-points(3,2)))^2);
        crossVal_2 = sqrt((points(2,1)-points(4,1))^2+((points(2,2)-points(4,2)))^2);
        shapeDist = min([crossVal_2 crossVal_1])/max([crossVal_2 crossVal_1]);
        extent = double(allAreas/(l*w));
        area = double(allAreas);
        intensity = double(sum(valid,"all")/area);
        minI = double(min(valid,[],"all"));
        maxI = double(max(valid,[],"all"));
        circularity = double((allPerims.^2)./(4*pi*allAreas));
        stats = [area, intensity, circularity,extent,minI, maxI,allEccentricity,shapeDist];
    else
        stats = [-1,-1,-1,-1,-1,-1,-1,-1];
    end
end
