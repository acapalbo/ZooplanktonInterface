% format text file
% headerString = "# Please mark status with initials when updating; Ex: 'In Progress, AC'";
% spacerString = " ";
baseString = sprintf("Date:%s|Status:%s",strjoin(repmat("",[1,25])),strjoin(repmat("",[1,23])));
baseString = cat(1,baseString,strjoin(repmat("-",[59,1]),""));
% baseString = cat(1,headerString,spacerString,baseString);
fileNames = struct2table(dir("E:\202408XX_LUMEX03\PID")).name;
fileNames(1:2) = [];
for z = 1:length(fileNames)
    tempString = sprintf("%s%s|%s",char(fileNames(z)),strjoin(repmat("",[30 - length(char(fileNames(z))),1])),strjoin(repmat("",[30,1])));
    baseString = cat(1,baseString,tempString);
end