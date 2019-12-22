% Solve task 2 (penalty problem).
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
mu = [1e1 1e2 1e3 1e4 1e5 1e6];
x = [-2 2 2 -1 -1]';
%x = [-3 0 -3 0 0]';
%x = [0 -3 0 0 0]';   %"95"
%x = [0 0 0 -3 3]';   %"120"

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

We got three different results. They are each a local minimum.
x0 = [-2 2 2 -1 -1]' -->   x = [-1.7171 1.8272 1.5957 -0.7636 -0.7636]'    f_min = 0.0539
x0 = [-3 -3 -3 -3 -3]' --> x = [-0.6991 -2.7899 -0.8700 -0.6967 -0.6967]'  f_min = 0.4389
x0 = [-1 -1 -1 0 0]'   --> x = [-3 -1 0 0 0]'                              f_min = 1
%}
%{
2. Compare DFP and BFGS and different tolerances. Convergence?  :)
For this question, let's use statistics the automated tests below.


%}


%_________________________________________________________________________
% Automated tests with MANY starting points.
%_________________________________________________________________________
%
vals = [-3 0 3]; %values that each of x1...x5 will take.
n = length(vals);
f_vals = zeros(n^5, 1);    %our objective values.
f_vals2 = zeros(n^5, 1);   %fmincon obje. values.
error_counter = 0;         %linesearch errors.
error_counter_i = zeros(n^5, 1); %what mu it failed on.
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
    x0_vals(index, :) = x;
    x2 = x; %fmincon
    
    no_error = 1;
    for i = 1:length(mu)
        aux = @(x) f(x) + mu(i)*alpha(x); 
        %[x2, ~, exit] = fmincon(aux, x2);
        try
            x = nonlinearmin(aux, x, 'BFGS', 1e-2, 0);
        catch
            no_error = 0;
            error_counter = error_counter + 1;
            error_counter_i(index) = i;
            break;
        end
    end
    
    %Store results.
    %exit_flag(index) = exit;
    %f_vals2(index) = f_original(x2);
    if (no_error)
        f_vals(index) = f_original(x);
    else
        f_vals(index) = 99999999; %represents error.
    end
end
end
end
end
end
[min, i] = min(f_vals);
convergence_rate = 1 - (error_counter / length(f_vals))

%}

%{
[CONVERGENCE PROBLEM DISCUSSION]
This problem was by far the most difficult one, and we spent hours trying
to manage all cases. For a long time we only managed a convergence rate of
~75%. The remaining 25% triggered the provided linesearch errors, but, it
was really a problem of stopping criteria. By debugging we found that all
values had reasonable size, then all of a sudden linesearch generated an
incredibly small lambda, say 1e-20. The problem was that we were in a local
minimum(*), but had nevertheless not converged. Then, either d was not a
descent direction (error: 'f increased'), or a very small lambda was
returned, causing NaN values for the next iteration (error: 'f diverged').
    (*)We realized that we were in a local optimum, since f was 1 (known
local min) and grad(aux,y) was close to zero, say 1e-4. Then we tried
increasing the tolerance, which was usually kept around 1e-6 or 1e-8. It
helped, but of course, the tolerance should not be too big.
    It helped to use one more stopping condition, INSIDE the inner
for-loop. The added condition was to stop the solver if the step size was
smaller than a certain step size tolerance, say 1e-10. Then, we achieved a 
95% convergence rate (for a tolerance of 1e-8). If the step size tolerance
was increased to 1e-6, a 100% convergence rate was achieved. But once
again, the tolerance should not be too big, and for this last experiment,
this was noted. While all of the results were near of one of the three
local minimum points (0.0539, 0.4389 or 1), some values near 1 were
slightly off, e.g. ~0.99. This seems to be a "tough" local minimum point
compared to the others.
%}
