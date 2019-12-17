% Solve task 2 (penalty problem).

function alpha = main2(x)

%PROBLEM
%
% min(e^(x1*x2*x3*x4*x5)) subject to
%
% x1^2 + x2^2 + x3^2 + x4^2 + x5^2 - 10 = 0,
% x2*x3 - 5*x4*x5 = 0,
% x1^3 + x3^3 + 1 = 0.
%
% The penalty function used is alpha(x) = sum_{1 to m} max_{over S} (0, g_k(x))
% with S = {g_k(x) < 0}.

alpha = max(0, (x(1)^2 + x(2)^2 + x(3)^2 + x(4)^2 + x(5)^2 - 10)) + ...
  max(0, (x2*x3 - 5*x4*x5)) + ...
  max(0, (x(1)^3 + x(3)^3 + 1));

%Return the auxiliary function

