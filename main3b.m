% Solve task 3 exercise 9.5 (barrier problem).
clear all
close all
%{
Exercise 9.5 Minimize  (x1-5)^2 + (x2-3)^2
                 s.t.  x1 + x2 - 3 <= 0
                       -x1 + 2x2 - 4 <= 0
%}
f = @(x) (x(1)-5)^2 + (x(2)-3)^2;
%(alpha, eg. barrier function, is defined in barrier.m)
%(auxiliary function is defined in the for loop).

epsilon = [10, 1, 0.1, 0.01, 0.001, 1e-3, 1e-4];
x = [0; 0];
%x = [-1e7; -1e7];  :)
%x = [0; -1e7];  :)
%x = [1e7; -1e7];  :)
%x = [-2e7; -1e7];  :)

% Debugging:
f_history = zeros(length(epsilon), 1);     %f should decrease
alpha_history = zeros(length(epsilon), 1); %alpha should increase
aux_history = zeros(length(epsilon), 1);   %aux should decrease

for i = 1:length(epsilon)
    aux = @(x) f(x) + epsilon(i)*barrier3b(x);    
    x = nonlinearmin(aux, x, 'BFGS', 1e-8, 0);
    
    f_history(i) = f(x);
    alpha_history(i) = barrier3b(x);
    aux_history(i) = aux(x);
end
%{
1. How satisfactorily your algorithm solves Excercises 9.5
From a graph it is easy to see that the optimal x is [5/2; 1/2].
If we let the last epsilon be equal to 1e-8, we get x = [2.5000; 0.5000].
This result is satisfactory. It turns out that it's actually possible to
starting at epsilon = 1e-8, for this particular problem...
For reference, letting the last epsilon be equal to 1e-4 yields x = [2.4978; 0.4978].
%}

%{
2. How different initial points affect the convergence and the solution
Always convergent to the same solution  :)

---This one is FINISHED :) (I think)---
%}


