function f = fmu(a, xm, ym)
yp = a(1)*exp(a(2)./xm);
f = sum((ym-yp).^2);