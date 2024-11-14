function processed_video = processVideo(original,processSequence)
    processed_video = zeros(size(original),"like",original);
    for z = 1:size(processSequence,1)
        switch cell2mat(processSequence(z,1))
            case "S"
                if cell2mat(processSequence(z,2)) ~= "X"
                    for j = 1:size(original,3)
                        processed_video(:,:,j) = imsharpen(original(:,:,j),"Radius",cell2mat(processSequence(z,2)),"Amount",cell2mat(processSequence(z,3)),"Threshold",cell2mat(processSequence(z,4)));
                    end
                else
                    for j = 1:size(original,3)
                        processed_video(:,:,j) = imsharpen(original(:,:,j));
                    end
                end    
            case "A"
                if cell2mat(processSequence(z,2)) ~= "X"
                    for j = 1:size(original,3)
                        processed_video(:,:,j) = imadjust(original(:,:,j),[cell2mat(processSequence(z,2)),cell2mat(processSequence(z,3))],[cell2mat(processSequence(z,4)),cell2mat(processSequence(z,5))]);
                    end
                else
                    for j = 1:size(original,3)
                        processed_video(:,:,j) = imadjust(original(:,:,j));
                    end
                end
            case "L"
                if cell2mat(processSequence(z,4)) ~= "X"
                for j = 1:size(original,3)
                processed_video(:,:,j) = locallapfilt(original(:,:,j),cell2mat(processSequence(z,2)),cell2mat(processSequence(z,3)),"NumIntensityLevels",cell2mat(processSequence(z,4))); 
                end
                else
                    for j = 1:size(original,3)
                        processSequence(z,:)
                        processed_video(:,:,j) = locallapfilt(original(:,:,j),cell2mat(processSequence(z,2)),cell2mat(processSequence(z,3)));
                    end
                end

            case "B"    
                if cell2mat(processSequence(z,4)) ~= "X"

                    for j = 1:size(original,3)
                        processed_video(:,:,j) = imbilatfilt(original(:,:,j),cell2mat(processSequence(z,2)),cell2mat(processSequence(z,3)));
                    end
                else
                    for j = 1:size(original,3)
                        processed_video(:,:,j) = imbilatfilt(original(:,:,j));
                    end
                end
            case "M" 
                switch string(processSequence(z,2))
                    case "Diamond"
                        morphObj = strel("Diamond",cell2mat(processSequence(z,3)));
                        functionHandle = cell2mat(processSequence(z,5));
                        for j = 1:size(original,3)
                            processed_video(:,:,j) = functionHandle(original(:,:,j),morphObj); 
                        end
                    case "Disk"
                        morphObj = strel("Disk",cell2mat(processSequence(z,3)),cell2mat(processSequence(z,4)));
                        functionHandle = cell2mat(processSequence(z,5));
                        for j = 1:size(original,3)
                            processed_video(:,:,j) = functionHandle(original(:,:,j),morphObj); 
                        end
                    case "Octagon"
                        morphObj = strel("Octagon",cell2mat(processSequence(z,3)));
                        functionHandle = cell2mat(processSequence(z,5));
                        for j = 1:size(original,3)
                            processed_video(j) = functionHandle(original(j),morphObj); 
                        end
                    case "Line"
                        morphObj = strel("Line",cell2mat(processSequence(z,3)),cell2mat(processSequence(z,4)));
                        functionHandle = cell2mat(processSequence(z,5));
                        for j = 1:size(original,3)
                            processed_video(j) = functionHandle(original(j),morphObj); 
                        end
                    case "Rectangle"  
                        morphObj = strel("Rectangle",cell2mat(processSequence(z,3)),cell2mat(processSequence(z,4)));
                        functionHandle = cell2mat(processSequence(z,5));
                        for j = 1:size(original,3)
                            processed_video(j) = functionHandle(original(j),morphObj); 
                        end
               end    
                    
        end    
    end    

end