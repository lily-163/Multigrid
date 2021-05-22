function [u,lambda] = Lagrange(U,num,m,g1,g3,lambda0,h,loc,f)
    u0 = U(num);
    alpha = 0.001;
    lambda1 = max(-1,min(1,lambda0+alpha*u0));
    if loc==2
        while 1
            u1 = Newton(u0,U(num-1),U(num+1),U(num-m),lambda1,f,h);
            lambda1 = max(-1,min(1,lambda0+alpha*u0));
            if abs(u1-u0) < 1e-5
                u = u1;
                lambda = lambda1;
                break
            else 
                u0=u1;
                lambda0 = lambda1;
            end
        end
    elseif loc==1
        while 1
            u1 = Newton(u0,g1(end),U(num+1),U(num-m),lambda1,f,h);
            lambda1 = max(-1,min(1,lambda0+alpha*u0));
            if abs(u1-u0) < 1e-5
                u = u1;
                lambda = lambda1;
                break
            else 
                u0=u1;
                lambda0 = lambda1;
            end
        end
    elseif loc == 3
        while 1
            u1 = Newton(u0,U(num-1),g3(end),U(num-m),lambda1,f,h);
            lambda1 = max(-1,min(1,lambda0+alpha*u0));
            if abs(u1-u0) < 1e-5
                u = u1;
                lambda = lambda1;
                break
            else 
                u0=u1;
                lambda0 = lambda1;
            end
        end
    end
end


