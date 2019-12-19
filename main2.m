% Solve task 2 (penalty problem).
clear all
close all

f = @(x) exp((x(1)*x(2)*x(3)*x(4)*x(5)));
g1 = @(x) x(1)^2 + x(2)^2 + x(3)^2 + x(4)^2 + x(5)^2 - 10;
g2 = @(x) x(2)*x(3) - 5*x(4)*x(5);
g3 = @(x) x(1)^3 + x(3)^3 + 1;
alpha = @(x) max(0, g1(x))^2 + max(0, g2(x))^2 + max(0, g3(x))^2;
%(auxiliary function is defined in the for loop).

mu = [0.01 0.1 1 10 100];

% Debugging:
f_history = zeros(length(mu), 1);     %f should increase
alpha_history = zeros(length(mu), 1); %alpha should decrease
aux_history = zeros(length(mu), 1);   %aux should increase

x = [-2; 2; 2; -1; -1];
for i = 1:0 %length(mu)
    aux = @(x) f(x) + mu(i)*alpha(x); 
    x = nonlinearmin(aux, x, 'BFGS', 1e-8, 0);
    
    f_history(i) = f(x); %0.0036
    alpha_history(i) = alpha(x);
    aux_history(i) = aux(x);
end


%_________________________________________________________________________
% Automated tests with MANY starting points.
%_________________________________________________________________________
vals = [2, 0, 2]; %values that each of x1...x5 will take.
n = length(vals);
f_vals = zeros(n,n,n,n,n);
for a = 1:n
for b = 1:n
for c = 1:n
for d = 1:n
for e = 1:n
    success = 1;
    x = [vals(a); vals(b); vals(c); vals(d); vals(e)];
    for i = 1:length(mu)
        aux = @(x) f(x) + mu(i)*alpha(x); 
        try
            x = nonlinearmin(aux, x, 'BFGS', 1e-8, 0);
        catch %all?
            success = 0;
            break;
        end
    end
    
    if (success)
        f_vals(a,b,c,d,e) = f(x);
    else
        f_vals(a,b,c,d,e) = Inf;
    end
end
end
end
end
end
flatten = f_vals(:);
[min, i] = min(flatten) % 0.0036 always wins, it seems.


% TODO = take a point yielding 0.0036, and check how it does when inserted
% into each of g1, g2, g3.


% TODO = look at SOME of the cases we couldn't handle. What happened?!!!
%        Since aux is bounded, we should converge IMO!!!


% EASY TODO = figure out x0 from i.




