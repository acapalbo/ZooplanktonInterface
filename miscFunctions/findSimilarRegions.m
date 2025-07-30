function distances = findSimilarRegions(vid)
    tempFrame = vid(:,:,1);
    tempBW = tempFrame < graythresh(tempFrame)*255;
    tempBW = imdilate(tempBW,strel("disk",5));
    tempBW = bwareaopen(tempBW,600,8);
    tempBW = imclearborder(tempBW);    
    prevProps = regionprops(tempBW,"Centroid","Area");
    prevBW = tempBW;
    distances = [];
    for z = 2:size(vid,3)
        tempFrame = vid(:,:,z);
        tempBW = tempFrame < graythresh(tempFrame)*255;
        tempBW = imdilate(tempBW,strel("disk",5));
        tempBW = bwareaopen(tempBW,600,8);
        tempBW = imclearborder(tempBW);    

        props = regionprops(tempBW,"Centroid","Area");
        for j = 1:length(props)
            for i = 1:length(prevProps)

                if prevProps(i).Centroid(1) - props(j).Centroid(1) > 500 & ...
                        abs(prevProps(i).Centroid(2) - props(j).Centroid(2)) < 200 & ...
                        abs(prevProps(i).Area-props(j).Area)/props(j).Area < 0.1
                    imshowpair(prevBW,tempBW)
                    hold on
                    plot(prevProps(i).Centroid(1),prevProps(i).Centroid(2),'*r')
                    plot(props(j).Centroid(1),props(j).Centroid(2),'*r')
                    plot([props(j).Centroid(1),prevProps(i).Centroid(1)],[props(j).Centroid(2),prevProps(i).Centroid(2)])
                    pause
                    close all
                    distances = cat(1,distances,prevProps(i).Centroid(1) - props(j).Centroid(1));
                end
            end
        end
        prevProps = props;
        prevBW = tempBW;
    end
end