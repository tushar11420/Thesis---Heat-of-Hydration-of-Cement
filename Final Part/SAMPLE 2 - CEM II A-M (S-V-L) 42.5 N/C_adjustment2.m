function [ r  ]= C_adjustment2()

%% importing vcctl generated excel file for adjustment of heat capacity of cement 

[data ] = readtable("HydrationOf-CEM_II_A-M_results.xlsx");

time = data(:, 2);
heat_release = data(:, 5);

time = table2array(time);
heat_release = table2array(heat_release);

time=time(time<=19);
time=time*60;

[time, idx] = sort(time );
heat_release= heat_release(idx);

%% Installing previous time from data analyses 


[tamb_new, ts_new, t_new]=Data_analysing2();
t_new_c=t_new(t_new < 1140);


heat_release_2 = interp1(time, heat_release, t_new_c,"linear");
heat_release_2(229:length(t_new)) = heat_release_2(end);

r=(1:length(heat_release_2))' ;


for i = 1:length(heat_release_2)
    r(i)=heat_release_2(i)/heat_release_2(end);
end
end 




    



  

