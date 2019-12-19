% Check stopping conditions.
% a) tol1 > ||grad(f,x)||
% b) tol2 > ||x_k - x_k-1|| / ||x_k-1||
% c) tol3 > |f_k - f_k-1| / |f_k-1|
% d) tol4 > ||x_k - x_k-N||
% e) tol5 > |f_k - f_k-N|
function stop = check_stopping_conditions(f, x_history, tol)
[~, len] = size(x_history);
tol1 = tol;
tol2 = tol;
tol3 = tol;
tol4 = tol * 100;
tol5 = tol * 100;

stop = 0;

% a) tol1 > ||grad(f,x)||
x_k = x_history(:, len);
f_k = f(x_k);
if norm(grad(f,x_k)) < tol1
    %EV Check that D is pos. def.? But didn't seem needed from sin(x) test.
    stop = 1;
    disp('Local min found!    ||grad(f,x)|| < tol')
    %pause(3)
end

% b) tol2 > ||x_k - x_k-1|| / ||x_k-1||
if len > 1
    x_km1 = x_history(:, len-1);
    f_km1 = f(x_km1);
    if norm(x_k - x_km1) / norm(x_km1) < tol2
        stop = 1;
        disp('Local min found!    ||x_k - x_k-1|| / ||x_k-1|| < tol')
        %pause(3)
    end
end

% c) tol3 > |f_k - f_k-1| / |f_k-1|
if len > 1
    if abs(f_k - f_km1) / abs(f_km1) < tol3
        stop = 1;
        disp('Local min found!    |f_k - f_k-1| / |f_k-1| < tol')
        %pause(3)
    end
end

% d) tol4 > ||x_k - x_k-N||
N = 20;
if len > N
    x_kmN = x_history(:, len-N);
    f_kmN = f(x_kmN);
    if norm(x_k - x_kmN) < tol4
        stop = 1;
        disp('Local min found!    ||x_k - x_k-N|| < tol')
        %pause(3)
    end
end

% e) tol5 > |f_k - f_k-N|
if len > N
    if abs(f_k - f_kmN) < tol5
        stop = 1;
        disp('Local min found!    |f_k - f_k-N| < tol')
        %pause(3)
    end
end
end