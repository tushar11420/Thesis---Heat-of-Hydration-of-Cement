function [heat_release_2, r  ]= C_adjustment3()
[data ] = readtable("HydrationOf-MyMix_Sample 03 - CEM II A-M 42.5 R.xlsx");

time = data(:, 2);
heat_release = data(:, 5);

time = table2array(time);
heat_release = table2array(heat_release);

time=time(time<=19);
time=time*60;

[time, idx] = sort(time );
heat_release= heat_release(idx);




[tamb_new, ts_new, t_new]=Data_analysing3();
t_new_c=t_new(t_new < 1140);


heat_release_2 = interp1(time, heat_release, t_new_c,"linear");
heat_release_2(229:559) = heat_release_2(end);

r=(1:length(t_new))' ;


for i = 1:length(t_new)
    r(i)=heat_release_2(i)/heat_release_2(end);
end
end 




    



  

