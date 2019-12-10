%% [FORGET ABOUT THIS SCRIPT].
% The Hessian is required for Newton's method, but there is no use for
% Newton's method... If we were to use Newton's method, we would do it for
% the function optimization part, and NOT the line search part.
%%
% Estimates the Hessian of the problem's objective function at point x, 
% using a (central) finite difference.
function G = hessian(f,x)
n = length(x);
G = zeros(n);
dx = 1e-3;

% G_i = (g(x + tol*e_i) - g(x - tol*e_i)) / (2*tol)
for i = 1:n
    x1 = x;
    x2 = x;
    x1(i) = x1(i) + dx;
    x2(i) = x2(i) - dx;           
    G(:,i) = ((grad(f,x1) - grad(f,x2)) / (2*dx));
end
G = 1/2*G + 1/2*G'; %since the Hessian should be symmetric.
end