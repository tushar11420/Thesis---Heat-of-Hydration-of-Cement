function [tamb_new, ts_new, t_new]=Data_analysing_2()

[known_temp, final_time] = recordeddata();
known_temp= table2array(known_temp);
final_time=table2array(final_time);

tamb_known= known_temp(:,1);
ts_known = known_temp(:,2);

% Sort by time
[final_time, idx] = sort(final_time);
[final_time, ia ]=unique(final_time);

tamb_known = tamb_known(idx);
ts_known   = ts_known(idx);

tamb_known = tamb_known(ia);
ts_known   = ts_known(ia);

% Interpolation (linear + extrapolation)
t_new = 0:5:final_time(end);   % every 5 minute 

tamb_new = interp1(final_time, tamb_known, t_new, 'linear', 'extrap');
ts_new   = interp1(final_time, ts_known, t_new, 'linear', 'extrap');

t_new=t_new.';
tamb_new=tamb_new.';
ts_new=ts_new.';

end





