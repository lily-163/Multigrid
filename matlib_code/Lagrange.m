function lambda = Lagrange(U,t,m,g1,g3,lambda,h,loc,f)
    u0 = U(t);
    alpha = 0.01;
    a = lambda(1);
    b = lambda(2);
    lambda = a+rand(1)*(b-a);
    lambda0 = max(a,min(b,lambda+alpha*u0));
%     k = 1;
    if loc == 2
        while 1
%             k=k+1;
            u1 = Newton(u0,U(t-1),U(t+1),U(t-m),lambda0,f,h);
            lambda1 = max(a,min(b,lambda0+alpha*u1));
            if abs(lambda1-lambda0) < 1e-5
                lambda = lambda1;
                break;
            else
                u0 = u1;
                lambda0 = lambda1;
            end
        end
    elseif loc ==1
        while 1
            u1 = Newton(u0,g1,U(t+1),U(t-m),lambda0,f,h);
            lambda1 = max(a,min(b,lambda0+alpha*u1));
            if abs(lambda1-lambda0) < 1e-4
                lambda = lambda1;
                break;
            else
                u0 = u1;
                lambda0 = lambda1;
            end
        end
    else
        while 1
            u1 = Newton(u0,U(t-1),g3,U(t-m),lambda0,f,h);
            lambda1 = max(a,min(b,lambda0+alpha*u1));
            if abs(lambda1-lambda0) < 1e-4
                lambda = lambda1;
                break;
            else
                u0 = u1;
                lambda0 = lambda1;
            end
        end 
    end 
%     sprintf('k=%d',k)
end