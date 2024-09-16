function workerTest

    delete(gcp('nocreate'));
    pool = parpool("Threads");
    % fileID = fopen('myfile.txt','w');
    opts = parforOptions(pool);
    n = 12;
    A = 500;
    a = zeros(1,n);
    
    parfor(i = 1:n,opts)
        % fopen('myfile.txt');
        startT = strcat(num2str(i,'%04.f'),string(datetime('now','TimeZone','local','Format','HHmmss')));
        % fprintf('myfile.txt',"%s\n",strcat("iteration ",num2str(i)," started at ",string(datetime('now','TimeZone','local','Format','HH:mm:ss'))));
        a(i) = max(abs(eig(rand(A))));
        % pause(1)
        pause(floor(rand*10))

        arr = magic(1000);
        arr = cat(3,arr,arr,arr);
        arr = imcomplement(arr);
        arr = cat(3,arr,arr,arr);
        arr = imcomplement(arr);
        arr = cat(3,arr,arr,arr);
        arr = imcomplement(arr);
        arr = cat(3,arr,arr,arr);
        pause(floor(rand*10))
        % writematrix(strcat(num2str(-i,'%04.f'),string(datetime('now','TimeZone','local','Format','HHmmss'))),"timeOutput.txt",'WriteMode','append')
        % fprintf('myfile.txt',"%s\n",strcat("iteration ",num2str(i)," finished at ",string(datetime('now','TimeZone','local','Format','HH:mm:ss'))));
        % pause(1)
        writematrix(strcat(startT," ",num2str(i,'%04.f'),string(datetime('now','TimeZone','local','Format','HHmmss'))),"timeOutput.txt",'WriteMode','append')

    end
    fclose('all');
    strArr = readmatrix("timeOutput.txt")
    iterations = floor(strArr/1000000);
    startEndTimes = strArr - iterations*1000000;
    durations = zeros(n,3);
    for i = 1: length(iterations)
        tempIter = iterations(i)
        tempIdx = iterations == tempIter;
        currentTime = startEndTimes(tempIdx)
        startT = currentTime(1);
        endT = currentTime(2);
        durations(i,:) = [floor(startT/10000),floor((startT-floor(startT/10000)*10000)/100), startT - floor(startT/100)*100]
    end
end