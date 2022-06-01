%% clear

    clear all;
    close all;

%%
    
    dist_start  = 2000; % time in run the disturbance starts, used to calculate outputs within this period
    Fval        = [75 50 5];  % Fval = [ X disturbance, Y disturbance, Hdg disturbance]
    InputSat    = 10000*[152.6153 ;  86.6581  ;  7.0714] ;     % Sets ± saturation limits on all controller outputs
    
    
    mdl_name    = 'MSV_uBLF_ABLFv3_0';

    run_data = sim (mdl_name,10);

                       
  %% Process control input data over disturbance period                        
    [dist_rms_u_fxt, dist_peak_u_fxt, dist_total_u_fxt]     = process_ctrlinputs(run_data.u_fxt.signals,    dist_start);
    [dist_rms_u_ablf, dist_peak_u_ablf, dist_total_u_ablf]  = process_ctrlinputs(run_data.u_ablf.signals,   dist_start);
    [dist_rms_u_bs, dist_peak_u_bs, dist_total_u_bs]        = process_ctrlinputs(run_data.u_bs.signals,     dist_start);
                
                        
%% Process error data over disturbance period

    [   dist_err_rms_fxt,   dist_err_rms_ablf,  dist_err_rms_bs, ...
        dist_err_pk_fxt,    dist_err_pk_ablf,   dist_err_pk_bs, ...
        dist_err_tot_fxt,   dist_err_tot_ablf,  dist_err_tot_bs ] = process_err(run_data.TrackingError.signals,dist_start);                            
                            
    
%% 
close all;
a1   = 1000;    %scaling factor for peak & rms error
a2   = 1/10000; %scaling factor for u total

figure;
P1      = [ dist_peak_u_fxt(1)  dist_rms_u_fxt(1)   dist_total_u_fxt(1)*a2     dist_err_pk_fxt(1)*a1   dist_err_rms_fxt(1)*a1     dist_err_tot_fxt(1) ;...   % FXT
            dist_peak_u_ablf(1) dist_rms_u_ablf(1)  dist_total_u_ablf(1)*a2    dist_err_pk_ablf(1)*a1  dist_err_rms_ablf(1)*a1    dist_err_tot_ablf(1) ;...    % ABLF
            dist_peak_u_bs(1)   dist_rms_u_bs(1)    dist_total_u_bs(1)*a2      dist_err_pk_bs(1)*a1    dist_err_rms_bs(1)*a1      dist_err_tot_bs(1) ];      % BS

spider_plot(P1, 'AxesLabels', {'u(1) Peak', 'u(1) RMS', 'u(1) Total x10^{4}', 'z1(1) Peak x10^{-3}', 'z1(1) RMS x10^{-3}', 'z1(1) Total' });
legend('FxT-UBLF', 'ABLF', 'BS', 'Location', 'northeast');

figure;
P2      = [ dist_peak_u_fxt(2)  dist_rms_u_fxt(2)   dist_total_u_fxt(2)*a2     dist_err_pk_fxt(2)*a1   dist_err_rms_fxt(2)*a1     dist_err_tot_fxt(2) ;...   % FXT
            dist_peak_u_ablf(2) dist_rms_u_ablf(2)  dist_total_u_ablf(2)*a2    dist_err_pk_ablf(2)*a1  dist_err_rms_ablf(2)*a1    dist_err_tot_ablf(2) ;...    % ABLF
            dist_peak_u_bs(2)   dist_rms_u_bs(2)    dist_total_u_bs(2)*a2      dist_err_pk_bs(2)*a1    dist_err_rms_bs(2)*a1      dist_err_tot_bs(2) ];      % BS

spider_plot(P2, 'AxesLabels', {'u(2) Peak', 'u(2) RMS', 'u(2) Total x10^{4}', 'z1(2) Peak x10^{-3}', 'z1(2) RMS x10^{-3}', 'z1(2) Total' });
legend('FxT-UBLF', 'ABLF', 'BS', 'Location', 'northeast');

