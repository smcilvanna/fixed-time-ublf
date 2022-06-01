close all;
clear all;


%% 
    LimStop     = 1;    % Set flag for simulink to stop if error beyond limits
    stop_flag   = 0;
    t_run       = 10;    % time to run simulation 
    dist_start  = 2000;  % time in run the disturbance starts, used to calculate outputs within this period
    run         = 0;    % id number for run

    dist_inc_b  = 40;   % set the initial increment for disturbance
    min_eval    = 0.1;  % sets the minimum increment to look for good run
    
    mdl_name    = 'MSV_ublf';

    for dtest = 1:3
        stop_flag = 0;
        dist_inc    = dist_inc_b;
        Fval        = [0 0 0];  % Fval = [ X disturbance, Y disturbance, Hdg disturbance]

        while stop_flag == 0

            run = run + 1;
            Fval            % print current value under test to console
            run_data    = sim (mdl_name, 'CaptureErrors', 'on');

            test_fail(run,1:3) = Fval;

            
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

%             if isempty(run_data.ErrorMessage)  % check if error was reported from run, and if so set stop flag
%                stop_flag = 0;
%                Fval(dtest) = Fval(dtest) + dist_inc;   % no error so add disturbance for next run
%                test_fail(run,4) = 0;
%             else
%                 test_fail(run,4) = 1;
%                 if dist_inc < 0.1
%                     stop_flag = 1;
%                 else
%                     Fval(dtest) = Fval(dtest) - dist_inc;   % Roll back to previous disturbance value
%                     dist_inc = dist_inc/2;          % Reduce additional disturbance
%                     Fval(dtest) = Fval(dtest) + dist_inc;   % New (lesser) disturbance value
%                 end
%             end
        end
    end