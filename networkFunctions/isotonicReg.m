% takes column vector
function [newY,blockStartPoints] = isotonicReg(Y,xVals)
    BlockCells = mat2cell(Y,ones(size(Y,1),1));
    blocks = Y;
    size(blocks)
    size(BlockCells)
    blockStartPoints = xVals;

    while true
        blockMeans = zeros(length(BlockCells),1);
        blockDiffs = zeros(length(BlockCells)-1,1);
        for i=1:length(BlockCells)
            blockMeans(i) = mean(cell2mat(BlockCells(i))); 
        end
        for i=1:length(BlockCells)-1
        blockDiffs(i) = blockMeans(i+1) - blockMeans(i);
        end
        if all(blockDiffs >= 0)
            break;
        end
        % blockDiffs2 = blockDiffs;
        idx = find(blockDiffs < 0);
        % disp(idx)
        % size(idx)
        % pause
        if length(idx) > 1
            idx = idx(1);
        end
        % blockStartPoints(idx)
        % blockStartPoints(idx+1)
        % pause
        idx
        blockStartPoints(idx+1)
        violators = blocks(blockStartPoints(idx):blockStartPoints(idx+1)+length(cell2mat(BlockCells(idx+1)))-1);

        poolLength = length(violators);
        poolmean = mean(violators);
        i = 1:length(BlockCells);
        BlockCells = cat(1,BlockCells(i<idx),{repmat(poolmean,[poolLength,1])},BlockCells(i>idx+1));
        % size(blockStartPoints)
        % size(blockStartPoints(i<idx))
        % size(blockStartPoints(i>idx))
        % size(idx)
        blockStartPoints = cat(1,blockStartPoints(i<idx),blockStartPoints(idx),blockStartPoints(i>idx+1));
        % blockStartPoints(idx)
        % blockStartPoints(idx+1)
        % length(BlockCells(idx+1))
        % disp(size(BlockCells))
        % disp(idx)
        % disp(size(blockStartPoints))
    end
    newY = 0;
    % blockStartPoints
    % error
    for z = 1:length(BlockCells)
        tempArr = cell2mat(BlockCells(z));
        newY = cat(1,newY,tempArr);
    end
    newY(1) = [];
    figure
    plot((0:length(newY)-1)/(length(newY)-1),Y)
    hold on
    plot((0:length(newY)-1)/(length(newY)-1),newY,"--r")
    title("Isotonic Fit")
    xlim([0,1])
end