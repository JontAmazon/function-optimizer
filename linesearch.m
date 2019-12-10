function [lamb, ls_iters] = linesearch(f,x,d)
ls_iters = 1;
lamb = 1;

%{
OPTIONS:
1. exact linesearch (nja)
2. Armijo
3. Newton (nja)

    %NOTE: tror egentligen vi f?r g?ra VILKEN SOM HELST, tex Wolf.
    %NOTE: we can't assume f to be unimodal, so no Golden section.
%}
option = 2;

% 1. Exact linesearch.
if option == 1                     %(DOESN'T WORK)
    f_line = @(t) f(x + t(1).*d);  %^correct implementation?
    lamb = fminsearch(f_line, x);  %^anyway... not important...
    lamb = lamb(1);
end

% 2. Armijo.
if option == 2
    epsilon = 0.7;
    alpha = 2;
    
    F = @(lambda) f(x + lambda.*d);
    T = @(lambda) F(0) + epsilon*lambda*grad(f,x)'*d;
    
    lamb = 1; %initial "guess".
    max_iters = 1000;
    for i = 1:max_iters
        F1 = F(lamb);
        F2 = F(alpha*lamb);
        T1 = T(lamb);
        T2 = T(alpha*lamb);
        if F1 > T1
            lamb = lamb / alpha;
        elseif T2 > F2
            lamb = lamb * alpha;
        else
            return %success.
        end
        ls_iters = ls_iters + 1;
    end
    
    if i == max_iters
        disp('Armijo didnt find a lambda in 1000 iterations...')
        disp('...now what should we do? ...Newton? Exact linesearch?')
        disp('...Idk... Lets see if it comes to this...')
    end
end        
   
% 3. Newton. [FORGET THIS ONE, it's way too expensive].
if option == 3
    for i = 1:10
        F_prim = d'*grad(f,x+lamb*d);
        F_bis = d'*hessian(f,x+lamb*d)*d;
        lamb = lamb - F_prim/F_bis;
        %stopping crit.
        ls_iters = ls_iters + 1;
    end
end

% Error check: did linesearch work?
if isnan(f(x+lamb*d))
    error('Bad job of the line search! (f diverged)')
end
if f(x+lamb*d) > f(x)
    error('Bad job of the line search! (f increased)')
end

end