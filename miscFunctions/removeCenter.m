function arr = removeCenter(varargin)
    original = cell2mat(varargin(1));
    arr = original;
    [l,w] = size(arr);
    centerx = ceil(w/2);
    centery = ceil(l/2);
    if string(varargin(2)) == "r"
        distancex = cell2mat(varargin(3));
        distancey = cell2mat(varargin(4));

        arr (centerx-distancex:centerx+distancex,centery-distancey:centery+distancey) = 0;
        % arr (:,centery-distancey:centery+distancey) = 0;
    elseif string(varargin(2)) == "c"
        radius = cell2mat(varargin(3));

        [rowsInImage,columnsInImage] = meshgrid(1:l, 1:w);
        % Next create the circle in the image.

        circlePixels = (rowsInImage - centery).^2 ...
            + (columnsInImage - centerx).^2 <= radius.^2;
        % circlePixels is a 2D "logical" array.
        % Now, display it.
        arr(circlePixels) = 0;
    else
        fprintf("Input not recognized, available formats are 'r' and 'c'.\n");
        error("Unrecognized Input")
    end
end