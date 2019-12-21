function [lamb, ls_iters] = linesearch(f,x,d)
ls_iters = 0;

%{
OPTIONS:
1. Golden section (10 iterations)
2. Armijo
%}
option = 1;

% 1. Golden section
if option == 1
    F = @(lambda) f(x + lambda.*d);
    a = 0;
    
    %Initialize b to something appropriate.
    b = 1;
    Fa = F(a); %for debugging.
    Fb = F(b); %for debugging.
    while isinf(F(b)) || F(a)<F(b) %If F'(0) is drastic we require
        b = b / 16;                %lamb to be small.
    end
    while abs(F(a)-F(b)) < 1e-1 %If F' is near constant, take a big step.
        b = b * 16;
        if F(a) < F(b)
            b = b / 16;
            break;
        end
    end
    % TODO_1 = testa ||grad|| < tol
    % TODO_2 = testa approximera F_prime
    %while 

    %Golden section algorithm.
    ls_iters = 10;
    for i = 1:ls_iters
        [a, b] = golden_section(F, a, b);
    end
    lamb = (a+b)/2;
end


% 2. Armijo.
if option == 2
    epsilon = 0.7;
    alpha = 2;
    
    F = @(lambda) f(x + lambda.*d);
    T = @(lambda) F(0) + epsilon*lambda*grad(f,x)'*d;
%     "To calculate the search directions you may use the numerical
%     differentiation in the file grad.m. Do not use it directly in the 
%     line search subroutine as the fixed precision in grad.m may not be 
%     enough there in some cases."                                      --> Hmm, OK s?h?r? T = blabla*grad()
    % --> EVEV Alternative: After initiating lamb (as below), do:       --> B?TTRE: golden section!!!
%     F_prime = (F(lamb/1e2) - F(0)) / (lamb/1e2);
%     T = @(lambda) F(0) + epsilon*lambda*F_prime;
    % because we don't need more dimensions than 1.


    %Initialize lamb to something appropriate.
    lamb = 1;
    F0 = F(0);       %for debugging.
    Flamb = F(lamb); %for debugging.
    while isinf(F(lamb)) || F(0)<F(lamb) %If F'(0) is drastic we require
        lamb = lamb / 16;                %lamb to be small.
    end
    while abs(F(0)-F(lamb)) < 1e-1 %If F' is near constant, take a big step.
        lamb = lamb * 16;
        if F(0) < F(lamb)
            lamb = lamb / 16;
            break;
        end
    end
        
    %Armijo algorithm.
    max_iters = 1000;
    for i = 1:max_iters
        ls_iters = ls_iters + 1;
        
        F1 = F(lamb);
        T1 = T(lamb);
        F2 = F(alpha*lamb);
        T2 = T(alpha*lamb);
        if isinf(T1)
            T1 = F(0); %(lite os?ker p? detta, men verkar funka).
        end
        if isinf(T2)
            T2 = F(0);
        end
            
        if F1 > T1
            lamb = lamb / alpha;
        elseif T2 > F2
            lamb = lamb * alpha;
        else
            return %success.
        end
        
        if i == max_iters
            error('Armijo didnt find a lambda in 1000 iterations...') %never occurs.
            %error('...now what should we do? ...Newton? Exact linesearch?')
            %error('...Idk... Lets see if it comes to this...')
        end
    end    
end        
   

% Final error check: did linesearch work?
f_old = f(x);        %for debugging
f_new = f(x+lamb*d); %for debugging
step = lamb*d;       %for debugging

if isnan(f(x+lamb*d))
    error('Bad job of the line search! (f diverged)')
end
if f(x+lamb*d) > f(x)
    error('Bad job of the line search! (f increased)')
end

if lamb < 1e-12 %not a descent direction?
    [lamb, ls_iters] = linesearch(f,x,-d);
end

end

% Skip:
%{
% 3. Exact linesearch.
if option == 1                     %(DOESN'T WORK)
    f_line = @(t) f(x + t(1).*d);  %^correct implementation?
    lamb = fminsearch(f_line, x);  %^anyway... not important...
    lamb = lamb(1);
end

% 4. Newton. [FORGET THIS ONE, it's way too expensive].
if option == 3
    for i = 1:10
        F_prim = d'*grad(f,x+lamb*d);
        F_bis = d'*hessian(f,x+lamb*d)*d;
        lamb = lamb - F_prim/F_bis;
        %EV todo = stopping crit.
        ls_iters = ls_iters + 1;
    end
end
%}