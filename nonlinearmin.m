% Minimizes the function f with either the 'DFP' or 'BFGS' quasi-Newton
% method.
function x = nonlinearmin(f,start,method,tol,printout)
    x = start;
    n=100;
    iter = 0;
    while o_iter < 50
       o_iter = o_iter + 1; 
       y = x;
       D = eye(length(x));
       for j =1:n
          d = -D*grad(f,x);
          [lambda,ls_iters] = linesearch(y,d,f);
          p = lambda*d;
          q = grad(f,y+p)-grad(f,y);
          y = y + p;
          D = quasi_newton(method,p,q);
          iter = iter +1;
          iter_print(iter,y,p,f(y),norm(grad(f,y)),ls_iters,lambda);
       end
       x = y;
       o_iter= o_iter +1;
       if grad(x)<tol
           break
       end
    end
end