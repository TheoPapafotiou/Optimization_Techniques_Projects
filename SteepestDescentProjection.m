function [min, k, points_x, points_y] = SteepestDescentProjection(f, gradf, x0, y0, epsilon, sk, gamma0, X, max_steps)
    
    k = 1;
    
    xk = [x0; y0];    
    syms x y
    x = xk(1);
    y = xk(2);
    points_x = x;
    points_y = y;
   
    gradValue = subs(gradf);
    
    gk = gamma0;
    
    D = xk - sk.*gradValue;
        
    proj = zeros(2, 1);
    for i = 1:2
        if D(i) <= X(i, 1)
            proj(i) = X(i, 1);
        elseif D(i) >= X(i, 2)
            proj(i) = X(i, 2);
        else
            proj(i) = D(i);
        end
    end
    
    
    while norm(xk - proj) > epsilon && k < max_steps
        
        xk = round(double(xk + gk.*(proj - xk)), 4);
        
        x = xk(1);
        y = xk(2);
        gradValue = subs(gradf);
        D = xk - sk.*gradValue;
        
        proj = zeros(2, 1);
        for i = 1:2
            if D(i) <= X(i, 1)
                proj(i) = X(i, 1);
            elseif D(i) >= X(i, 2)
                proj(i) = X(i, 2);
            else
                proj(i) = D(i);
            end
        end
       
        points_x = [points_x; x];
        points_y = [points_y; y];

        k = k + 1;
    end

    min = f(xk(1), xk(2));
    fprintf("Minimum is found at z = %1.3f\n", min);
    fprintf("Method finished in k = %d steps\n", k);
    fprintf("-------------------------------------\n\n");
            
end

