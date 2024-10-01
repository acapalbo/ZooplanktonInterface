function arr = classAccPreRec(correctLabels,predictedLabels)
    classCount = unique(correctLabels);
    arr = 0;
    for i = 1:length(classCount)
        tP = nnz(correctLabels(correctLabels == classCount(i)) == predictedLabels(correctLabels == classCount(i)));
        % correctLabels ~= classCount(i)
        % correctLabels(correctLabels ~= classCount(i)) == classCount(i)
        fP = nnz(predictedLabels(correctLabels ~= classCount(i)) == classCount(i));
        fN = nnz(correctLabels(correctLabels == classCount(i)) ~= predictedLabels(correctLabels == classCount(i)));
        Rec = tP/(fN + tP);
        Prec = tP/(fP + tP);
        arr = cat(2,arr,[Rec,Prec]); 
    end
    Acc = mean(correctLabels == predictedLabels);
    arr(1) = Acc;
end