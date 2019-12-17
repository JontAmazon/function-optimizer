% Main function for testing if everything works properly.
clear all
close all

%{
OPTIONS:
1. f(x) = x^2
2. f(x) = x(1)^2 + x(2)^2
3. f(x) = sin(x)
4. f(x) = rosenbrock   <--
%}
option = 4;

if option == 1
    %Some function, min at x=0.
    fun = @(x) x^2;
    x = nonlinearmin(fun, [0.3], 'DFP', 0.001, 0);
    disp(fun(x))
    disp(x')    
end
if option == 2
    %Some function, min at x=[0; 0].
    fun = @(x) x(1)^2 + x(2)^2;
    x = nonlinearmin(fun, [100; 100], 'DFP', 1e-6, 0);
    disp(fun(x))
    disp(x')
end
if option == 3
    %Some function, min at x=-1.5708 or x=4.7124.  MAX at 1.5708.
    fun = @(x) sin(x);
    x = nonlinearmin(fun, [1.5707], 'DFP', 1e-6, 0);
    disp(fun(x))
    disp(x')
end
if option == 4
    %Rosenbrock, min at x=[1; 1].
    fun = @rosenbrock;
    x = nonlinearmin(fun, [200; 200], 'BFGS', 1e-6, 1);
    disp(fun(x))
    disp(x')
end






