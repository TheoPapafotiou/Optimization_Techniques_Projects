function [fit] = fitness_function(genes, f)

    interval = 20;
    
    % X limits
    min_x = -1;
    max_x = 2;
    
    % Y limits
    min_y = -2;
    max_y = 1;

    fit = 0;
    for x = linspace(min_x, max_x, interval)
        for y = linspace(min_y, max_y, interval)
            fit = fit + abs((f(x, y) - f_analytic(x, y, genes, length(genes)))^2); % can be squared (or cubed)
        end
    end
    
    fit = abs(fit / (interval^2));
end

