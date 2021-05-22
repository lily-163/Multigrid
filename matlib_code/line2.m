%clear all;
%clc;
%% 不算边界的

area = [0,1,0,1];
g1 = @(x,y)0*x.*y;
g4 = @(x,y)pi*x.*cos(pi*x.*y);
g={g1,g1,g1,g4};
g = f_g(g,area,h);
V = Prolongation_new(U64,g);
h = h/2;
n=1/h-1;

k = V(n*n+1:end);
V = V(1:n*n);


I = 2*speye(n,n)-sparse(2:n,1:n-1,1,n,n)-sparse(1:n-1,2:n,1,n,n);
D1 = speye(n,n);
D2 = sparse(1:n-1 ,2:n,1,n,n);
D3 = sparse(2:n,1:n-1,1,n,n);
matrix = kron(D1,I)-kron(D2,speye(n,n))-kron(D3,speye(n,n));


a = f_a(V);
b = f_b(V);

for i =1:size(matrix,1)
    matrix(i,i) = matrix(i,i)*(a(i)+b(i));
    if i < size(matrix,1)    % 把最后一行排除了
        matrix(i,i+1) = matrix(i,i+1)*a(i);
    end
    if i > 1
        matrix(i,i-1) = matrix(i,i-1)*a(i);
    end
    if i <= size(matrix,1)-n
        matrix(i,i+n) = matrix(i,i+n)*b(i);
    end
    if i>n
        matrix(i,i-n) = matrix(i,i-n)*b(i);
    end
end

f = @(x,y)-40*sin(3*pi*x).*exp(2*y); 
f = h^2*f_F(f,area,h);
f = f(1:n*n);
g1 = @(x,y)0*x.*y;
g4 = @(x,y)pi*x.*cos(pi*x.*y);
g={g1,g1,g1,g4};
g = f_g(g,area,h);
g1 = g(2:end-1,1);
g2 = g(1,2:end-1)';
g3 = g(2:end-1,end);

f(1:n:end) = f(1:n:end) + g1;
f(1:n) = f(1:n) + g2;
f(n:n:end) = f(n:n:end)+g3;
f(n*n-n+1:end) = f(n*n-n+1:end)+k;

U = matrix\f;
U_ = reshape(U,n,n)';
g(2:end-1,2:end-1) = U_;
g(end,2:end-1) = k';
[x,y] = meshgrid(0:h:1,0:h:1);
figure(1)
mesh(x,y,g);
title('128');

