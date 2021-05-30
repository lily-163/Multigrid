function u = Down(U)
    u = [];
    n = floor(sqrt(length(U)));
    for i = 1:n+1
        u = [u;U((i-1)*n+1:i*n)'];
    end
    u = u(2:2:end,2:2:end-1)';
    u=u(:);
end