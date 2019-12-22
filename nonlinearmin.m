% Minimizes the function f with either the 'DFP' or 'BFGS' quasi-Newton
% method, as specified by the input parameter 'method'. The 'tol' parameter
% is used in check_stopping_conditions.m, in 5 different stopping criterions.
function [x, iter] = nonlinearmin(f, start, method, tol, printout)
x = start;
n = length(x);
x_history = zeros(n, 1);

iter = 0;
max_iters = 2000;
while iter < max_iters
    iter = iter + 1; 
    x_history(:, iter) = x;
    %disp(['Iteration # ', num2str(iter)])
    
    if check_stopping_conditions(f, x_history, tol)
        %disp(['Nbr of iterations:  ', num2str(iter)])        
        return %Local min found!
    end

    y = x;
    D = eye(n);
    for j = 1:n
        d = -D*grad(f,y);
        [lambda, ls_iters] = linesearch(f,y,d);        
        p = lambda*d; %step
        if norm(p) < 1e-10 %minimal step size: CONVERGED.
            %disp(['Nbr of iterations:  ', num2str(iter)])        
            return
        end        
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
%x = [Inf; Inf]; %Represents not converged for task 1.
%disp(start')
end

