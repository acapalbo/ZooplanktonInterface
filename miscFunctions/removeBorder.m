function arr = removeBorder(original,distancey,distancex)
    arr = original;
    [l,w] = size(arr);
    arr (1:distancey,:) = 0;
    arr (end - distancey:end,:) = 0;
    arr (:,1:distancex) = 0;
    arr (:,end - distancex:end) = 0;
end