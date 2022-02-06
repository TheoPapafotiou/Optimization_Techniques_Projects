function [fit] = fitness_function(genes, f)

    global min_x
    global max_x
    global min_y
    global max_y

    interval = 20;

    fit = 0;
    for x = linspace(min_x, max_x, interval)
        for y = linspace(min_y, max_y, interval)
            fit = fit + abs((f(x, y) - f_analytic(x, y, genes))^2); % can be squared (or cubed)
        end
    end
    
    fit = abs(fit / (interval^2));
end

