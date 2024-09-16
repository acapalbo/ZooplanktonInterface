function check = movementCheckRegion3(BW,depth_frames,frame_num,regionIdx)
    check = 0;
    originalIdx = regionIdx;
    % [l,w,frames] = size(BW);
    % blankImg = zeros(l,w,"logical");
    % class(regionIdx)
    % blankImg(regionIdx) = 1;
    % pause(1)
    % imshow(blankImg)
    forwardsFrames = depth_frames;
    backwardsFrames = depth_frames;
    if frame_num - backwardsFrames < 1
        backwardsFrames = frame_num - 1;
        forwardsFrames = 2*depth_frames - backwardsFrames;
    elseif frame_num + forwardsFrames > size(BW,3)
        forwardsFrames = size(BW,3) - frame_num;
        backwardsFrames = 2*depth_frames - forwardsFrames;
    end
    props = regionprops3(BW(:,:,frame_num - backwardsFrames:frame_num + forwardsFrames),"VoxelIdxList");
    volumeList = cat(1,props.VoxelIdxList);
    % BigVolumes = {};
    % z = 1;
    % iterCount = length(volumeList);
    blankVolume = zeros(size(BW(:,:,frame_num - backwardsFrames:frame_num + forwardsFrames)),"like",BW);
    % while z < iterCount
    %     % disp("enter")
    %     if nnz(cell2mat(volumeList(z))) > 500
    %         BigVolumes = cat(1,BigVolumes,volumeList(z));
    %         volumeList(z) = [];
    %         z = z - 1;
    %         iterCount = length(volumeList);
    %     end
    %     z = z + 1;
    % end
    relFrameNum = backwardsFrames + 1;
    i = 0;
    for k = 1:backwardsFrames
        for i = 1:length(volumeList)
            % tempRegion = cell2mat(BigVolumes(i));
            if nnz(cell2mat(volumeList(i))) > 500
                blankVolume(:) = 0;
                tempRegion = cell2mat(volumeList(i));
                blankVolume(tempRegion) = 1;
    
                temp2Dregion = blankVolume(:,:,relFrameNum - k);
    
                if any(temp2Dregion(regionIdx))
                    % disp("detected")
                    regionCount = length(regionIdx);
                    overlapCount = nnz(temp2Dregion(regionIdx));
                    if (regionCount/overlapCount) > 0.55
                        check = check + 1;
                        regionIdx = find(temp2Dregion);
                    end
                end
            end
        end
        if check ~= k
            break
        end
    end
    i = 0;
    regionIdx = originalIdx;
    for k = 1:forwardsFrames
        for i = 1:length(volumeList)
            % tempRegion = cell2mat(BigVolumes(i));
            if nnz(cell2mat(volumeList(i))) > 500
                blankVolume(:) = 0;
                tempRegion = cell2mat(volumeList(i));
                blankVolume(tempRegion) = 1;
    
                temp2Dregion = blankVolume(:,:,relFrameNum + k);
    
                if any(temp2Dregion(regionIdx))
                    % disp("detected")
                    regionCount = length(regionIdx);
                    overlapCount = nnz(temp2Dregion(regionIdx));
                    if (regionCount/overlapCount) > 0.55
                        check = check + 1;
                        regionIdx = find(temp2Dregion);
                    end
                end
            end
        end
        if check ~= k
            break
        end
    end
    % clearvars -except check
 
end