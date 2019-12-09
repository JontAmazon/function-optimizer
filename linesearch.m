function [lamb, ls_iters] = linesearch(f,x,d)
ls_iters = 0;

% OPTIONS:
%[no linesearch, exact linesearch, Armijo, GS, Newton]
option = 2;


% 1. No linesearch.
if option == 1
    lamb = 1;
end

% 2. Exact linesearch.
if option == 2
    f_line = @(t) f(x + t*d);
    lamb = fminsearch(f_line, x);
end

% 3. Armijo.
if option == 3
    armijo = 3;
    lamb = armijo;
end

% 4. Golden section.
if option == 4
    gs = 4;
    lamb = gs;
end

% 5. Newton.
if option == 5
    newton = 5;
    lamb = newton;
end

end




% Golden section:
%{
function [a_new, b_new] = goldenSection(func, a, b)
    alpha = (-1+sqrt(5))/2;
    lambda = a + (1-alpha)*(b-a);
    mu = a + alpha*(b-a);

    if (func(lambda) > func(mu))
        a_new = lambda;
        b_new = b;
    else
        a_new = a;
        b_new = mu;
    end
end
%}