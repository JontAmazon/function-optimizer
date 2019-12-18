%{
1. Do task 1 (main.m) -- unconstrained problem
    Minimize rosenbrock.m... Try many different starting points.

2. Do task 2 (main2.m) -- penalty.

3a. Do task 3 exercise 9.3 (main3a.m) -- penalty.

3b. Do task 3 exercise 9.5 (main3b.m) -- barrier.


EVEV:

10. (Probably not):
    Implement "Modified Newton", i.e. checking that D is P.D. and
    implementing a function that does D=D+epsilon*I for a series of
    incrementing epsilons until (and a bit more) D is P.D.
    ...BUT
        % According to p. [82] they should be, so Idk if should check
        % this and doing (D=D+epsilon*I) for incrementing epsilons when not.
        % Rosenbrock, x0=[200;200] ==> D was NOT pos. def. 15/5000 times.

    % wait... "should be"? I'm gonna go to the exercise now and ask...

%}

