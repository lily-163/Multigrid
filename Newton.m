function u = Newton(u,left,right,down,lambda,f,h)
    fk = f_a(u)*(2*u-left-right)+f_b(u)*(2*u-2*down-2*h*lambda)-h^2*f;
    convg = 0;
    k = 0;
    while convg==0
        if norm(fk) < 0.001
            convg=-1;
            continue;
            %disp('Newton�����ɹ�');
        end
        dfk = f_dfa(u)*(2*u-left-right)+f_dfb(u)*(2*u-2*down-2*h*lambda)+2*(f_a(u)+f_b(u));
        d = -fk/dfk;
        omega = 1;   %����
        isdone = 0;
        while isdone==0
            u1 = u+omega*d;
            fk1 = f_a(u1)*(2*u1-left-right)+f_b(u1)*(2*u1-2*down-2*h*lambda)-h^2*f;
            if norm(fk1)<norm(fk)
                isdone = 1;
            else
                omega = omega/2;
                if omega<0.001
                    convg = -1;
                    %disp('һά����ʧ��');
                    break;
                end
            end
        end
        u = u1;
        fk = fk1;
        if k>500
            convg = 1;
            disp('Lagrange������');
        end     
    end
end