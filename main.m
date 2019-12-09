% Main function for testing if everything works properly.

%{
%Self-invented function, min at x=0.
func1 = @(x) x^4 - 1;
x1 = nonlinearmin(func1, [0.3], 'DFP', 0.001, 0)
f1 = func1(x1)
%}

%Rosenbrock, min at x=[1,1].
func2 = @rosenbrock;
x2 = nonlinearmin(func2, [0.29, 0.3], 'DFP', 1e-6, 0)
f2 = func2(x2)






