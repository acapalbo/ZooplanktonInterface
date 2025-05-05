function [maxDistance,maxEndPoints,maxCoords] = perimeterDist(BW)
    idx = find(BW == 1);
    maxDistance = 0;
    maxEndPoints = [1,1;1,1];
    [l,w] = size(BW);
    tempBW = imfill(BW,"holes");
    tempBackground = ~tempBW;
    % figure()
    % imshow(BW)
    % figure()
    % imshow(logical(tempBW))
    % figure()
    % imshow(logical(tempBackground))
    % pause
    % close all
    for z = 1:nnz(BW)
        [tempPointRow,tempPointCol] = ind2sub([l,w],idx(z));
        for k = z+1:nnz(BW)
            [tempEndPointRow,tempEndPointCol] = ind2sub([l,w],idx(k));
            if tempPointCol == tempEndPointCol
                continue
            end
            tempCoords = bresenham(cat(1,[tempPointRow,tempPointCol],[tempEndPointRow,tempEndPointCol]));
            tempIdx = sub2ind(size(BW),tempCoords(:,2),tempCoords(:,1));
            tempIdx(1) = [];
            tempIdx(end) = [];


            % tempZeros = zeros(size(BW));
            % tempZeros = BW;
            % tempZeros(tempIdx) = 1;
            % imshow(tempZeros)
            % pause
            % close all
            if maxDistance < pdist(cat(1,[tempPointRow,tempPointCol],[tempEndPointRow,tempEndPointCol])) & ~any(BW(tempIdx)) & ~any(tempBackground(tempIdx)) 
                maxDistance = pdist(cat(1,[tempPointRow,tempPointCol],[tempEndPointRow,tempEndPointCol]));
                maxEndPoints = cat(1,[tempPointRow,tempPointCol],[tempEndPointRow,tempEndPointCol]);
                maxCoords = tempIdx;
            end
        end
    end
end