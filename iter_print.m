function [] = iter_print(iter,x,p,f_x,norm_grad,ls_iters,lambda)

fprintf('%12.4f %12.1f %12.4f\n',a,b,c);
if length(x)>1
    fprintf('%12.4f %12.1f %12.4f %12.4f %12.4f %12.4f %12.4f\n',...
        iter,x(1),p,f_x,norm_grad,ls_iters,lambda),
    for dim = 2:length(x)
        fprintf('%12.4f %12.1f %12.4f %12.4f %12.4f %12.4f %12.4f\n',...
        iter,x(1),p,f_x,norm_grad,ls_iters,lambda);
    end
end

          