figure;
P3      = [ dist_peak_u_fxt(3)  dist_rms_u_fxt(3)   dist_total_u_fxt(3)*a2     dist_err_pk_fxt(3)*a1   dist_err_rms_fxt(3)*a1     dist_err_tot_fxt(3) ;...   % FXT
            dist_peak_u_ablf(3) dist_rms_u_ablf(3)  dist_total_u_ablf(3)*a2    dist_err_pk_ablf(3)*a1  dist_err_rms_ablf(3)*a1    dist_err_tot_ablf(3) ;...    % ABLF
            dist_peak_u_bs(3)   dist_rms_u_bs(3)    dist_total_u_bs(3)*a2      dist_err_pk_bs(3)*a1    dist_err_rms_bs(3)*a1      dist_err_tot_bs(3) ];      % BS

spider_plot(P3, 'AxesLabels', {'u(3) Peak', 'u(3) RMS', 'u(3) Total x10^{4}', 'z1(3) Peak x10^{-3}', 'z1(3) RMS x10^{-3}', 'z1(3) Total' });
legend('FxT-UBLF', 'ABLF', 'BS', 'Location', 'northeast');

%%

% P       = [ dist_peak_u_fxt(1)  dist_rms_u_fxt(1)   dist_total_u_fxt(1)     ;...   % FXT
%             dist_peak_u_ablf(1) dist_rms_u_ablf(1)  dist_total_u_ablf(1)    ;...    % ABLF
%             dist_peak_u_bs(1)   dist_rms_u_bs(1)    dist_total_u_bs(1)       ];      % BS
% 
% spider_plot(P, 'AxesLabels', {'U(1) Peak', 'U(1) RMS', 'U(1) Total' });
% legend('FxT-UBLF', 'ABLF', 'BS', 'Location', 'southoutside');
%{
    close all;
    figure;
    hold on;
    plot(dist_err_stats(1,:));
    plot(dist_err_stats(4,:));
    plot(dist_err_stats(7,:));
    legend ('FxT-UBLF', 'ABLF', 'BS');
    xlabel('Disturbance','FontSize',10,'FontWeight','bold');
    ylabel(' RMS Error Z(1) - X position','FontSize',10,'FontWeight','bold');
    hold off;
    
    figure;
    hold on;
    plot(dist_err_stats(2,:));
    plot(dist_err_stats(5,:));
    plot(dist_err_stats(8,:));
    legend ('FxT-UBLF', 'ABLF', 'BS');
    xlabel(' Disturbance', 'FontSize',10,'FontWeight','bold');
    ylabel(' RMS Error Z(2) - Y position','FontSize',10,'FontWeight','bold');
    hold off;
    
 
    figure;
    hold on;
    plot(dist_err_stats(3,:));
    plot(dist_err_stats(6,:));
    plot(dist_err_stats(9,:));
    legend ('FxT-UBLF', 'ABLF', 'BS');
    xlabel(' Disturbance', 'FontSize',10,'FontWeight','bold');
    ylabel(' RMS Error Z(3) - Heading','FontSize',10,'FontWeight','bold');
    hold off;
    
    % Plot control input data
    figure;
    hold on;
    plot(dist_u_stats(1,:));
    plot(dist_u_stats(4,:));
    plot(dist_u_stats(7,:));
    legend ('FxT-UBLF', 'ABLF', 'BS');
    xlabel(' Disturbance ', 'FontSize',10,'FontWeight','bold');
    ylabel( 'u(1) RMS Longitudinal Control' ,'FontSize',10,'FontWeight','bold');
    hold off;
    
    figure;
    hold on;
    plot(dist_u_stats(2,:));
    plot(dist_u_stats(5,:));
    plot(dist_u_stats(8,:));
    legend ('FxT-UBLF', 'ABLF', 'BS');
    xlabel(' Disturbance', 'FontSize',10,'FontWeight','bold');
    ylabel( 'u(2) RMS Lateral Control' ,'FontSize',10,'FontWeight','bold');
    hold off;
    
    figure;
    hold on;
    plot(dist_u_stats(3,:));
    plot(dist_u_stats(6,:));
    plot(dist_u_stats(9,:));
    legend ('FxT-UBLF', 'ABLF', 'BS');
    xlabel(' Disturbance', 'FontSize',10,'FontWeight','bold');
    ylabel( 'u(3) RMS Yaw Control' ,'FontSize',10,'FontWeight','bold');
    hold off; 
%}

