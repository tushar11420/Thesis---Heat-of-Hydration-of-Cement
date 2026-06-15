function [tamb_new, ts_new, t_new]=Data_analysing3()

[known_temp, final_time] = recordeddata3();
known_temp= table2array(known_temp);
final_time=table2array(final_time);

tamb_known= known_temp(:,1);
ts_known = known_temp(:,2);

% Sort by time
[final_time, idx] = sort(final_time);
tamb_known = tamb_known(idx);
ts_known   = ts_known(idx);

% Interpolation (linear + extrapolation)
t_new = 0:5:final_time(end);   % every 5 minute 

tamb_new = interp1(final_time, tamb_known, t_new, 'linear', 'extrap');
ts_new   = interp1(final_time, ts_known, t_new, 'linear', 'extrap');

t_new=t_new.';
tamb_new=tamb_new.';
ts_new=ts_new.';

end





