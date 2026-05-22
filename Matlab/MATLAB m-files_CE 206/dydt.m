function dydt = dydt(t, y)
dydt = 9.81 - 0.25*y^2/68.1;
%dydt = y.*(t.^3)-1.5*y;
%dydt = y;
end