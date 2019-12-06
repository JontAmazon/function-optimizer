function g = grad(F,x)
% g = grad(F,x)
%
% Calculates the gradient (column) vector of the function f at x.

for j = 1:length(x)
   xplus = x;
   xminus = x;
   xplus(j) = x(j) + 1.e-8;
   xminus(j) = x(j) - 1.e-8;
   fplus = feval(F,xplus);
   fminus = feval(F,xminus);
   g(j,1) = ( fplus - fminus )/2.e-8;
end
