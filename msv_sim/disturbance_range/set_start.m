dx_step     = 30;       % increase to x disturbance each run
dx_max      = 90;      % maximum value of x disturbance

dy_max      = 90;
dy_step     = dy_max/(dx_max/dx_step);

dz_max      = 6;
dz_step     = dz_max/(dx_max/dx_step);