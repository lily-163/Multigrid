function [U,r]= Smooth_two(U,f,g,h,eps)
    % U： 展开成一列的代求未知数
    % f： 自由项的展开值
    % g： 固定边界的展开值
    n = floor(sqrt(length(U)));
    D = eye(length(U));
    r = [];
    sprintf('n=:%d',n)
    for iter = 1:15000
        fk = (Fun(U,f,g,h));
        dk = -D*fk;
        lambda = 1;
        isdone = 0;
        convg = 0;
        while isdone == 0
            U1 = U + lambda * dk;
            fk_ = (Fun(U1,f,g,h));
            if norm(fk_,2) < norm(fk,2)
                isdone = 1;
            else
                lambda = lambda/2;
                if lambda < 0.00001
                    disp('search fail');
                    sprintf('iter=%d',iter)
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
        D = (eye(length(U))-(sk*yk')/(yk'*sk))*D*(eye(length(U))-(yk*sk')/(yk'*sk))+(sk*sk')/(yk'*sk);
        r = [r,err];
        disp(iter);
        disp(err);
    end
end