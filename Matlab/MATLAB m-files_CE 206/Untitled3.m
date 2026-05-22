tspan = [0 1.6];
y0 = [pi/4, 0];
[t, y] = ode45(@pendulum, tspan, y0);
figure(1); plot(t,y(:,1));

%%
t = 0:0.1:1.6;
theta = pi/4*cos(sqrt(32.2/2)*t);
hold on;
plot(t,theta,'--');
hold off;
legend('ode45','analytical');
%%
tspan = [0 1.6];
y0 = [0, pi/4];
[t, y] = eulode_2(tspan,y0,0.05);
hold on;
figure(1); plot(t,y(:,2));
legend('ode45','analytical','Euler');