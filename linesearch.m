function [lamb, ls_iters] = linesearch(f,x,d)
ls_iters = 0;
lamb = 1;





end




% Golden section (nja):
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