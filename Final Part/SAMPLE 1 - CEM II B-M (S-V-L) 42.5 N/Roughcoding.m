[q_g_total, q_g,q_g_fit,t_fit, fitresult, gof] = createFit2();
q_g;

t_rate = t_rate(1:end-1);
[max_qg, max_idx]= max(q_g_fit);
