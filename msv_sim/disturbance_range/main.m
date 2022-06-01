close all;
clear all;

LimStop = 0;    

set_start;
test_fxt;

set_start;
test_ablf;

set_start;
test_bs;

%% Plot Error Data

    close all;
    
    % > ##### RMS error ######
    
    % Setup y axis labels for plots in for loop
    ylab    = [ ' RMS Error Z(1) - X position' ; ...
                ' RMS Error Z(2) - Y position' ; ...
                ' RMS Error Z(3) - Heading   ' ];
    figure;
    for clm = 1:3
        nexttile;
        plot(err_fxt(:,clm));
        xlim([0 64]);
        hold on;
        plot(err_ablf(:,clm));
        plot(err_bs(:,clm));
        if clm == 1
            legend ('FxT-UBLF', 'ABLF', 'BS');
        end
        xlabel('Disturbance Run','FontSize',8,'FontWeight','bold');
        ylabel(ylab(clm,:),'FontSize',7,'FontWeight','bold');
        hold off;
    end
    
        % > ##### Peak error ######
        
    % Setup y axis labels for plots in for loop
    ylab    = [ ' Peak Error Z(1) - X position' ; ...
                ' Peak Error Z(2) - Y position' ; ...
                ' Peak Error Z(3) - Heading   ' ];
    
    for clm = 4:6
        nexttile;
        plot(err_fxt(:,clm));
        xlim([0 64]);
        hold on;
        plot(err_ablf(:,clm));
        plot(err_bs(:,clm));
        %legend ('FxT-UBLF', 'ABLF', 'BS');
        xlabel('Disturbance Run','FontSize',8,'FontWeight','bold');
        ylabel(ylab((clm-3),:),'FontSize',7,'FontWeight','bold');
        hold off;
    end
    
    
        % > ##### Total error ######
        
    % Setup y axis labels for plots in for loop
    ylab    = [ ' Total Error Z(1) - X position' ; ...
                ' Total Error Z(2) - Y position' ; ...
                ' Total Error Z(3) - Heading   ' ];
    
    for clm = 7:9
        %figure;
        nexttile;
        plot(err_fxt(:,clm));
        xlim([0 64]);
        hold on;
        plot(err_ablf(:,clm));
        plot(err_bs(:,clm));
        %legend ('FxT-UBLF', 'ABLF', 'BS');
        xlabel('Disturbance Run','FontSize',8,'FontWeight','bold');
        ylabel(ylab((clm-6),:),'FontSize',7,'FontWeight','bold');
        hold off;
    end
    
    %% Plot Control Input Data
    
 % > ##### RMS input ######
    
    
    % Setup y axis labels for plots in for loop
    ylab    = [ ' RMS Long Control U(1)' ; ...
                ' RMS Lat Control U(2) ' ; ...
                ' RMS Yaw Control U(3) ' ];
    figure;
    for clm = 1:3
        nexttile;
        plot(ctl_fxt(:,clm));
        xlim([0 64]);
        hold on;
        plot(ctl_ablf(:,clm));
        plot(ctl_bs(:,clm));
        if clm == 1
            legend ('FxT-UBLF', 'ABLF', 'BS');
        end
        xlabel('Disturbance Run','FontSize',8,'FontWeight','bold');
        ylabel(ylab(clm,:),'FontSize',7,'FontWeight','bold');
        hold off;
    end
    
            % > ##### Peak control input ######
        
    % Setup y axis labels for plots in for loop
    ylab    = [ ' Peak Long Control U(1)' ; ...
                ' Peak Lat Control U(2) ' ; ...
                ' Peak Yaw Control U(3) ' ];
    
    for clm = 4:6
        nexttile;
        plot(ctl_fxt(:,clm));
        xlim([0 64]);
        hold on;        
        plot(ctl_ablf(:,clm));
        plot(ctl_bs(:,clm));
        xlabel('Disturbance Run','FontSize',8,'FontWeight','bold');
        ylabel(ylab((clm-3),:),'FontSize',7,'FontWeight','bold');
        hold off;
    end
    
    
        % > ##### Total error ######
        
    % Setup y axis labels for plots in for loop
    ylab    = [ ' Cumulative Total Long Control U(1)' ; ...
                ' Cumulative Total Lat Control U(2) ' ; ...
                ' Cumulative Total Yaw Control U(3) ' ];
    
    for clm = 7:9
        nexttile;
        plot(ctl_fxt(:,clm));
        hold on;        
        xlim([0 64]);
        plot(ctl_ablf(:,clm));
        plot(ctl_bs(:,clm));
        xlabel('Disturbance Run','FontSize',8,'FontWeight','bold');
        ylabel(ylab((clm-6),:),'FontSize',7,'FontWeight','bold');
        hold off;
    end

 