    strArr = readmatrix("timeOutput.txt");
    [l,w]=size(strArr);
    iterations = floor(strArr/1000000);
    startEndTimes = strArr - iterations*1000000;
    startTimes = zeros(l,3);
    endTimes = zeros(l,3);
    for i = 1: length(iterations)
        tempIter = iterations(i);
        tempIdx = iterations == tempIter;
        currentTime = startEndTimes(tempIdx);
        startT = currentTime(1);
        endT = currentTime(2);
        startTimes(i,:) = [floor(startT/10000),floor((startT-floor(startT/10000)*10000)/100), startT - floor(startT/100)*100];
        endTimes(i,:) =  [floor(endT/10000),floor((endT-floor(endT/10000)*10000)/100), endT - floor(endT/100)*100];
    end
    t1=datetime(0,0,0,startTimes(:,1),startTimes(:,2),startTimes(:,3),'Format',"HH:mm:ss");
    t2=datetime(0,0,0,endTimes(:,1),endTimes(:,2),endTimes(:,3),'Format',"HH:mm:ss");
    loopTimes = t2 - t1;
    t3 = minutes(t1 - min(t1));
    t4 = minutes(t2 - min(t1));
    f = figure;
    c = winter(length(t4));
    for j = 1:length(t3)
        hold on
        plot([t3(j),t4(j)],[j,j],"LineStyle","--","Color",c(j,:));
        % yticks(1:30);
        hold on
        plot([t3(j),t4(j)],[j;j],"or");
        % text((t3(j)+t4(j))/2,j+0.25,string(datetime(0,0,0,0,0,seconds(loopTimes(j)),'Format',"mm:ss")),"HorizontalAlignment","center")
        % yticks(1:30);
    end
    text(ceil(max(t4))/16,length(t4)-1,strcat("Total Time Taken: ",num2str(max(t4),"%0.2f")," minutes"));
    ylabel("Iteration #")
    % yticks(1:length(t4))
    yticks(0:5:100)
    xlabel("Time (min)")
    % xticks(0:ceil(max(t4)))
    xticks(0:5:100)
    % xticklabels(0:ceil(max(t4)))
    ylim([0.5,length(t4)+0.5])
    loopTimes = datetime(0,0,0,0,0,seconds(loopTimes),'Format',"mm:ss");
    x = 1:length(iterations);
    % y = minute(loopTimes);
    % clearvars -except h_vars vid
% map = colormap('jet');
% [mmap,nmap] = size(map);
% data_min = min(y);
% data_max = max(y);
% f= figure(1), hold on
% for k = 1:length(y)
% h=bar(x(k),y(k));
% % now define col value based on data value (min data value maps to colormap map index 1
% % and max data value maps to colormap map last index);
% ind = fix(1+(mmap-1)*(y(k)-data_min)/(data_max-data_min));
% set(h, 'FaceColor', map(ind,:)) ;
% % Display the values as labels at the tips of the  bars.
% xtips1 = h.XEndPoints;
% ytips1 = h.YEndPoints + 3;
% labels1 = string(h.YData);
% text(xtips1,ytips1,labels1,'HorizontalAlignment','center')
% end
% xlabel('Iteration #')
% ylabel('Time (H:m:s)')
% hold off
% t = duration(0,repmat(0:8,[1,4]),repmat(0:15:45,[1,9]),"Format","mm:ss.SSS");
% t = sort(minutes(t))
% t = t(2:end);
% % yticks = (double(t));
% % yticklabels(string(t))
% % y = double(minutes(sort(y)));
% % CBAR_ticks = 10*(fix(min(y)/10):ceil(max(y)/10));
% % CBAR_ticks = y;
% % clim([min(CBAR_ticks),max(CBAR_ticks)]);
% % hcb=colorbar('TickLabels',strcat(num2str(CBAR_ticks), " min"));
% % % hcb.Title.String = "Y range";
% % hcb.Title.FontSize = 13;