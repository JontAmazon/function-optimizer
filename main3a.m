% Solve task 3 exercise 9.3 (penalty problem).
clear all
close all
%{
Exercise 9.3 Minimize  exp(x1) + x1^2 + x1x2
                 s.t.  x1/2 + x2 - 1 = 0
%}
f = @(x) exp(x(1)) + x(1)^2 + x(1)*x(2);
h1 = @(x) x(1)/2 + x(2) - 1;
alpha = @(x) h1(x)^2; %EV could do ^4, but then increase final mu value.
%(auxiliary function is defined in the for loop).

mu = [1e3 1e4 1e5];
x = [30; 30];

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
We get this value for mu=1e5. Thus, the result is satisfactory  :)
%}
%{

2. How different initial points affect the convergence and the solution
The below automated tests always converged for values on x1 and x2 in [-50,
50], but failed for values of greater absolute value than 50. The reason
they failed was because the gradient got NaN-values from grad.m

For this problem, we picked the first epsilon to be quite large, 
since the unconstrained problem (corresponding to epsilon = 0) is unbounded.
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
    success = 1;
    x = [vals(a); vals(b)];
    for i = 1:length(mu)
        aux = @(x) f(x) + mu(i)*alpha(x); 
        
        %x = nonlinearmin(aux, x, 'BFGS', 1e-8, 0);
        try
            x = nonlinearmin(aux, x, 'BFGS', 1e-8, 0);
        catch %all?
            success = 0;
            break;
        end
    end
    
    index = index + 1;
    if (success)
        f_vals(index) = f(x);
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

