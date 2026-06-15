function [known_temp, final_time] = recordeddata3()

[num]= readtable("CEM II A-M 42.5 R.xlsx" );

known_temp = num(:,[1 2]);

final_time = num(:, 9);
final_time.Var9(final_time.Var9 == 0)=NaN;

%% clearing missing data 
known_temp = fillmissing(known_temp,'linear');

final_time= fillmissing(final_time,'linear');

%disp(room_Temp)
%disp(final_time)
end
















