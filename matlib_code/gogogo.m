t0 = tic;
n = 64;
h = 1/n;
area=[0,1,0,1];
f = @(x,y) -40*sin(3*pi*x).*exp(2*y); 
g1 = @(x,y)0*x.*y;
g = {g1,g1,g1};  
n = 1/h;
% U = ones(n*n-n,1)/3;
% U((n-1)*(n-1)+1:end) = zeros(n-1,1);  %将边界处可能出现不可微点的值都设置为并不可微

f_1 = f_F(f,area,h);
g_1 = f_g(g,area,h); 
[U1k,r] = Smooth_two(U,f_1,g_1,h,1e-2); 

U20 = Down(U1k);


h=2*h;
f_2 = f_F(f,area,h);
g_2 = f_g(g,area,h); 
[U2k,r] = Smooth_two(U20,f_2,g_2,h,1e-5);

U30 = Down(U2k);

h=2*h;
f_3 = f_F(f,area,h);
g_3 = f_g(g,area,h); 
[U3k,r] = Smooth_two(U30,f_3,g_3,h,1e-5);

h=h/2;
e2 = Prolongation_two(U3k-U30);
U2k0 = U2k+e2;
[U2kk,r] = Smooth_two(U2k0,f_2,g_2,h,1e-5);
 
h=h/2;
e1 = Prolongation_two(U2kk-U20);
U1k0 = U1k + e1;
[U,r] = Smooth_two(U1k0,f_1,g_1,h,1e-5);


