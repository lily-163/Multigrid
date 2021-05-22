function [U,h,r] = C_M_two_nw(U,f,area,g,h,eps)
    while 1
        f_ = f_F(f,area,h);
        g_ = f_g(g,area,h);
        [U,r] = Smooth_two(U,f_,g_,h,(1e-5));
        if h < eps
            break;
        else
            U = Prolongation_new(U,g_);
            U = pro_zero(U);
            h = h/2;
        end
    end
end