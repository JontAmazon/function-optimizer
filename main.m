% Solve task 1 (unconstrained problem).
clear all
close all

%Rosenbrock, min at x=[1; 1].
fun = @rosenbrock;
x = nonlinearmin(fun, [200; 200], 'DFP', 1e-8, 0);
disp(['f_min: ', num2str(fun(x)), '   found at x:'])
disp(x')
%{
For each of DFP and BFGS, try many different initial points.
%}


%_________________________________________________________________________
% Automated tests with MANY starting points.
%_________________________________________________________________________
vals = [-50 -10 -1 0 1 10 50]; %values that both x1 and x2 will take.
n = length(vals);
f_vals = zeros(n^2, 1);
x0_vals = zeros(n^2, 2);
index = 0;

no_convergence_counter = 0;

for a = 1:n
for b = 1:n
    index = index + 1;
    x = [vals(a); vals(b)];
    
    success = 1;
    try
        x = nonlinearmin(fun, x, 'BFGS', 1e-8, 0);
    catch %all?
        success = 0;
        break;
    end
    
    if (success)
        f_vals(index) = fun(x);
    else
        f_vals(index) = Inf;
        no_convergence_counter = no_convergence_counter + 1;
    end
    x0_vals(index, 1) = vals(a);
    x0_vals(index, 2) = vals(b);
    
end
end
[min, i] = min(f_vals);
sad_rate = no_convergence_counter / length(f_vals) %percentage not converge.

% Great success =)

