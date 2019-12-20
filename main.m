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


