% Minimizes the function f with either the 'DFP' or 'BFGS' quasi-Newton
% method, as specified by the input parameter.
% (input 1 for DFP, 2 for BFGS (as of now)).
function x = nonlinearmin(f, start, method, tol, printout)
x = start;
n = length(x);

iter = 0;
max_iters = 50;
while iter < max_iters
    iter = iter + 1; 
    y = x;
    D = eye(n);

    for j = 1:n
        d = -D*grad(f,y);
        [lambda, ls_iters] = linesearch(f,y,d);
        p = lambda*d;
        q = grad(f,y+p)-grad(f,y);
        y = y + p;
        D = quasi_newton(method,p,q,D);
        if printout
            iter_print(j,y,p,f(y),norm(grad(f,y)),ls_iters,lambda);
        end
    end
    x = y;
    
    %[n?got slags convergence test, TODO = se s. 108]
    %^nog g?r en FUNKTION checkStoppingConditions() med flera olika tester, 
    %och som printar vilket som gav utslag.
    %   [EV flytta upp detta till f?rst i loopen].
    if norm(grad(f,x)) < tol
        break
    end
end
disp(['Did not converge in ', num2str(max_iters), ' iterations.'])
end

