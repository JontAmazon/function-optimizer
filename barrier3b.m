% Barrier function for task 3 exercise 9.5
%   Minimize  (x1-5)^2 + (x2-3)^2
%       s.t.  x1 + x2 - 3 <= 0
%             -x1 + 2x2 - 4 <= 0
function barrier3b = barrier(x)
g = zeros(2, 1);
g(1) = x(1) + x(2) - 3;
g(2) = -x(1) + 2*x(2) - 4;

barrier3b = 0;
for k = 1:2
    barrier3b=barrier3b - 1/g(k);
    %barrier=barrier - log( min(1, -g(k)) );
end

if sum(g > 0) > 0
    barrier3b=barrier3b + Inf;
end
end