% Main function for testing if everything works properly.
clear all
close all

%{
OPTIONS:
1. f(x) = x^2
2. f(x) = x(1)^2 + x(2)^2
3. f(x) = sin(x)
4. f(x) = rosenbrock
%}
plot_history = 0;
option = 4;

if option == 1
    %Some function, min at x=0.
    fun = @(x) x^2;
    [x, f_history, lamb_history] = nonlinearmin(fun, [0.3], 'DFP', 0.001, 0);
    disp(fun(x))
    disp(x')    
end
if option == 2
    %Some function, min at x=[0; 0].
    fun = @(x) x(1)^2 + x(2)^2;
    [x, f_history, lamb_history] = nonlinearmin(fun, [100; 100], 'DFP', 1e-6, 0);
    disp(fun(x))
    disp(x')
end
if option == 3
    %Some function, min at x=-1.5708,  x=4.7124.  MAX at 1.5708.
    fun = @(x) sin(x);
    [x, f_history, lamb_history] = nonlinearmin(fun, [1.5707], 'DFP', 1e-6, 0);
    disp(fun(x))
    disp(x')
end
if option == 4
    %Rosenbrock, min at x=[1; 1].
    fun = @rosenbrock;
    [x, f_history, lamb_history] = nonlinearmin(fun, [1.01; 1.01], 'BFGS', 1e-6, 1);
    disp(fun(x))
    disp(x')    
end


if plot_history
    plot(f_history)
    %hold on
    %plot(lamb_history)
end







