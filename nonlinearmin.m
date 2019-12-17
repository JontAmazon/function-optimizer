% Minimizes the function f with either the 'DFP' or 'BFGS' quasi-Newton
% method, as specified by the input parameter 'method'. The 'tol' parameter
% is used in check_stopping_conditions.m, in 5 (?) different stopping
% criterions.
function x = nonlinearmin(f, start, method, tol, printout)
x = start;
n = length(x);

iter = 0;
max_iters = 5000;

count_not_pos_def = 0; %statistics.
count_pos_def = 0;     %statistics.

while iter < max_iters
    iter = iter + 1; 
    disp(['Iteration # ', num2str(iter)])

    % Jonte:
    % TODO = fixa history for x  :)
    % TODO = skriv om inputten till funktionen nedan.
    %        x_k ?r x_history(iter)
    %        x_kmN = x_history(iter - 10)
    stop = checkStoppingConditions(f, x_k, x_km1, x_kmN, tol);
    if stop == 1
        disp('Local min found!')
        disp('Not pos def vs. pos def:')
        disp(count_not_pos_def)
        disp(count_pos_def)
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
        % [CHECKING IF ALL D ARE POS. DEF.] (MAYBE necessary?)
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



% OLD STOPPING CONDITION (only ||grad||):
%     %EV todo = en funktion checkStoppingConditions() med flera olika tester, 
%     %och som printar vilket som gav utslag.
%     if norm(grad(f,x)) < tol
%         [~, flag] = chol(D); %Necessary? Checking that D is pos. def. doesn't
%         if flag == 0         %doesn't seem to be needed, from tries on sin(x)).
%             disp('Local min found!')
%             disp('Not pos def vs. pos def:')
%             disp(count_not_pos_def)
%             disp(count_pos_def)
%             return            
%         end
%     end    
