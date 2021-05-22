function U = pro_zero(U)
    m = floor(sqrt(length(U)));
    u = U(m*m+1:end);
    i = find(abs(u)==min(abs(u)));
    u(i) = 100;
    j = find(abs(u)==min(abs(u)));
    u([i,j]) = zeros(2,1);
    U(m*m+1:end)=u;
end