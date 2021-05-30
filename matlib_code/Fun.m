function F = Fun(U,f,g,h)
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
                    F(t)= f_a((U(t)+U(t+1))/2)*(U(t)-U(t+1)) + f_a((U(t)+g1(i))/2)*(U(t)-g1(i))...
                        + f_b((U(t)+U(t+m))/2)*(U(t)-U(t+m)) + f_b((U(t)+g2(j))/2)*(U(t)-g2(j))-h^2*f(t);
               
                elseif j>1 && j<m   %下边界  
                    F(t)= f_a((U(t)+U(t+1))/2)*(U(t)-U(t+1)) + f_a((U(t)+U(t-1))/2)*(U(t)-U(t-1))...
                        + f_b((U(t)+U(t+m))/2)*(U(t)-U(t+m)) + f_b((U(t)+g2(j))/2)*(U(t)-g2(j))-h^2*f(t);
               
                elseif j==m  %右下端点
                    F(t)= f_a((U(t)+g3(i))/2)*(U(t)-g3(i)) + f_a((U(t)+U(t-1))/2)*(U(t)-U(t-1))...
                        + f_b((U(t)+U(t+m))/2)*(U(t)-U(t+m)) + f_b((U(t)+g2(j))/2)*(U(t)-g2(j))-h^2*f(t);
                end
           
            elseif i>1 && i<n
                if j==1  %左边界
                    F(t)= f_a((U(t)+U(t+1))/2)*(U(t)-U(t+1)) + f_a((U(t)+g1(i))/2)*(U(t)-g1(i))...
                        + f_b((U(t)+U(t+m))/2)*(U(t)-U(t+m)) + f_b((U(t)+U(t-m))/2)*(U(t)-U(t-m))-h^2*f(t);
               
                elseif j>1 && j<m %中间完整 
                    F(t)= f_a((U(t)+U(t+1))/2)*(U(t)-U(t+1)) + f_a((U(t)+U(t-1))/2)*(U(t)-U(t-1))...
                        + f_b((U(t)+U(t+m))/2)*(U(t)-U(t+m)) + f_b((U(t)+U(t-m))/2)*(U(t)-U(t-m))-h^2*f(t);
              
                elseif j==m  %右边界
                    F(t)= f_a((U(t)+g3(i))/2)*(U(t)-g3(i)) + f_a((U(t)+U(t-1))/2)*(U(t)-U(t-1))...
                        + f_b((U(t)+U(t+m))/2)*(U(t)-U(t+m)) + f_b((U(t)+U(t-m))/2)*(U(t)-U(t-m))-h^2*f(t);
                end
            
            elseif i==n %左上端点
                if j == 1
                    lambda = f_h(U(t));
                    if length(lambda) == 2
                        lambda = Lagrange(U,t,m,g1(i),g3(i),lambda,h,1,f(t));
                    end
                    q = U(t-m)-2*h*lambda;
                    F(t)= f_a((U(t)+U(t+1))/2)*(U(t)-U(t+1)) + f_a((U(t)+g1(i))/2)*(U(t)-g1(i))...
                        + f_b((U(t)+q)/2)*(U(t)-q) + f_b((U(t)+U(t-m))/2)*(U(t)-U(t-m))-h^2*f(t);
                elseif j >1 && j<m
                    lambda = f_h(U(t));
                    if length(lambda) == 2
                        lambda = Lagrange(U,t,m,g1(i),g3(i),lambda,h,2,f(t));
                    end
                    q = U(t-m)-2*h*lambda;
                    F(t)= f_a((U(t)+U(t+1))/2)*(U(t)-U(t+1)) + f_a((U(t)+U(t-1))/2)*(U(t)-U(t-1))...
                        + f_b((U(t)+q)/2)*(U(t)-q) + f_b((U(t)+U(t-m))/2)*(U(t)-U(t-m))-h^2*f(t);
                elseif j == m
                    lambda = f_h(U(t));
                    if length(lambda) == 2
                        lambda = Lagrange(U,t,m,g1(i),g3(i),lambda,h,3,f(t));
                    end
                    q = U(t-m)-2*h*lambda;
                    F(t)= f_a((U(t)+g3(i))/2)*(U(t)-g3(i)) + f_a((U(t)+U(t-1))/2)*(U(t)-U(t-1))...
                        + f_b((U(t)+q)/2)*(U(t)-q) + f_b((U(t)+U(t-m))/2)*(U(t)-U(t-m))-h^2*f(t);
                end
            end
        end
    end
end