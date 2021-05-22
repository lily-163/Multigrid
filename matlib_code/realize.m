clear all;
t0 = tic;
n =4;
h = 1/n;
area=[0,1,0,1];
f = @(x,y) -40*sin(3*pi*x).*exp(4*y); 
g1 = @(x,y)0*x.*y;
g = {g1,g1,g1};  
n = 1/h;
U = ones(n*n-n,1)/1.5;
U((n-1)*(n-1)+1:end) = zeros(n-1,1);  %���߽紦���ܳ��ֲ���΢���ֵ������Ϊ������΢
  
f_1 = f_F(f,area,h);
g_1 = f_g(g,area,h); 

%[U,r] = Smooth_two(U,f_1,g_1,h,1e-5); 
%[U,r] = V_Cycle(U,f, area,g,h,1);
[U,h,r] = C_M_two_nw(U,f,area,g,h,0.13);
t1=toc(t0);

n = floor(sqrt(length(U)));
x = 0:h:1;
y = 0:h:1;
[xx,yy]=meshgrid(x,y); 
t = reshape(U,n,n+1)';
U = f_g(g,area,h); 
U(2:end,2:end-1) = t;

% file = ['new����3\UC',num2str(n+1),'.mat'];
% save(file,'U');
% file = ['new����3\rC',num2str(n+1),'.mat'];
% save(file,'r');
% file = ['new����3\tC',num2str(n+1),'.mat'];
% save(file,'t1');