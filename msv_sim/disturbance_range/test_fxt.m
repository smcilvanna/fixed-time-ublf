%%
    t_run       = 10;    % time to run simulation 
    dist_start  = 2000;  % time in run the disturbance starts, used to calculate outputs within this period
    run         = 0;  % id number for run
    Fval        = [0 0 0];  % Fval = [ X disturbance, Y disturbance, Hdg disturbance]

    mdl_name    = 'MSV_ublf';
    
%     dx_step     = 40;       % increase to x disturbance each run
%     dx_max      = 120;      % maximum value of x disturbance
%     
%     dy_max      = 120;
%     dy_step     = dy_max/(dx_max/dx_step);
%     
%     dz_max      = 6;
%     dz_step     = dz_max/(dx_max/dx_step);
    
    run_size        = ((dx_max/dx_step) +1) ^3;   % how many runs will be done
    err_fxt         = zeros(run_size,12);
    ctl_fxt         = zeros(run_size,12);

    for ix = 0:dx_step:dx_max
     for iy = 0:dy_step:dy_max
       for iz = 0:dz_step:dz_max
        
        runx        = ix/dx_step + 1;
        runy        = iy/dx_step + 1;
        runz        = iz/dz_step + 1;
        run         = run + 1;
        
        Fval        = [ ix iy iz ]
        run_data    = sim (mdl_name,t_run);
                                     
%% Get error data over disturbance period

    [ erms_fxt, epk_fxt, etot_fxt ]         = process_split(run_data.error.signals, dist_start);    
    
     err_fxt(run,1:3)   = erms_fxt ;
     err_fxt(run,4:6)   = epk_fxt ;
     err_fxt(run,7:9)   = etot_fxt ;   
     err_fxt(run,10:12) = Fval ;
     
%% Get control input data over disurbance period

    [ctrms, ctpk, ctot]     = process_split(run_data.input.signals, dist_start);
    
     ctl_fxt(run,1:3)   = ctrms ;
     ctl_fxt(run,4:6)   = ctpk ;
     ctl_fxt(run,7:9)   = ctot ;   
     ctl_fxt(run,10:12) = Fval;


       end  % z loop (heading disturbance)
     end    % y loop (Y dir disturbance)
    end     % x loop (X dir disturbance)