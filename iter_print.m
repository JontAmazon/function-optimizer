function iter_print(iter,x,step_size,f_val,norm_grad,ls_iters,lambda)

fprintf('%12s %12s %12s %12s %12s %12s %12s\n',...
        'iter', 'x', 'step size', 'f(x)', '||grad||', 'ls_iters', 'lambda')
    
fprintf('%12.0f %12.4f %12.3f %12.4f %12.2f %12.0f %12.3f\n',...
        iter,x(1),step_size,f_val,norm_grad,ls_iters,lambda)

if length(x)>1
    for i = 2:length(x)
        fprintf('%12.4s %12.3f\n', ...
        ' ', x(i));
    end
end
end