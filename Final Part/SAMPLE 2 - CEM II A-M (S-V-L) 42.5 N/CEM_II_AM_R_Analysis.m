
[t_new, tamb_new, ts_new,q_g, t_rate]= heat_gen_rate(); % calling the function 


%% Save filled temperature record
T = table(t_new', tamb_new', ts_new', ...
    'VariableNames', {'Universal_Time_h','Room_Temperature','Cement_Temperature'});

writetable(T, 'filled_temperature_record.xlsx');
disp('New Excel file generated: filled_temperature_record.xlsx');

%% Summary
[max_qg, max_idx] = max(q_g);
fprintf('Max heat rate: %.3f J/min/g\n', max_qg);
fprintf('Time at max: %.2f min\n', t_rate(max_idx));


%% Heat generation rate around peak
disp('Heat generation rate around peak:');
for i = max_idx-5 : max_idx+5
    if i >= 1 && i <= length(t_rate)
        fprintf('t = %.2f h, q_g = %.2f J/h/g\n', t_rate(i), q_g(i));
    end
end

%% Sample plot points (every ~0.1 h)
disp('Sample plot points (t, q_g):');
for i = 1:25:length(t_rate)
    fprintf('%.2f, %.2f\n', t_rate(i), q_g(i));
end

