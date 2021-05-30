function h = f_h(u)
    if u<=-0.001
        h = 0;
    elseif u>-0.001 && u<0.001
        h = [-0.1,0];
    else
        h = 0.1*(-0.5*exp(-0.5*u)-0.5);
    end
end