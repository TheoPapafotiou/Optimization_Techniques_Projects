function [min, k, points_x, points_y] = LevMarq(f, gradf, hessf, x0, y0, epsilon, gamma_method, gamma0, max_steps)

    k = 1;
    xk = [x0; y0];

    syms x y
    x = xk(1);
    y = xk(2);
    points_x = x;
    points_y = y;

    gradValue = subs(gradf);
    hessfMatrix = subs(hessf);
    
    %% Require Positive Definites
    mk = abs(max(eig(hessfMatrix)));
    updatedHess = hessfMatrix + mk.*eye(size(hessfMatrix));
    while updatedHess(1,1) <= 0 || det(updatedHess) <= 0
       mk = mk + 0.1;
       updatedHess = hessfMatrix + mk.*eye(size(hessfMatrix));
    end

    switch gamma_method
        case 1
            gk = gamma0;

            while norm(gradValue) > epsilon && k <= max_steps
                
                if updatedHess(1,1) > 0 && det(updatedHess) > 0
                    dk = -inv(updatedHess)*gradValue;
                    xk_1 = round(double(xk + gk.*dk), 4);
                    
                    %% Check Criteria
                    flag = LevMarq_criteria(xk, xk_1, gk, dk, gradf, f);
                    if flag == 0
                        fprintf("Criteria not fulfilled in k = %d iteration!\n", k)
                        break;
                    else
                        xk = xk_1;
                    end
                    x = xk(1);
                    y = xk(2);
                    points_x = [points_x; x];
                    points_y = [points_y; y];
                    gradValue = subs(gradf);
                    hessfMatrix = subs(hessf);
                    
                    %% Require Positive Definites
                    mk = abs(max(eig(hessfMatrix)));
                    updatedHess = hessfMatrix + mk.*eye(size(hessfMatrix));
                    while updatedHess(1,1) <= 0 || det(updatedHess) <= 0
                       mk = mk + 0.1;
                       updatedHess = hessfMatrix + mk.*eye(size(hessfMatrix));
                    end
                    
                    k = k + 1;
                else
                    fprintf("The hessian matrix is not positive definite!\n");
                    break;
                end
            end

            min = f(xk(1), xk(2));
            fprintf("Minimum is found at z = %1.3f\n", min);
            fprintf("Method finished in k = %d steps\n", k);
            fprintf("-------------------------------------\n\n");

        case 2
            syms gk

            while norm(gradValue) > epsilon && k <= max_steps
                
                if updatedHess(1,1) > 0 && det(updatedHess) > 0 
                    dk = -inv(updatedHess)*gradValue;
                    fmin(gk) = f(xk(1) + gk*dk(1), xk(2) + gk*dk(2));

                    a0 = 0;
                    b0 = 5;
                    l = 1e-4;
                    [gamma, ~, ~, ~, ~] = GoldenSection(a0, b0, fmin, l, 0, 0);

                    xk_1 = round(double(xk + gamma.*dk), 4);
                    
                    %% Check Criteria
                    flag = LevMarq_criteria(xk, xk_1, gamma, dk, gradf, f);
                    if flag == 0
                        fprintf("Criteria not fulfilled in k = %d iteration!\n", k)
                        break;
                    else
                        xk = xk_1;
                    end
                    x = xk(1);
                    y = xk(2);
                    points_x = [points_x; x];
                    points_y = [points_y; y];
                    gradValue = subs(gradf);
                    hessfMatrix = subs(hessf);
                    
                    %% Require Positive Definites
                    mk = abs(max(eig(hessfMatrix)));
                    updatedHess = hessfMatrix + mk.*eye(size(hessfMatrix));
                    while updatedHess(1,1) <= 0 || det(updatedHess) <= 0
                       mk = mk + 0.1;
                       updatedHess = hessfMatrix + mk.*eye(size(hessfMatrix));
                    end
                    
                    k = k + 1;
                else
                    fprintf("The hessian matrix is not positive definite!\n");
                    break;
                end

            end
            
            min = f(xk(1), xk(2));
            fprintf("Minimum is found at z = %1.3f\n", min);
            fprintf("Method finished in k = %d steps\n", k);
            fprintf("-------------------------------------\n\n");

        case 3
            mk_arm = 0;
            a = 10e-3;
            b = 0.1;
            s = gamma0 * b^mk_arm;
            gamma = gamma0;

            while norm(gradValue) > epsilon && k <= max_steps
                
                 if updatedHess(1,1) > 0 && det(updatedHess) > 0   
                    dk = -inv(updatedHess)*gradValue;

                    xk_1 = round(double(xk + gamma.*dk), 4);

                    while f(xk(1), xk(2)) - f(xk_1(1), xk_1(2)) < a*b^mk_arm*s*(dk'*dk)
                        mk_arm = mk_arm + 1;
                    end

                    gamma = s*b^mk_arm;

                    xk_1 = round(double(xk + gamma.*dk), 4);
                    
                    %% Check Criteria
                    flag = LevMarq_criteria(xk, xk_1, gamma, dk, gradf, f);
                    if flag == 0
                        fprintf("Criteria not fulfilled in k = %d iteration!\n", k)
                        break;
                    else
                        xk = xk_1;
                    end
                    x = xk(1);
                    y = xk(2);
                    points_x = [points_x; x];
                    points_y = [points_y; y];
                    gradValue = subs(gradf);
                    hessfMatrix = subs(hessf);
                    
                    %% Require Positive Definites
                    mk = abs(max(eig(hessfMatrix)));
                    updatedHess = hessfMatrix + mk.*eye(size(hessfMatrix));
                    while updatedHess(1,1) <= 0 || det(updatedHess) <= 0
                       mk = mk + 0.1;
                       updatedHess = hessfMatrix + mk.*eye(size(hessfMatrix));
                    end
                    
                    k = k + 1;

                else
                    fprintf("The hessian matrix is not positive definite!\n");
                    break;
                end
            end
            
            min = f(xk(1), xk(2));
            fprintf("Minimum is found at z = %1.3f\n", min);
            fprintf("Method finished in k = %d steps\n", k);
            fprintf("-------------------------------------\n\n");
    end
end

