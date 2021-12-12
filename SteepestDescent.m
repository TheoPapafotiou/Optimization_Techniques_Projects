function [min, k, points_x, points_y] = SteepestDescent(f, gradf, x0, y0, epsilon, gamma_method, gamma0, max_steps)
    
    k = 1;
    
    xk = [x0; y0];    
    syms x y
    x = xk(1);
    y = xk(2);
    points_x = x;
    points_y = y;
    
    gradValue = subs(gradf);
    
    switch gamma_method
        case 1
            
            gk = gamma0;
            
            while norm(gradValue) > epsilon && k <= max_steps
                dk = -gradValue;
                
                xk = round(double(xk + gk.*dk), 4);
                x = xk(1);
                y = xk(2);
                points_x = [points_x; x];
                points_y = [points_y; y];
                gradValue = subs(gradf);
                k = k + 1;
            end
            
            min = f(xk(1), xk(2));
            fprintf("Minimum is found at z = %1.3f\n", min);
            fprintf("Method finished in k = %d steps\n", k);
            fprintf("-------------------------------------\n\n");
      
        case 2
            
            syms gk
            
            while norm(gradValue) > epsilon && k <= max_steps
                dk = -gradValue;
                
                fmin(gk) = f(xk(1) + gk*dk(1), xk(2) + gk*dk(2));
                
                a0 = 0;
                b0 = 6;
                l = 1e-4;
                [gamma, ~, ~, ~, ~] = GoldenSection(a0, b0, fmin, l, 0, 0);
                
                xk = round(double(xk + gamma.*dk), 4);
                x = xk(1);
                y = xk(2);
                points_x = [points_x; x];
                points_y = [points_y; y];
                gradValue = subs(gradf);
                k = k + 1;
            end
            
            min = f(xk(1), xk(2));
            fprintf("Minimum is found at z = %1.3f\n", min);
            fprintf("Method finished in k = %d steps\n", k);
            fprintf("-------------------------------------\n\n");
            
        case 3
            
            mk = 0;
            a = 10e-2;
            b = 0.8;
            s = gamma0 * b^mk;
            gamma = gamma0;
            
            while norm(gradValue) > epsilon && k <= max_steps
                dk = -gradValue;
                
                xk_1 = round(double(xk + gamma.*dk), 4);
                
                while f(xk(1), xk(2)) - f(xk_1(1), xk_1(2)) < a*b^mk*s*dk'*dk
                    mk = mk + 1;
                end
                
                gamma = s*b^mk;
                
                xk = round(double(xk + gamma.*dk), 4);
                x = xk(1);
                y = xk(2);
                points_x = [points_x; x];
                points_y = [points_y; y];
                gradValue = subs(gradf);
                k = k + 1;
            end

            min = f(xk(1), xk(2));
            fprintf("Minimum is found at z = %1.3f\n", min);
            fprintf("Method finished in k = %d steps\n", k);
            fprintf("-------------------------------------\n\n");
            
    end
end

