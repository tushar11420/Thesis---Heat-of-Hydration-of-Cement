function f = fSSR(a, xm, ym)
yp = a(1)*(xm./a(2)).*exp(-xm./a(2)+1);
f = sum((ym-yp).^2);

