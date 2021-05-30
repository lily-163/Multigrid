clear all;
t0=tic;
area = [0,1,0,1];
h = 1/64;
x = area(1):h:area(2);
y = area(3):h:area(4);
n = 1/h;
%f = @(x,y)pi^2*(x.^2+y.^2).*(sin(pi*x.*y)-cos(2*pi*x.*y));
f = @(x,y)-40*sin(3*pi*x).*exp(4*y); 
g1 = @(x,y)0*sin(pi*x.*y); 
g4 = @(x,y)-0*pi*x.*cos(pi*x.*y);
g={g1,g1,g1,g4};
U = ones(n*(n-1),1)./2.5 ;
U((n-1)^2+1:end) = zeros(n-1,1);
f_1 = f_F(f,area,h);
g_1 = f_g(g,area,h);
[U,r] = Smooth_two(U,f_1,g_1,h,1e-5);
%[U,r] = V_Cycle(U,f,area,g,h,1);
%[U,h,r] = C_M_two_nw(U,f,area,g,h,0.008);
t1=toc(t0);


n = floor(sqrt(length(U)));
U= reshape(U,n,n+1)';

x = area(1):h:area(2);
y = area(3):h:area(4);
[xx,yy] = meshgrid(x,y);

T =zeros(1/h+1);
T(2:end,2:end-1) = U; 

figure(1);
mesh(xx,yy,T); 
title('Èý²ãV\_CycleÄâÅ£¶Ù·¨-sin(¦Ðxy)(40µÈ·Ö)');
xlabel('x');ylabel('y');
zlabel('u');

file = ['ËãÀý3\U',num2str(n+1),'.mat'];
save(file,'T');
file = ['ËãÀý3\r',num2str(n+1),'.mat'];
save(file,'r');
file = ['ËãÀý3\t',num2str(n+1),'.mat'];
save(file,'t1');