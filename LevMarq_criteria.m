function [flag] = LevMarq_criteria(xk, xk_1, gk, d, gradf, f)

    syms x y
    flag = 0;
    x = xk(1);
    y = xk(2);
    gradXk = subs(gradf);

    x = xk_1(1);
    y = xk_1(2);
    gradXk_1 = subs(gradf);

    z1 = d' * gradXk_1;
    z2 = d' * gradXk;

    for beta = linspace(0.01, 1, 30)    
        if  z1 > beta * z2
            % Criterion 3 --> OK

            w1 = f(xk_1(1), xk_1(2));
            w2 = f(xk(1), xk(2));
            w3 = gk * d' * gradXk;

            for alpha = linspace(0.00001, beta, 30)
                if w1 <= w2 + alpha * w3
                    % Criterion 4 --> OK
                    
                    flag = 1;
                    break;
                end
            end
            break;
        end
    end

end

