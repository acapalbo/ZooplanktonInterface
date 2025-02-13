% segments objects from given video frame from series of video frames;
% takes list of videos in form of cell matrix, folder of FF videos, 
% binary threshold, binariztion method, and h_vars

% hyperparameters(h_vars) key:
% max_frequency = h_vars(1)
% min_area = h_vars(2)
% expansion distance = h_vars(3)
% bounding padding = h_vars(5)
% pm_frames = h_vars(6)

function dataSetFilePath = segment_objects_parallel(vid,BW,h_vars,videoPath,saveTrashImages,minLength,minWidth,outputDir,parallelPool)
    warning('off','MATLAB:MKDIR:DirectoryExists');

    % tPrep = tic;
    % BW = process_binary_video(vid,thresh,method,h_vars);

    BWconst = parallel.pool.Constant(BW);
    vidConst = parallel.pool.Constant(vid);

    % tEndPrep = toc(tPrep);
    % fprintf("<strong>Video Prep: %f s<\strong>\n",tEndPrep)

    tStart = tic;
    
    frame_num = size(vid,3);
    vidFileName = strsplit(videoPath,"\");
    % mkdir(strcat("ZooPlanktonOutput_",string(datetime("today","Format","MM_dd_yy"))));
    vidFileName = char(vidFileName(end));
    vidFileName = string(vidFileName(1:end-4));
    mkdir(strcat(outputDir,"\TableInfo_",vidFileName));
    mkdir(strcat(outputDir,"\NonRelevantObjects_",vidFileName));
    mkdir(strcat(outputDir,"\DataSet_",vidFileName));
    opts = parforOptions(parallelPool);
    
    parfor(k = 1:frame_num,opts)
        startT = strcat(num2str(k,'%04.f'),string(datetime('now','TimeZone','local','Format','HHmmss')));
        % fprintf("Beginning frame <strong>%d<\strong> out of <strong>%d<\strong>\n",k,frame_num)
        raw_frame = vidConst.Value(:,:,k);
        FBframes = [h_vars(5) h_vars(5)];

        if k - FBframes(1) < 1
            FBframes(1) = k - 1;
            FBframes(2) = 2*h_vars(5) - FBframes(1);
        end
        if k + FBframes(2) > frame_num
            FBframes(2) = frame_num - k;
            FBframes(1) = 2*h_vars(5) - FBframes(2);
        end

        tempBW = BWconst.Value(:,:,k - FBframes(1):k+FBframes(2));
        final_bboxes = segment_objects_core(tempBW,1 + FBframes(1),raw_frame,h_vars);
        final_bboxes(all(final_bboxes == 0,2),:) = [];
        objectArray = segmented_object_cleanup(final_bboxes,raw_frame);
        if size(objectArray,3) > 1
        % fprintf("%d objects saved to 'Valid'\n", size(objectArray,3));
        
        [identifiers,relVsNonRel] = saveImagesLineage(objectArray,k,final_bboxes,videoPath,saveTrashImages, minLength,minWidth,outputDir);

        infoTable = table(repmat(videoPath,size(final_bboxes,1),1),final_bboxes(:,1),final_bboxes(:,2),final_bboxes(:,3),final_bboxes(:,4),(1:size(final_bboxes,1))',identifiers,repmat(-1,size(final_bboxes,1),1),relVsNonRel);
        infoTable.Properties.VariableNames = {'VideoPath','BoundingX','BoundingY','BoundingWidth','BoundingHeight','Object#','FileName','ClassName','RelevantVSNonRelevant'};
        writetable(infoTable,strcat(outputDir,"\TableInfo_",vidFileName,"\Frame_",num2str(k),".csv"));
        writematrix(strcat(startT," ",num2str(k,'%04.f'),string(datetime('now','TimeZone','local','Format','HHmmss'))),fullfile(outputDir,"timeOutput.txt"),'WriteMode','append')
        end
    end
    tEnd = toc(tStart);
    fprintf("<strong>Total Segmentation Time: %f s</strong>\n",tEnd)
    dataSetFilePath = strcat(outputDir,"\DataSet_",vidFileName);
    % begin sorting
end