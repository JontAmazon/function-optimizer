function g = grad2(F,x,delta)
% g = grad(F,x,delta)
%
% Calculates the gradient (column) vector of the function f at x.
%
% Differs from Andrey's grad.m in that delta is VARIABLE.

for j = 1:length(x)
   xplus = x;
   xminus = x;
   xplus(j) = x(j) + delta;
   xminus(j) = x(j) - delta;
   fplus = feval(F,xplus);
   fminus = feval(F,xminus);
   g(j,1) = ( fplus - fminus ) / (2*delta);
end

