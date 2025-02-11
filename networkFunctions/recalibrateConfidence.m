function newConfScores = recalibrateConfidence(oldConf,calibrationScores,boundaryPoints)
    for k = 1:length(oldConf)
        for z = 1:length(boundaryPoints)
            if z == 1
                if oldConf(k) < boundaryPoints(z)
                    oldConf(k) = calibrationScores(z);
                end
            elseif z == length(boundaryPoints)
                if oldConf(k) >= boundaryPoints(z) 
                    oldConf(k) = calibrationScores(z);
                end
            else
                if oldConf(k) >= boundaryPoints(z) && oldConf(k) < boundaryPoints(z + 1)
                    oldConf(k) = calibrationScores(z);
                end
            end 
        end
    end
    newConfScores = oldConf;
end