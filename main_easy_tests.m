% Script for tests on easy functions.
clear all
close all

%{
OPTIONS:
1. f(x) = x^2
2. f(x) = x(1)^2 + x(2)^2
3. f(x) = sin(x)
%}
option = 3;

if option == 1
    %Some function, min at x=0.
    fun = @(x) x^2;
    x = nonlinearmin(fun, [10], 'DFP', 1e-6, 0);
    disp(fun(x))
    disp(x')    
end
if option == 2
    %Some function, min at x=[0; 0].
    fun = @(x) x(1)^2 + x(2)^2;
    x = nonlinearmin(fun, [-10; 1000], 'DFP', 1e-6, 0);
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