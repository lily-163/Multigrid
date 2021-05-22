% 选择初始值
clear all;
n = 16;
h = 1/n;
area=[0,1,0,1];
f = @(x,y) -40*sin(5*pi*x).*exp(4*y); 
g1 = @(x,y)0*x.*y;
g = {g1,g1,g1};  
n = 1/h;
U = ones(n*n-n,1)/2;
U((n-1)*(n-1)+1:end) = zeros(n-1,1);  %将边界处可能出现不可微点的值都设置为并不可微
g_1 = f_g(g,area,h); 
f_1 = f_F(f,area,h);
[U,r] = Smooth_two(U,f_1,g_1,h,1e-5);
U = Prolongation_new(U,g_1);

h=h/2;
g_1 = f_g(g,area,h); 
f_1 = f_F(f,area,h);
[U,r] = Smooth_two(U,f_1,g_1,h,1e-5);
 
g_1 = f_g(g,area,h); 
U = Prolongation_new(U,g_1);

