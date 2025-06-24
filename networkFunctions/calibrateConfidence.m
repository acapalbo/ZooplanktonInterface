function calibratedPreds = calibrateConfidence(boundaries,theta,rawScores)

% printing here
    calibratedPreds = rawScores;
    
    for z = 0:length(theta)-1
        if z == 0
            calibratedPreds(rawScores < boundaries(z+1)) = theta(z+1);
        elseif z == length(theta)-1
            calibratedPreds(rawScores >= boundaries(z)) = theta(z+1);
        else
            calibratedPreds(rawScores >= boundaries(z) & rawScores < boundaries(z+1)) = theta(z+1);
        end
    end
end