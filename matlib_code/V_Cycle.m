function [U,r] = V_Cycle(U,f,area,g,h,n)
    g_ = f_g(g,area,h);
    f_ = f_F(f,area,h);
    U1 = Smooth_two(U,f_,g_,h,max(0.1*n,1e-5));
    U2 = Down(U1);
    if sqrt(length(U2))<6
        g_1 = f_g(g,area,2*h);
        f_1 = f_F(f,area,2*h);
        U_2k = Smooth_two(U2,f_1,g_1,2*h,(1e-5));
        e_2k = U_2k-U2;
        sprintf('最底层的个数:%d',sqrt(length(e_2k)));
    else
        U = V_Cycle(U2,f,area,g,2*h,n/10);
        e_2k=U-U2;
    end
    U1 = U1+Prolongation_two(e_2k);
    [U,r] = Smooth_two(U1,f_,g_,h,(1e-5)); 
end