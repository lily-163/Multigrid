% 需要插值的时候取消注释
area = [0,1,0,1];
% h=1/64;
% n = 1/h-1;
% g1 = @(x,y)0*x.*y;
% g4 = @(x,y)pi*x.*cos(pi*x.*y);
% g={g1,g1,g1,g4};
% g1 = f_g(g,area,h);
% U = Prolongation_new(U,g1);
% h=h/2;
% n=1/h-1;
h=1/64;
n=1/h-1;
U = ones(n*n+n,1)/2;
U(n*n+1:end) = zeros(n,1); 
r = [];
for iter = 1:200
    V = U;
    I = 2*speye(n,n)-sparse(2:n,1:n-1,1,n,n)-sparse(1:n-1,2:n,1,n,n);
    D1 = speye(n+1,n+1);
    D2 = sparse(1:n,2:n+1,1,n+1,n+1);
    D3 = sparse(2:n+1,1:n,1,n+1,n+1);
    matrix = kron(D1,I)-kron(D2,speye(n,n))-kron(D3,speye(n,n));
    matrix(n*n+1:end,n*n-n+1:n*n) = 2*matrix(n*n+1:end,n*n-n+1:n*n);

    a = f_a(V(1:1:n*n+n));
    b = f_b(V(1:1:n*n+n));
    dfa = f_dfa(V(1:1:n*n+n));
    dfb = f_dfb(V(1:1:n*n+n));
 
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

    f = @(x,y)-40*sin(3*pi*x).*exp(4*y); 
    f = h^2*f_F(f,area,h);
    g1 = @(x,y)0*x.*y;
    g4 = @(x,y)pi*x.*cos(pi*x.*y);
    g={g1,g1,g1,g4};
    g = f_g(g,area,h);
    g1 = g(2:end,1);
    g2 = g(1,2:end-1)';
    g3 = g(2:end,end);

    g4 = V(n*n+1:end);
    m=n;
    for i =1:n
        if length(f_h(g4(i))) ==2 
            lambda = rand(1);
            disp("=======");
            t = n*n+i;
            if i==1  
                [u,lambda] = Lagrange(V,t,m,g1,g3,lambda,h,1,f(t));
            elseif i==n
                [u,lambda] = Lagrange(V,t,m,g1,g3,lambda,h,3,f(t));
            else
                [u,lambda] = Lagrange(V,t,m,g1,g3,lambda,h,2,f(t));
            end
            g4(i) = lambda;
        else
            g4(i) = f_h(g4(i));
        end 
    end
    f(1:n:end) = f(1:n:end) + g1;
    f(1:n) = f(1:n) + g2;
    f(n:n:end) = f(n:n:end)+g3;
    f(n*n+1:end) = f(n*n+1:end)+2*h*g4;

    U = matrix\f;
    if norm(U-V,'inf')<1e-5
        disp('iter');
        disp(iter);
        disp(norm(U-V,'inf'));
        r = [r,norm(U-V,'inf')];
        break
    end
    disp(norm(U-V,'inf'));
    r = [r,norm(U-V,'inf')];
    U_ = reshape(U,n,n+1)';
    g(2:end,2:end-1) = U_;
    [x,y] = meshgrid(0:h:1,0:h:1);
    figure(1)
    mesh(x,y,g);
%     pause(1);
end
    U_ = reshape(U,n,n+1)';
    g(2:end,2:end-1) = U_;
    [x,y] = meshgrid(0:h:1,0:h:1);
    figure(1)
    mesh(x,y,g);
    title('128');
    figure(2)
    
    plot(1:1:length(r),r,'b');
    xlabel('iter');
    ylabel('||u_{n+1}-u_n||_{\infty}');

%% 混合边界没有Clarke次微分
% % h = 1/500;
% n=1/h-1;
% area = [0,1,0,1];
% I = 4*speye(n,n)-sparse(2:n,1:n-1,1,n,n)-sparse(1:n-1,2:n,1,n,n);
% D1 = speye(n+1,n+1);
% D2 = sparse(1:n,2:n+1,1,n+1,n+1);
% D3 = sparse(2:n+1,1:n,1,n+1,n+1);
% matrix = kron(D1,I)-kron(D2,speye(n,n))-kron(D3,speye(n,n));
% matrix(n*n+1:end,n*n-n+1:n*n) = 2*matrix(n*n+1:end,n*n-n+1:n*n);
% 
% f = @(x,y)pi^2*sin(pi*x.*y).*(x.^2+y.^2);
% f = h^2*f_F(f,area,h);
% g1 = @(x,y)sin(pi*x.*y);
% g4 = @(x,y)pi*x.*cos(pi*x.*y);
% g={g1,g1,g1,g4};
% g = f_g(g,area,h);
% g1 = g(2:end,1);
% g2 = g(1,2:end-1)';
% g3 = g(2:end,end);
% x = 0:h:1;
% x = x(2:end-1);
% g4 = g4(x,1)';
% 
% f(1:n:end) = f(1:n:end) + g1;
% f(1:n) = f(1:n) + g2;
% f(n:n:end) = f(n:n:end)+g3;
% f(n*n+1:end) = f(n*n+1:end)+2*h*g4;

% U = matrix\f;
% U = reshape(U,n,n+1)';
% g(2:end,2:end-1) = U;
% [x,y] = meshgrid(0:h:1,0:h:1);
% mesh(x,y,g);


%% 第一类边界没有Clarke次微分
% h = 1/16;
% n=1/h-1;
% area = [0,1,0,1];
% I = speye(n,n);
% E = sparse(2:n,1:n-1,-1,n,n);
% D = E+E'+2*I;
% matrix = kron(D,I)+kron(I,D);
% 
% 
% f = @(x,y)pi^2*sin(pi*x.*y).*(x.^2+y.^2);
% f = f_F(f,area,h);
% f = h^2*f(1:n*n);
% g1 = @(x,y)sin(pi*x.*y);
% g={g1,g1,g1,g1};
% g = f_g(g,area,h);
% g1 = g(2:end-1,1);
% g2 = g(1,2:end-1)';
% g3 = g(2:end-1,end);
% g4 = g(end,2:end-1)';
% 
% f(1:n:end) = f(1:n:end) + g1;
% f(1:n) = f(1:n) + g2;
% f(n:n:end) = f(n:n:end)+g3;
% f(n*n-n+1:end) = f(n*n-n+1:end)+g4;
% 
% U = matrix\f;
% U = reshape(U,n,n)';
% g(2:end-1,2:end-1) = U;
% [x,y] = meshgrid(0:h:1,0:h:1);
% mesh(x,y,g);

