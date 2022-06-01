function [ erms, epk, etot ] = process_err_split(d_source,dist_start)
%process_err    Generate rms average, peak, and total error over disturbance
%               peroid (starting @ time(ms) dist_start


    %{
        run_data.TrackingError.signals(d).values(r,c) :
        Channels d: 1 - X direction X1(1)
                    2 - y direction X1(2)
                    3 - hdg X1(3)


        Columns:    1 - Lower Limit
                    2 - Upper Limit
                    3 - ABLF tracking error
                    4 - FxT UBLF tracking error
                    5 - Backstepping tracking error

%}

    % rms error
    erms                    = [ rms(d_source.values(dist_start:end,1)), ...
                                rms(d_source.values(dist_start:end,2)), ...
                                rms(d_source.values(dist_start:end,3)) ];

                    
    % peak error
    epk                     = [ max(max(d_source.values(dist_start:end,1)), abs( min( d_source.values(dist_start:end,1) ) ) ), ...
                                max(max(d_source.values(dist_start:end,2)), abs( min( d_source.values(dist_start:end,2) ) ) ), ...
                                max(max(d_source.values(dist_start:end,3)), abs( min( d_source.values(dist_start:end,3) ) ) ) ];

                            
    % total error
    etot                    = [ sum(abs( d_source.values(dist_start:end,1) ) ), ...
                                sum(abs( d_source.values(dist_start:end,2) ) ), ...
                                sum(abs( d_source.values(dist_start:end,3) ) ) ];

            
            
end

