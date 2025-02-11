function [theta,calibratedPreds] = generateThetaIsotonic(correctLabels,calibrationScores,testingScores,boundaries)
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