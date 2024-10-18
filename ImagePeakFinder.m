function labeledImg = ImagePeakFinder(img)
    [l,w] = size(img);
    labeledImg = cat(3,img,img,img);
    uncert = 0.15;
    for i = 1:l
        findpeaks(img(i,:))
        % [p,locs,peakWidth,~] = findpeaks(img(i,:))

        [p,locs,peakWidth,~] = findpeaks(img(i,:))
        pause
        maxLoc = locs(p == max(p));
        for k = 1:size(p,2)
            for z = 1:size(p,2)
                if abs(p(k)-p(z)) < uncert & (p(k) > 0.6 & p(z) > 0.6) & k ~= z
                    peakWidth = abs(locs(k)-locs(z))
                    labeledImg(i,locs(k),:) = [1 0 0];
                    labeledImg(i,locs(z),:) = [1 0 0];
                end
            end
        end
        % for j = 1:size(locs,2)
        %     labeledImg(i,locs(j),:) = [1 0 0];
        % end

    end
    for i = 1:w
        [p,locs] = findpeaks(img(:,i));
        maxLoc = locs(p == max(p));
        for k = 1:size(p,2)
            for z = 1:size(p,2)
                if abs(p(k)-p(z)) < uncert & k ~= z
                    peakWidth = abs(locs(k)-locs(z))
                    labeledImg(locs(k),i,:) = [1 0 0];
                    labeledImg(locs(z),i,:) = [1 0 0];

                end
            end
        end
        % for j = 1:size(locs,2)
        %     labeledImg(locs(j),i,:) = [1 0 0];
        % end
        % for j = 1:size(maxLoc,2)
        % labeledImg(maxLoc(j),i,:) = [1 0 0];
        % end
    end
end