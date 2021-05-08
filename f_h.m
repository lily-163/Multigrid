function h = f_h(U,t)
    if U(t) < -0.001
        h = 0;
    elseif U(t)>=-0.001 && U(t)<=0.001
        h = [0,0.1];
    else
        h = (0.5*exp(-0.5*U(t))+0.5)./10;
    end
end
