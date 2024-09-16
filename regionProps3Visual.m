volumeList = cat(1,props.Image);
% sortedVolumes = sort(volumeList);
BigVolumes = {};
z = 1;
iterCount = length(volumeList);

while z < iterCount
    % disp("enter")
    if nnz(cell2mat(volumeList(z))) > 1500
        BigVolumes = cat(1,BigVolumes,volumeList(z));
        volumeList(z) = [];
        z = z - 1;
        iterCount = length(volumeList);
    end
    z = z + 1;
end    