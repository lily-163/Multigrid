function U_true = f_T(g,area,h)
    x = area(1):h:area(2);
    y = area(3):h:area(4);
    [xx,yy] = meshgrid(x,y);
    U_true = g{1}(xx,yy);
    U_true = U_true(2:end,2:end-1)';
    U_true = U_true(:);
end