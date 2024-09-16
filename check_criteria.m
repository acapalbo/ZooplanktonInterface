% stats key: (1) area (2) average intesity (3) circularity (4) extent (5) minimum intesity
function validity = check_criteria(stats)
    validity = [0,0,0,0];
    if stats(1) ~= -1
        if stats(1) > 500 
            validity(1) = 1;
        end
        if stats(2) < 160
            validity(2) = 1;
        end
        if stats(3) > 1.2 || stats(3) < 0.95
            validity(3) = 1;
        end
        if stats(5) < 35
            validity(4) = 1;
        end
    end
end