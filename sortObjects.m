function sortObjects(statFilePath)

    % c = cophenet(Z,y);
    % I = inconsistent(Z);
    startingFolder = pwd;
    mkdir ClusterOutput
    cd ClusterOutput
    addpath (startingFolder)

        maxVal = 0;
        csv = readmatrix(statFilePath);
        idx = 1:length(csv);
        idx = idx';
        for j=2:10
            [idx3,C,sumdist3] = kmeans(csv,j,'Distance','cityblock','Display','final','replicates',5);
            [silh3,h] = silhouette(csv,idx3,'cityblock');
            silVal = mean(silh3);
            if silVal > maxVal
                maxVal = silVal;
                clusterCount = j;
            end
            close gcf;
        end
        fprintf("<strong>Final Cluster Count %d</strong>\n",clusterCount)
        %dendrogram(Z)
        %clusterCount = 5;
        [idx3,C,sumdist3] = kmeans(csv,clusterCount,'Distance','cityblock','Display','final','replicates',10);
        csv = cat(2,idx,csv);
        csv = cat(2,idx3,csv);
        for k=1:clusterCount
            clusterFolder = strcat("Cluster",num2str(k));
            mkdir(clusterFolder)
            cd(clusterFolder)

        
            clusteridx = csv((csv(:,1) == k),2);
            for j = 1:length(clusteridx)
                pathName = strcat(startingFolder,"\ObjImgs\obj_",num2str(clusteridx(j)),"_.png");
                copyfile(pathName)
            end
            origDir = strcat(startingFolder,"\ClusterOutput");
            cd(origDir)
        end
end