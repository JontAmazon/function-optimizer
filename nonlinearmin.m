% Minimizes the function f with either the 'DFP' or 'BFGS' quasi-Newton
% method.
function x = nonlinearmin(f,start,method,tol,printout)
    x = start;
    n=100;
    
    while o_iter < 50
       o_iter = o_iter + 1; 
       y = x;
       D = eye(length(x));
       for j =1:n
          d = -D*grad(f,x);
          lambda = linesearch(y,d,f);
          p = lambda*d;
          q = grad(f,y+p)-grad(f,y);
          y = y + p;
          D = quasi_newton(method,p,q);
       end
       x = y;
       if grad(x)<tol
           break
       end
    end
end