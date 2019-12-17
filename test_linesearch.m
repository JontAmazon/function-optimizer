% 1. Test line search with f(x) = (1 - 10^a*x)^2
clear all
close all

% Observations (((with x0 = [1], (BFGS), tol=1e-6))):
% Smaller a ==> converges fast. When a is too small, doesn't move from
%               starting point.
% Larger a  ==> doesn't converge despite having found f==0. Because of
%               insufficient stopping conditions? (TODO).
% Thoughts:
% - for a small a, bad stopping conditions?
% - for a large a, insufficient stopping conditions?
aa = [-10 -5 -2 2 5 10];
for i = 5:5
    a = aa(i);
    f = @(x) (1 - 10^a*x)^2; %Quadratic function... f_min = 0.
    x = nonlinearmin(f, [1], 'BFGS', 1e-6, 0);
    disp(f(x))
    disp(x')    
end


% 2. Test line search with test_func.m
    %NOTE: fminunc(f, [0; 0]) didn't work!
% f = @(x) test_func(x);
% [lambda_1, ls_iters_1] = linesearch(f,[0;0],[1;0]);
% [lambda_2, ls_iters_2] = linesearch(f,[0;0],[0;1]);
% F_new_1 = f([0;0] + lambda_1.*[1;0]);
% F_new_2 = f([0;0] + lambda_2.*[0;1]);
% disp([num2str(lambda_1), '    ', num2str(lambda_2), '    ', ...
%     num2str(F_new_1), '    ', num2str(F_new_2), '    '])
%^Good F_new ? ?0.9 found in 0.006 sec. Shoulder be lesser than 0 at least.





