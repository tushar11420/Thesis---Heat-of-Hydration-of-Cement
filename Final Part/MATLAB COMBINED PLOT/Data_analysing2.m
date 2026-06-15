function [tamb_new, ts_new, t_new]=Data_analysing2()

[known_temp, final_time] = recordeddata2();
known_temp= table2array(known_temp);
final_time=table2array(final_time);

tamb_known= known_temp(:,1);
ts_known = known_temp(:,2);

%% Sort by time
[final_time, idx] = sort(final_time);
tamb_known = tamb_known(idx);
ts_known   = ts_known(idx);


%% removing unique values 

[final_time_unique, ia] = unique(final_time, 'stable');
tamb_known_unique = tamb_known(ia);
[final_time_unique_2, ia] = unique(final_time, 'stable');
ts_known_unique = ts_known(ia);


%% Interpolation (linear + extrapolation)
t_new = 0:5:final_time(end);   % every 5 minute 


tamb_new = interp1(final_time_unique, tamb_known_unique, t_new, 'linear', 'extrap');

ts_new   = interp1(final_time_unique_2, ts_known_unique, t_new, 'linear', 'extrap');

t_new=t_new.';
tamb_new=tamb_new.';
ts_new=ts_new.';

end





