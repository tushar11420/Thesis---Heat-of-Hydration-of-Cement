function [t_new, tamb_new, ts_new,q_g, t_rate]= heat_gen_rate()
%% calling the Data_analysing_function
[tamb_new, ts_new, t_new]=Data_analysing_2();

% Heat generation calculation
m_c = 138;    % g
m_w = 59;    % g
m_total = m_c + m_w;

cp_c = 0.84;    % J/g/K
cp_w = 4.18;    % J/g/K

cp_paste = (cp_c*m_c + cp_w*m_w) / m_total;
Cp = cp_paste * m_total;  % J/K
Cv = 1386.6;  % Cv due to the heat capacity of vessel in J/k 

C= Cp + Cv; % total heat capacity of system in J/k
                
Kl= 2.13 ;  %constant measure from calibration; unit in J/min/k

% dT/dt (K/min)
dT_dt = diff(ts_new)./diff(t_new);

t_rate = t_new(1:end-1);
delta_t = ts_new(1:end-1) - tamb_new(1:end-1);

% Total heat rate (J/min)
q = C .* dT_dt + Kl .* delta_t;

% Specific heat generation rate (J/min/g cement)
q_g = q / m_c;
end

