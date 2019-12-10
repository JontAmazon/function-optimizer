% Minimizes the function f with either the 'DFP' or 'BFGS' quasi-Newton
% method, as specified by the input parameter.
% (input 1 for DFP, 2 for BFGS (as of now)).
function [x, f_history, lamb_history] = nonlinearmin(f, start, method, tol, printout)
x = start;
n = length(x);

iter = 0;
max_iters = 5000;
f_history = zeros(max_iters, 1);
lamb_history = zeros(max_iters, 1);
while iter < max_iters
    iter = iter + 1; 
    f_history(iter) = f(x);
    disp(['Iteration # ', num2str(iter)])  
    y = x;
    D = eye(n);

    %EV todo = en funktion checkStoppingConditions() med flera olika tester, 
    %och som printar vilket som gav utslag.
    if norm(grad(f,x)) < tol
        [~, flag] = chol(D);
        if flag == 0 %(doesn't seem to be needed, from tries on sin(x)).
            disp('Local min found!')
            f_history = f_history(1:iter);
            lamb_history = lamb_history(1:iter);
            return            
        end
    end    

    for j = 1:n
        d = -D*grad(f,y);
        [lambda, ls_iters] = linesearch(f,y,d);
        lamb_history(iter) = lambda;
        p = lambda*d;
        q = grad(f,y+p)-grad(f,y);
        y = y + p;
        D = quasi_newton(method,p,q,D);
        if printout
            iter_print(j,y,norm(p),f(y),norm(grad(f,y)),ls_iters,lambda);
        end
    end
    x = y;    
end
disp(['Did not converge in ', num2str(max_iters), ' iterations.'])
end

