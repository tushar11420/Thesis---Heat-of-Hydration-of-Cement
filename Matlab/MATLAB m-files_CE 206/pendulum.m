function dydt = pendulum(t,y)
dydt = [y(2); -32.2/2*sin(y(1))];
end
