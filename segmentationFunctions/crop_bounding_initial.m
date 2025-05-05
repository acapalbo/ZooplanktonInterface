% takes video and crops it according to specificed dimensions
function cropped_img = crop_bounding_initial(base_img,bounding_pos,pad)
    [l,w,~] = size(base_img);
    % checking that total height + desired padding is less than the total
    % picture height
    if 1 + bounding_pos(4) + 2*pad > l
        pad = floor((l - bounding_pos(4) - 1)/2);
    end
    if 1 + bounding_pos(3) + 2*pad > w
        pad = floor((w - bounding_pos(3) - 1)/2);
    end

    padr = pad;
    padl = pad;
    padt = pad;
    padb = pad;

    % if object is over boundary, width/height is adjusted to be in bounds
    if bounding_pos(2) + bounding_pos(4) > l
        bounding_pos(4) = l - bounding_pos(2);
    end
    if bounding_pos(1) + bounding_pos(3) > w
        bounding_pos(3) = w - bounding_pos(1);
    end

    % adjusts padding if out of bounds
    if bounding_pos(2) - pad < 1
        padt = bounding_pos(2) - 1;
        padb = padb + pad - padt;
    end
    if bounding_pos(2) + bounding_pos(4) + pad > l
        padb = l - bounding_pos(2) - bounding_pos(4);
        padt = padt + pad - padb;
    end
    if bounding_pos(1) - pad < 1
        padl = bounding_pos(1) - 1;
        padr = padr + pad - padl;
    end
    if bounding_pos(1) + bounding_pos(3) + pad > w
        padr = w - bounding_pos(1) - bounding_pos(3);
        padl = padl + pad - padr;
    end

    cropped_img = base_img(max(bounding_pos(2) - padt,1):min(bounding_pos(2) + bounding_pos(4) + padb,l), ...
        max(bounding_pos(1)-padl,1):min(bounding_pos(1)+bounding_pos(3)+padr,w),:);
end