% Create a logical image of a circle with specified
% diameter, center, and image size.
% First create the image.
imageSizeX = 400;
imageSizeY = 400;
[columnsInImage rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% Next create the circle in the image.
centerX = imageSizeX/2;
centerY = imageSizeY/2;
radius = 75;
circlePixels = (rowsInImage - centerY).^2 ...
    + (columnsInImage - centerX).^2 <= radius.^2;
% circlePixels is a 2D "logical" array.
% Now, display it.
image(circlePixels) ;
colormap([0 0 0; 1 1 1]);
title('Binary image of a circle');

radiusX = 125;
radiusY = 175;
ellipsePixels = (rowsInImage - centerY).^2 ./ radiusY^2 ...
    + (columnsInImage - centerX).^2 ./ radiusX^2 <= 1;
% ellipsePixels is a 2D "logical" array.
% Now, display it.
image(ellipsePixels) ;
colormap([0 0 0; 1 1 1]);
title('Binary image of a ellipse', 'FontSize', 20);