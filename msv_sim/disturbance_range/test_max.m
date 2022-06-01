function [maxd] = test_max(mdl_name,min_eval)
%test_max : find the maximum unknown disturbance values for MSV controllers

    stop_flag   = 0;
    t_run       = 10;    % time to run simulation 
    dist_start  = 2000;  % time in run the disturbance starts, used to calculate outputs within this period
    run         = 0;  % id number for run
    dist_inc_b  = 40;

    for dtest = 1:3
        stop_flag   = 0;        % reset variables for new axis test
        dist_inc    = dist_inc_b;
        Fval        = [0 0 0];  % Fval = [ X disturbance, Y disturbance, Hdg disturbance]
         
        while stop_flag == 0
            run                 = run + 1;
            run_data            = sim ('MSV_ublf', 'CaptureErrors', 'on');
            test_fail(run,1:3)  = Fval;
            Fval                % print current value under test to console


            if isempty(run_data.ErrorMessage) || isempty(run_data)       % check if error was reported from run, and if so set stop flag
               stop_flag = 0;
               Fval(dtest) = Fval(dtest) + dist_inc;   % no error so add disturbance for next run
               test_fail(run,4) = 0;
            
            else                                        % have failed on the run with current fval
                test_fail(run,4) = 1;                   % record the fail
                if dist_inc < min_eval                  % check if have reached minimum disturbance increment
                    stop_flag = 1;                        % if so we are done, stop
                    maxd(dtest) = Fval(dtest) - dist_inc; % and write out last good value as max
                else                                        % or we still need to try smaller increment
                    Fval(dtest) = Fval(dtest) - dist_inc;   % Roll back to previous disturbance value
                    dist_inc = dist_inc/2;                  % Reduce additional disturbance increment
                    Fval(dtest) = Fval(dtest) + dist_inc;   % New (lesser) disturbance value for next loop
                end
            end
        end
    end


end

