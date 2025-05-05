% zip classified folders
function zipOutputFolders(outputPath)
    numClasses = 7;
    % outputPath = "C:\Users\acapalbo\ZooPlanktonOutputs_Cdrive\ZooPlanktonBatchOutput_032625(1)";
    outputFiles = dir(outputPath);
    fileNames = struct2table(outputFiles).name;
    classDir = fileNames(contains(fileNames,"Classification"));
    % fullfile(outputPath,classDir)
    classOutputs = dir(fullfile(outputPath,classDir));
    classOutputs = struct2table(classOutputs).name;
    rawImgs = classOutputs(contains(classOutputs,"ClassifiedRaw"));
    numbers = sscanf(string(rawImgs(1)),'ClassifiedRawImages_DataSet_MyCamera-%d-%d-%d-%d %d-%d-%d.%d');
    fileName = sprintf("%02d-%02d-%02d %02d-%02d-%02d.%03d",numbers(2),numbers(3),numbers(4),numbers(5),numbers(6),numbers(7),numbers(8));
    mkdir(fileName);
    f = waitbar(0,"Zip Progress");
    for z = 1:length(rawImgs)
        for k = 1:numClasses
            mkdir(fullfile(outputPath,classDir,rawImgs(z),sprintf("%d_reclassified",k)))
            mkdir(fullfile(outputPath,classDir,rawImgs(z),sprintf("%d_removed",k)))
        end
        waitbar((z-1)/length(rawImgs),f,"Zip Progress")
    
        zip(fullfile(pwd,fileName,string(rawImgs(z))),fullfile(outputPath,classDir,rawImgs(z)))
        waitbar((z)/length(rawImgs),f,"Zip Progress")
    end
    close(f)
end
% zip(fileName,fullfile(outputPath,classDir,rawImgs));