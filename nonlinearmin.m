% Minimizes the function f with either the 'DFP' or 'BFGS' quasi-Newton
% method, as specified by the input parameter 'method'. The 'tol' parameter
% is used in check_stopping_conditions.m, in 5 (?) different stopping
% criterions.
function x = nonlinearmin(f, start, method, tol, printout)
x = start;
n = length(x);
x_history = zeros(n, 1);

count_not_pos_def = 0; %statistics for D.
count_pos_def = 0;     %statistics for D.

iter = 0;
max_iters = 5000;
while iter < max_iters
    iter = iter + 1; 
    x_history(:, iter) = x;
    %disp(['Iteration # ', num2str(iter)])
    
    % Check stopping conditions.
    if check_stopping_conditions(f, x_history, tol)
        disp(['Nbr of iterations:  ', num2str(iter)])
        %disp('Statistics for D:')
        %disp(['   ~pos def: ', num2str(count_not_pos_def)])
        %disp(['    Pos def: ', num2str(count_pos_def)])
        return
    end

    y = x;
    D = eye(n);
    for j = 1:n
        d = -D*grad(f,y);
        [lambda, ls_iters] = linesearch(f,y,d);
        %disp(['ls_iters: ', num2str(ls_iters)])
        p = lambda*d;
        q = grad(f,y+p)-grad(f,y);
        y = y + p;
        D = quasi_newton(method,p,q,D);
        % ________________________________________________________________
        % [CHECKING IF ALL D ARE POS. DEF.] (PROBABLY NOT NECESSARY?)
        % According to p. [TODO] they should be, so Idk if should check
        % this and doing (D=D+epsilon*I) for incrementing epsilons when not.
        % Rosenbrock, x0=[200;200] ==> D was NOT pos. def. 15/5000 times.
        [~, flag] = chol(D);
        if flag == 0 %(D is PD)
            count_pos_def = count_pos_def + 1;
        else %(D is NOT PD)
            count_not_pos_def = count_not_pos_def + 1;
        end
        % EV TODO:  D=D+epsilon*I
        % ________________________________________________________________
        if printout
            iter_print(j,y,norm(p),f(y),norm(grad(f,y)),ls_iters,lambda);
        end
    end
    x = y;
end
disp(['Did not converge in ', num2str(max_iters), ' iterations.'])
end

