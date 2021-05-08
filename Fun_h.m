function F = Fun_h(U,f,g,h)
    %只考虑有上边界是第二类边界；
    g1 = g(2:end,1);
    g2 = g(1,2:end-1);
    g3 = g(2:end,end);
    n = length(g1);
    m = length(g2);
    F = zeros(n*m,1);
    for i=1:1:n
        for j = 1:m
            t = (i-1)*m+j;
            if i == 1 
                if j==1   %左端点
                    F(t)= f_a(U(t))*(2*U(t)-U(t+1)-g1(i)) + f_b(U(t))*(2*U(t)-U(t+m)-g2(j))-(h^2)*f(t);
                    %disp(1);
               
                elseif j>1 && j<m   %下边界  
                    F(t)= f_a(U(t))*(2*U(t)-U(t-1)-U(t+1)) + f_b(U(t))*(2*U(t)-U(t+m)-g2(j))-(h^2)*f(t);
                    %disp(2);
               
                elseif j==m  %右下端点
                    F(t)= f_a(U(t))*(2*U(t)-U(t-1)-g3(i)) + f_b(U(t))*(2*U(t)-U(t+m)-g2(j))-(h^2)*f(t);
                    %disp(3);
                end
           
            elseif i>1 && i<n
                if j==1  %左边界
                    F(t)= f_a(U(t))*(2*U(t)-U(t+1)-g1(i)) + f_b(U(t))*(2*U(t)-U(t-m)-U(t+m))-(h^2)*f(t);
                    %disp(4);
               
                elseif j>1 && j<m %中间完整 
                    F(t) = f_a(U(t))*(2*U(t)-U(t-1)-U(t+1)) + f_b(U(t))*(2*U(t)-U(t-m)-U(t+m))-(h^2)*f(t);
                    %disp(5);
              
                elseif j==m  %右边界
                    F(t)= f_a(U(t))*(2*U(t)-U(t-1)-g3(i)) + f_b(U(t))*(2*U(t)-U(t-m)-U(t+m))-(h^2)*f(t);
                    %disp(6);
                end
            
            elseif i==n %左上端点
                if j == 1
                    if length(f_h(U,t))==2
                        lambda0 = rand(1);
                        [u,lambda] = Lagrange(U,t,m,g1,g3,lambda0,h,1,f(t));
                        F(t) = f_a(U(t))*(2*U(t)-U(t+1)-g1(i))+f_b(U(t))*2*(U(t)-U(t-m)-h*lambda)-(h^2)*f(t);
                    else
                        F(t) = f_a(U(t))*(2*U(t)-U(t+1)-g1(i))+f_b(U(t))*2*(U(t)-U(t-m)-h*f_h(U,t))-(h^2)*f(t);
                    end
                elseif j >1 && j<m
                    if length(f_h(U,t))==2
                        lambda0 = rand(1);
                        [u,lambda] = Lagrange(U,t,m,g1,g3,lambda0,h,2,f(t));
                        F(t) = f_a(U(t))*(2*U(t)-U(t+1)-U(t-1))+f_b(U(t))*2*(U(t)-U(t-m)-h*lambda)-(h^2)*f(t);
                    else
                        F(t) = f_a(U(t))*(2*U(t)-U(t+1)-U(t-1))+f_b(U(t))*2*(U(t)-U(t-m)-h*f_h(U,t))-(h^2)*f(t);
                    end
                elseif j == m
                    if length(f_h(U,t))==2
                        lambda0 = rand(1);
                        [u,lambda] = Lagrange(U,t,m,g1,g3,lambda0,h,3,f(t));
                        F(t) = f_a(U(t))*(2*U(t)-g3(i)-U(t-1))+f_b(U(t))*2*(U(t)-U(t-m)-h*lambda)-(h^2)*f(t);
                    else                       
                        F(t) = f_a(U(t))*(2*U(t)-U(t-1)-g3(i))+f_b(U(t))*2*(U(t)-U(t-m)-h*f_h(U,t))-(h^2)*f(t);
                    end
                end
            end
        end
    end
end