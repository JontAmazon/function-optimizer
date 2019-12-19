% 1. Test line search with f(x) = (1 - 10^a*x)^2
clear all
close all

% OBSERVATIONS (with x0 = [1], (BFGS), tol=1e-8):
% Smaller a ==> When a is too small, doesn't move from starting point.
% Larger a  ==> doesn't converge despite having found f==0.
%
% Analysis:
% - Very small a cause the grad.m to return grad==0, of course being
% lesser than the tolerance no matter what it is. If the "delta parameter"
% in grad.m is made bigger, it fixes the problem.
% - For a large a, we had insufficient stopping conditions. Additional
% stopping conditions with tol=1e-10 fixed the problem.

aa = [-10 -5 -2 2 5 10];
for i = 1:6
    a = aa(i);
    disp(['Testing linesearch quadratic function (f_min==0), for a: ', num2str(a)])
    f = @(x) (1 - 10^a*x)^2;
    x = nonlinearmin(f, [1], 'BFGS', 1e-12, 0);
    disp(['f_min: ', num2str(f(x)), '   found at x:'])
    disp(x')
end

% 2. Test line search with test_func.m
    %NOTE: fminunc(f, [0; 0]) didn't work!
f = @(x) test_func(x);
tic
[lambda_1, ls_iters_1] = linesearch(f,[0;0],[1;0]);
toc
tic
[lambda_2, ls_iters_2] = linesearch(f,[0;0],[0;1]);
toc
F_new_1 = f([0;0] + lambda_1.*[1;0]);
F_new_2 = f([0;0] + lambda_2.*[0;1]);
disp('Testing linesearch with test_func.m:')
disp([num2str(lambda_1), '    ', num2str(lambda_2), '    ', ...
    num2str(F_new_1), '    ', num2str(F_new_2), '    '])
%^Good F_new ? ?0.9 found in 0.006 sec. Shoulder be lesser than 0 at least.

