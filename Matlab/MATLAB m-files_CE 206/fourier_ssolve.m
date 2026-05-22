clc; clear all; close all;
n=8; dt=0.02; fs=1/dt; T=0.16;
tspan=(0:n-1)/fs;
y=5+cos(2*pi*12.5*tspan)+sin(2*pi*18.75*tspan);
subplot(3,1,1);
plot(tspan,y,'-ok','linewidth',2,'MarkerFaceColor','black');
title('(a) f(t) versus time (s)');
%%%%%%%%%%%%
Y=fft(y);
Y';
figure(1)
nyquist=fs/2; fmin=1/T;
f=linspace(fmin,nyquist,n/2);
Y(1)=[]; YP=Y(1:n/2);
subplot(3,1,2);
stem(f,real(YP),'linewidth',2,'MarkerFaceColor','blue');
grid; title('(b) Real component versus frequency')
subplot(3,1,3);
stem(f,imag(YP),'linewidth',2,'MarkerFaceColor','blue');
grid; title('(c) Imaginary component versus frequency')