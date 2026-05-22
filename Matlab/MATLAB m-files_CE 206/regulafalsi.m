function [root,fx,ea,iter]=regulafalsi(func,xl,xu,es,maxit)
% [root,fx,ea,iter]=regulafalsi('func',xl,xu,es,maxit):
% uses regula falsi method to find the root of func
% input:
% func = name of function
% xl, xu = lower and upper guesses
% es = desired relative error (default = 0.0001)
% maxit = maximum allowable iterations (default = 50)

% output:
% root = real root
% fx = function value at root
% ea = approximate relative error (%)
% iter = number of iterations

if nargin<3,error('at least 3 input arguments required'),end
test = feval('func',xl)*feval('func',xu);
if test>0,error('no sign change'),end
if nargin<4|isempty(es), es=0.0001;end
if nargin<5|isempty(maxit), maxit=50;end
iter = 0; xr = xl; ea = 100;
while (1)
  xrold = xr;
  xr = xu-feval('func',xu)*(xl-xu)/(feval('func',xl)-feval('func',xu));
  iter = iter + 1;
  if xr ~= 0,ea = abs((xr - xrold)/xr) * 100;end
  test = feval('func',xl)*feval('func',xr);
  if test < 0
    xu = xr;
  elseif test > 0
    xl = xr;
  else
    ea = 0;
  end
  if ea <= es | iter >= maxit,break,end
end
root = xr; fx = feval('func',xr);