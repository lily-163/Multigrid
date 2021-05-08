function r = Prolongation_new(R,g)
    %对收敛解插值到细网格上，瀑布型多重网格中
    m = floor(sqrt(length(R)));
    n = m+1;
    R_ = g;
    for i =2:1:n+1
        R_(i,2:end-1) = R((i-2)*m+1:(i-1)*m)';
    end
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