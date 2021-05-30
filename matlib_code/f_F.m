function f_ = f_F(f,area,h)
    x = area(1):h:area(2);
    y = area(3):h:area(4);
    [xx,yy] = meshgrid(x,y);
    f_ = f(xx,yy);
    f_ = f_(2:end,2:end-1)';
    f_ = f_(:);
end