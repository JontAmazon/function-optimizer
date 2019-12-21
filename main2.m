% Solve task 2 (penalty problem).
% This script 
clear all
close all

%_________________________________________________________________________
%___________________  PROBLEM  ___________________________________________
f_original = @(x) exp((x(1)*x(2)*x(3)*x(4)*x(5)));
% TRICK: Minimize exponent instead. OK since exp(x) monotone function.
%        But then start with large mu, since unconstrained objective
%        function would be unbounded.
f = @(x) x(1)*x(2)*x(3)*x(4)*x(5);
h1 = @(x) abs(x(1)^2 + x(2)^2 + x(3)^2 + x(4)^2 + x(5)^2 - 10); % ==> |x_i| < sqrt(10)
h2 = @(x) abs(x(2)*x(3) - 5*x(4)*x(5));
h3 = @(x) abs(x(1)^3 + x(3)^3 + 1);
alpha = @(x) h1(x)^2 + h2(x)^2 + h3(x)^2; %EV ^3.
%(auxiliary function is defined in the for loop).

%_________________________________________________________________________
%___________________  SOLVER  ____________________________________________
mu = [1e1]; % 1e2 1e3 1e4 1e5];
x = [-2 2 2 -1 -1]';
%x = [-3 0 -3 0 0]';
%x = [0 -3 0 0 0]';   %"95"
x = [0 0 0 -3 3]';   %"120"

x1 = x; %our solver
x2 = x; %fmincon (to compare with)
for i = 1:length(mu)
    muuuuu = mu(i); %for debugging.
    aux = @(x) f(x) + mu(i)*alpha(x);    
    x1 = nonlinearmin(aux, x1, 'BFGS', 1e-6, 0);
    %x2 = fmincon(aux, x2);
end
f1 = f_original(x1);
f2 = f_original(x2);
%_________________________________________________________________________
%___________________  RESULTS  ___________________________________________
%{
1. Find starting points yielding different results. Explain what happens.
Parameters: [BFGS, 1e-6,  and  mu = [1e1 1e2 1e3 1e4 1e5 1e6]].

There are three different local minimum. Last one is stationary point.
x0 = [-2 2 2 -1 -1]' -->   x = [-1.7171 1.8272 1.5957 -0.7636 -0.7636]'    f_min = 0.0539
x0 = [-3 -3 -3 -3 -3]' --> x = [-0.6991 -2.7899 -0.8700 -0.6967 -0.6967]'  f_min = 0.4389
x0 = [-1 -1 -1 0 0]'   --> x = [-3 -1 0 0 0]'                              f_min = 1
%}
%{
2. Compare DFP and BFGS and different tolerances. Convergence?  :)
For this question, let's use statistics the automated tests below.

... (TODO)

%}


%_________________________________________________________________________
% Automated tests with MANY starting points.
%_________________________________________________________________________
%
vals = [-3 0 3]; %values that each of x1...x5 will take.
n = length(vals);
f_vals = zeros(n^5, 1);    %our objective values.
f_vals2 = zeros(n^5, 1);   %fmincon obje. values.
didnt_converge = 0;        %our fail counter.  ca 30% when vals = [-3 1.5 0 1.5 3].   TODO sen = update.
didnt_converge_i = zeros(n^5, 1); %what mu it failed on.
exit_flag = zeros(n^5, 1); %fmincon exit flag.
x0_vals = zeros(n^5, 5);   %start values.

index = 0;
for a = 1:n
for b = 1:n
for c = 1:n
for d = 1:n
for e = 1:n
    index = index + 1;
    x = [vals(a); vals(b); vals(c); vals(d); vals(e)];
    x2 = x; %fmincon
    
    converged = 1;
    for i = 1:length(mu)
        aux = @(x) f(x) + mu(i)*alpha(x); 
        %x2 = [0 0 0 0 0]';
        %exit = 1;
        [x2, ~, exit] = fmincon(aux, x2);
        try
            x = nonlinearmin(aux, x, 'BFGS', 1e-6, 0);
        catch
            converged = 0;
            didnt_converge = didnt_converge + 1;
            didnt_converge_i(index) = i;
            break;
        end
    end
    
    %Store results.
    exit_flag(index) = exit;
    f_vals2(index) = f_original(x2);
    if (converged)
        f_vals(index) = f_original(x);
    else
        f_vals(index) = Inf; %Inf represents not converged.
    end
    x0_vals(index, 1) = vals(a);
    x0_vals(index, 2) = vals(b);
    x0_vals(index, 3) = vals(c);
    x0_vals(index, 4) = vals(d);
    x0_vals(index, 5) = vals(e);
end
end
end
end
end
[min, i] = min(f_vals);
sad_rate = didnt_converge / length(f_vals) %percentage not converge
%}

%{
[CONVERGENCE PROBLEM DISCUSSION]
This problem was by far the most difficult one, and we spent hours trying
to manage all cases, but in the end the best convergence rate we managed
was 90%. The remaining 10% triggered the provided linesearch errors, but,
we rather see it as a problem of stopping criteria. By debugging we found
that the following happened:
    All values had reasonable size until just before it crashed in
linesearch. The problem was that we were in a local optimum(*). Thus, the
direction was not a descent direction, and linesearch, requiring 
F(lamb) < F(0), looped until lambda was reduced to ~1e-20. Still, it was
not a descent direction and an error was triggered: F(lamb) > F(0).
Alternatively, lambda had become so small that F(lamb)==F(0), not
triggering the first warning but instead the second: isnan(f(x+lamb*d)),
since the product lamb*d was equal to NaN.

EV:
    We improved the convergence rate by also searching in the 
    direction (-d) when lambda was smaller than 1e-12,
    But as we said, we were in a local minimum, so...
        Hmm... not explored fully what happened... It continued for more
        iterations??? (EV TODO).  men b?ttre att ba l?mna in --> f?
        feedback.

(*) We could see that we were in a local optimum, since f was 1 and 
grad(aux,y) = 0. However, ||grad|| was a bit larger than the stopping
tolerance.
EV:
    This sounds easy to fix. We tried but failed.
    - Increasing tol caused it to stop in the next problem (with a larger mu)
    instead.
    - We tried stopping conditions INSIDE the inner for-loop. Then what
    happened?
%}


