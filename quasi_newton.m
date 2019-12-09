function D = quasi_newton(method,p,q,D)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

if strcmpi(method, 'DFP') == 1
    D = D + (p*p')/(p'*q) - (D*q*q'*D)/(q'*D*q);
elseif strcmpi(method, 'BFGS') == 1
    D = D + (1+q'*D*q/(p'*q))*(p*p')/(p'*q) - (p*q'*D+D*q*p')/(p'*q);
end
end

