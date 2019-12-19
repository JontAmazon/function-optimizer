% Solve task 3 exercise 9.3 (penalty problem).
clear all
close all
%{
Exercise 9.3 Minimize  exp(x1) + x1^2 + x1x2
                 s.t.  x1/2 + x2 - 1 = 0
%}
f = @(x) exp(x(1)) + x(1)^2 + x(1)*x(2);
h1 = @(x) x(1)/2 + x(2) - 1;
alpha = @(x) h1(x)^2;
%(auxiliary function is defined in the for loop).

mu = [10 30 100 300 1000];
x = [0; 0];

% Debugging:
f_history = zeros(length(mu), 1);     %f should increase
alpha_history = zeros(length(mu), 1); %alpha should decrease
aux_history = zeros(length(mu), 1);   %aux should increase

for i = 1:length(mu)
    aux = @(x) f(x) + mu(i)*alpha(x);    
    x = nonlinearmin(aux, x, 'BFGS', 1e-8, 0);
    
    f_history(i) = f(x);
    alpha_history(i) = alpha(x);
    aux_history(i) = aux(x);
end
%{
1. How satisfactorily your algorithm solves Excercises 9.3
Optimal solution (from optimtool): x = [-1.278; 1.639].  f_min = -0.1828.



%}


%{
2. How different initial points affect the convergence and the solution



%}

