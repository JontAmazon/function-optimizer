% Check stopping conditions.
% NTS: alternatives:
% a) tol1 > ||grad(f,x)||
% b) tol2 > ||x_k - x_k-N||
% c) tol3 > ||x_k - x_k-1|| / ||x_k-1||
% d) tol4 > |f_k - f_k-N|
% e) tol5 > |f_k - f_k-1| / |f_k-1|
function stop = check_stopping_conditions(f, x_k, x_km1, x_kmN, tol)
tol1 = tol;
tol2 = tol * 100;
tol3 = tol;
tol4 = tol * 100;
tol5 = tol;

% a) tol1 > ||grad||
if norm(grad(f,x)) < tol1
    [~, flag] = chol(D); %Necessary? Checking that D is pos. def. doesn't
    if flag == 0         %doesn't seem to be needed, from tries on sin(x)).
        return            
    end
end    





end