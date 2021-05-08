function [U,r] = Smooth_two(U,f,g,h,eps)
    % U： 展开成一列的代求未知数
    % f： 自由项的展开值
    % g： 固定边界的值
    m = floor(sqrt(length(U)));
    D = sparse(eye(length(U)));
    r = [];
    for iter = 1:1500
        disp(iter);
        fk = (Fun_h(U,f,g,h));
        if norm(fk)<eps
            sprintf('1收敛的迭代次数iter=%d',iter)
            r = [r,err];
            disp(norm(fk,'inf'));
        end
        dk = -D*fk;
        lambda = 1;
        isdone = 0;
        convg = 0;
        while isdone == 0
            U1 = U + lambda * dk;
            fk_ = Fun_h(U1,f,g,h);
            if norm(fk_) < norm(fk)
                isdone = 1;
            else
                lambda = lambda/2;
                if lambda < 0.001
                    disp('search fail');
                    sprintf('iter=%d',iter)
                    sprintf('max_err=%f',err)
                    convg = 1;
                    break;
                end
            end
        end
        err = norm(U-U1,'inf');
        U = U1;
        if err<eps
            sprintf('收敛的迭代次数iter=%d',iter)
            r = [r,err];
            disp(norm(fk,'inf'));
            break;
        end
        if convg==1
            r = [r,err];
            break;
        end
        sk = lambda*dk; 
        yk = fk_ - fk;
        D = (sparse(eye(length(U)))-(sk*yk')/(yk'*sk))*D*(sparse(eye(length(U)))-(yk*sk')/(yk'*sk))+(sk*sk')/(yk'*sk);
        r = [r,err];
    end
end