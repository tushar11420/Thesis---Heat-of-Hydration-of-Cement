function r = res(za)
[x,y]=ode45(@dydxn, [0 10], [300 za]);
r=y(length(x),1)-400;
end