% Solve task 1 (unconstrained problem).
clear all
close all

%Rosenbrock, min at x=[1; 1].
fun = @rosenbrock;

%
x = nonlinearmin(fun, [0; 0], 'DFP', 1e-6, 0);
disp(['f_min: ', num2str(fun(x)), '   found at x:'])
disp(x')
%}

%{
%_________________________________________________________________________
% Automated tests with MANY starting points.
%_________________________________________________________________________
%
vals = [-1000 -400 -200 -50 -5 0 5 50 200 400 1000]; %values that both x1 and x2 will take.
vals = vals ./ 100000;

n = length(vals);
f_vals = -ones(n^2, 1);  %objective values
x0_vals = -ones(n^2, 2); %start values
iters = -ones(n^2, 1);   %number of iterations.

index = 0;
error_counter = 0;
for a = 1:n
for b = 1:n
    index = index + 1;
    x = [vals(a); vals(b)];
    x0_vals(index, :) = x;
    
    no_error = 1;
    try
        [x, iter] = nonlinearmin(fun, x, 'DFP', 1e-6, 0);
    catch
        no_error = 0;
    end
    
    if (no_error)
        f_vals(index) = fun(x);
        iters(index) = iter;
    else
        f_vals(index) = 99999999; %Represents linesearch error.
        error_counter = error_counter + 1; %linesearch error.
    end    
end
end
[min, i] = min(f_vals);
%RESULTS:
error_rate = error_counter/length(f_vals)                                 % linesearch error.
didnt_converge = (sum(isnan(f_vals)) + sum(isinf(f_vals)))/length(f_vals) % > max_iters.
convergence_rate = sum(f_vals < 1e-4)/length(f_vals)                      % converged to min.
false_convergence = 1 - error_rate - didnt_converge - convergence_rate    % converged to wrong answer.
%}
