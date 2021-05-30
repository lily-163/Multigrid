function u = Newton(u,left,right,down,lambda,f,h)
    q = down - 2*h*lambda;
    fk = f_a((u+right)/2)*(u-right) + f_a((u+left)/2)*(u-left) + f_b((u+q)/2)*(u-q)...
        + f_b((u+down)/2)*(u-down)-h^2*f;
    convg = 0;
    k = 0;
    while convg==0
        q = down-2*h*lambda;
        dfk = (f_a((u+right)/2)+ f_a((u+left)/2)+ f_b((u+down)/2)+ f_b((u+q)/2))...
            +0.5*(f_dfa((u+right)/2)*(u-right)+ f_dfa((u+left)/2)*(u-left)...
            + f_dfb((u+q)/2)*(u-q)+ f_dfb((u+down)/2)*(u-down));
        d = -fk/dfk;
        omega = 1;   %步长
        isdone = 0;
        while isdone==0
            u1 = u+omega*d;
            fk1 = f_a((u1+right)/2)*(u1-right) + f_a((u1+left)/2)*(u1-left)...
                + f_b((u1+q)/2)*(u1-q) + f_b((u1+down)/2)*(u1-down)-h^2*f;
            if norm(fk1)<norm(fk)
                isdone = 1;
            else
                omega = omega/2;
                 if omega<0.001
                    convg = -1;
                    %disp('一维搜索失败');
                    break;
                end
            end
        end
        u = u1;
        k=k+1;
        fk = fk1;
        if k>500
            convg = 1;
            disp('Lagrange不收敛');
        end     
    end
    %sprintf('k=%d',k)
end