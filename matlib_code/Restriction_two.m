function R = Restriction_two(r,area,h,g_)
    m = (area(4) - area(3))/h - 1; %左右两边界固定 故少一列
    n = (area(2) - area(1))/h;
    r_ = zeros(n+1,m+2);
    for i=2:1:n+1
        r_(i,2:end-1) = r((i-2)*m+1:(i-1)*m)';
    end
    n = (n+1+1)/2;
    m = (m+2+1)/2;
    R = zeros(n,m);
    for i =2:n-1
        for j = 2:m-1
            R(i,j) = (r_(2*i,2*j-1)+r_(2*i-2,2*j-1)+r_(2*i-1,2*j)+r_(2*i-1,2*j-2)+4*r_(2*i-1,2*j-1))/8;
        end
    end
    i = n;
    for j = 2:m-1
        R(i,j) = (r_(2*i-1,2*j)+r_(2*i-1,2*j-2)+2*r_(2*i-2,2*j-1)+4*r_(2*i-1,2*j-1)+2*h*g_(2*i-1,2*j-1))/8;
    end
    R = R(2:end,2:end-1);
    R = R(:);
end