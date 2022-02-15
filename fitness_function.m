function [fit] = fitness_function(genes, f, error_type)

    global min_x
    global max_x
    global min_y
    global max_y

    interval = 20;
    fit = 0;
    
    if error_type == "MSE"
        for x = linspace(min_x, max_x, interval)
            for y = linspace(min_y, max_y, interval)
                fit = fit + (f(x, y) - f_analytic(x, y, genes))^2;
            end
        end

        fit = abs(fit / (interval^2));
        
    elseif error_type == "ABS"
        for x = linspace(min_x, max_x, interval)
            for y = linspace(min_y, max_y, interval)
                fit = fit + abs((f(x, y) - f_analytic(x, y, genes)));
            end
        end
    else
        disp("No fitness function selected!")
    end
end

