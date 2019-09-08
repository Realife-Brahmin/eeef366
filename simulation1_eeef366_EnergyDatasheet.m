clc
close all
clear

hFigure = figure('Position', get(0,'ScreenSize'));

for i=1:4
    zeroPrefix = '0';    
    if i<3  
        houseName = ['house' zeroPrefix num2str(i)];
        houseNamepsolar = ['housepsolar' zeroPrefix num2str(i)];
        houseNamepwind = ['housepwind' zeroPrefix num2str(i)];
        houseNamephouse = ['housephouse' zeroPrefix num2str(i)];
    else
        houseName = ['industry' zeroPrefix num2str(i-2)];
        houseNamepsolar = ['industrypsolar' zeroPrefix num2str(i-2)];
        houseNamepwind = ['industrypwind' zeroPrefix num2str(i-2)];
        houseNamephouse = ['industryphouse' zeroPrefix num2str(i-2)];
    end
    fileName = [houseName '.csv'];
    houseData = csvread(fileName, 1,1);
    phouse = houseData(:,1)';
    pgrid = houseData(:,3)'; 
    psolar = houseData(:,4)'; 
    pwind = houseData(:,5)';
     
    numPoints = length(phouse); %=1440 minutes
    dt = 60;
    timeInSeconds = dt*(0:numPoints-1);%1440*60=86400

    timeInHours = timeInSeconds./3600;
    
    hFigure = subplot(2,2,i);   % create a 2 x 2 figure
    %for individual plots, comment out the line above
    %and replace it with "figure(i);" (excluding the quotes)
    hold on
    set(gca,'Color','k')
    plot(timeInHours, pgrid, 'g.-','LineWidth',5); 
    plot(timeInHours, psolar, 'y:','LineWidth',3); 
    plot(timeInHours, phouse, 'w--','LineWidth',3);
    plot(timeInHours, pwind, 'c:','LineWidth',3);

    grid on;
    ax = gca;
    ax.GridColor = [1, 1, 0];  % [R, G, B]
    if i<3 
        title(['House ', num2str(i)]); 
    elseif i>2 
        title(['Industry ', num2str(i-2)]); 
    end
    xlabel('Time (hours)');
    if i<3 
        ylabel('kW');
    elseif i>2 
        ylabel('MW'); 
    end
    axis([0, 25, -5, 15])
    
    % The following command creates a structure in the workspace with
    % the two aforementioned columns.
    eval([houseName ' = [timeInSeconds'' pgrid''];']);
    eval([houseNamepsolar ' = [timeInSeconds'' psolar''];']);
    eval([houseNamepwind ' = [timeInSeconds'' pwind''];']);
    eval([houseNamephouse ' = [timeInSeconds'' phouse''];']);
    
end
 lgd=legend({'P_{grid} aka Payable Power','P_{solar}','P_{house} aka Actual Power Used','P_{wind}'});
 lgd.TextColor=[1 1 0];
 lgd.Title.String = 'Legend';
 lgd.Title.FontSize = 24;
 lgd.FontSize = 12;
 lgd.Location='northwest';
 lgd.Orientation='vertical';

clear phouse
clear pgrid
clear psolar
clear timeInHours
clear houseName
clear houseData
clear i
clear numPoints
clear timeInSeconds
clear zeroPrefix
clear dt
clear fileName