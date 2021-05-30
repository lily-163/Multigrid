%插值函数，将误差从粗网格传递给细网格
function r = Prolongation_two(R)
    m = floor(sqrt(length(R)));
    n = m+1;
    R_ = zeros(n+1,m+2);
    R_(2:end,2:end-1) = reshape(R,m,n)';
    n = 2*(n+1)-1;
    m = 2*(m+2)-1;
    r = zeros(n,m);
    %细分后点重合部分
    for i =1:2:n
        for j = 1:2:m
                r(i,j) = R_((i+1)/2,(j+1)/2);
        end
    end
    
    for i = 2:2:n-1
        for j = 1:2:m
            r(i,j) = (R_(i/2,(j+1)/2)+R_(i/2+1,(j+1)/2))/2;
        end
    end
    
    for i = 1:2:n
        for j = 2:2:m-1
            r(i,j) = (R_((i+1)/2,j/2)+R_((i+1)/2,j/2+1))/2;
        end
    end
    for i = 2:2:n-1
        for j = 2:2:m-1
            r(i,j) = (R_(i/2,j/2)+R_(i/2+1,j/2)+R_(i/2,j/2+1)+R_(i/2+1,j/2+1))/4;
        end
    end
    r = r(2:end,2:end-1)';
    r = r(:);
end