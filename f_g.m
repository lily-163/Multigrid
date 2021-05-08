function g_ = f_g(g,area,h)
    x = area(1):h:area(2);
    y = area(3):h:area(4);
    [xx,yy] = meshgrid(x,y);
    g_ = zeros(size(xx));
    g_(1:end,1) = g{1}(xx(1,1),yy(1:end,1));
    g_(1,1:end) = g{2}(xx(1,1:end),yy(1,1));
    g_(1:end,end) = g{3}(xx(end,end),yy(1:end,1));
    %g_(end,1:end) = g{4}(xx(1,1:end),yy(end,end));
end