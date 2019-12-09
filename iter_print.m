function iter_print(iter,x,p,f_x,norm_grad,ls_iters,lambda)

fprintf('%12.4f %12.1f %12.4f %12.4f %12.4f %12.4f %12.4f\n',...
        'iteration', 'x','step size')
if length(x)>1
    fprintf('%12.4f %12.1f %12.4f %12.4f %12.4f %12.4f %12.4f\n',...
        iter,x(1),p,f_x,norm_grad,ls_iters,lambda),
    for dim = 2:length(x)
        fprintf('%12.4f %12.1f %12.4f %12.4f %12.4f %12.4f %12.4f\n',...
        '',x(dim),'','','','','');
    end
end

disp('\n')
end

          
