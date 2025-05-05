function lineCoords = bresenham(dataPoints)
    y = dataPoints(:,1);
    x = dataPoints(:,2);
    y_1 = y(1); 
    y_2 = y(2); 
    x_1 = x(1);
    x_2 = x(2);
    reflection = false;
    if abs(x_2-x_1) < abs(y_2-y_1)
        % reflection
        x = dataPoints(:,1);
        y = dataPoints(:,2);
        y_1 = y(1);
        y_2 = y(2);
        x_1 = x(1);
        x_2 = x(2);
        reflection = true;
    end
    posNegSign = +1;
    if x_1 > x_2
        x_1 = x(2); x_2 = x(1);
        y_1 = y(2); y_2 = y(1);
    end
    if y_1 > y_2
        y_1 = -y_1; y_2 = -y_2;
        posNegSign = -1;
    end
    m_new = 2*(y_2-y_1);
    new_slope_error = m_new - (x_2-x_1);
    tempY = y_1;
    lineCoords = [];

    for tempX = x_1:x_2
        new_slope_error = new_slope_error + m_new;
        if reflection
        lineCoords = cat(1,lineCoords,[posNegSign*tempY,tempX]);
        else
        lineCoords = cat(1,lineCoords,[tempX,posNegSign*tempY]);
        end
        if new_slope_error >= 0
            tempY = tempY + 1;
            new_slope_error = new_slope_error - 2*(x_2-x_1);
        end
    end
    if reflection
        lineCoords(end,1) = dataPoints(end,2);
    else
        lineCoords(end,end) = dataPoints(end,1);
    end
end