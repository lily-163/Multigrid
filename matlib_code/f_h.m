function h = f_h(U)
    if U < -0.001
        h = 0;
%         h = -0.5*exp(0.5*U)+0.5;
    elseif U>=-0.001 && U<=0.001
        h = [0,0.1];
    else
        h = 0.1*(0.5*exp(-0.5*U)+0.5);
    end
end
