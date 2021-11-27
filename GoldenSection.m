function [xmin, akV, bkV, N, n_calc] = GoldenSection(a0, b0, f, l, n_f, make_plot)

    a = a0;
    b = b0;
    gamma = 0.618;
    x1 = a + (1 - gamma)*(b - a);
    x2 = a + gamma*(b - a);
    
    n_calc = 2;
    k = 1;
    
    if make_plot == 1
        figure()
        hold on;
        x = a:0.1:b;
        plot(x, f(x), 'k');
        xlabel("x");
        ylabel("y");
        plot((a+b)/2, f((a+b)/2), 'r*');
    end
    
    akV = a;
    bkV = b;
    while abs(a - b) > l
        
        if f(x1) <= f(x2)
            b = x2;
            x2 = x1;
            x1 = a + (1 - gamma)*(b - a);
            n_calc = n_calc + 1;
        elseif f(x1) > f(x2)
            a = x1;
            x1 = x2;
            x2 = a + gamma*(b - a);
            n_calc = n_calc + 1;
        end
        
        if make_plot == 1
            plot((a+b)/2, f((a+b)/2), 'r*');
        end
        
        akV = [akV; a];
        bkV = [bkV; b];
        k = k + 1;
    end
    n_calc = n_calc - 1;
    
    if make_plot == 1
        plot((a+b)/2, f((a+b)/2), 'g*');
        title({['Golden Section Method Process - ', num2str(k), ' iterations'];
                ['(l = ', num2str(l), ')']});
        hold off;
        grid on;
        saveas(gcf, ['GoldenSection_', int2str(n_f),'.pdf']);
    end
    
    xmin = (a+b)/2;
    ak = a;
    bk = b;
    fmin = f(xmin);
    N = length(akV);
    
    if make_plot == 1
        fprintf("The minimum of the f%d is %2.6f\n\t at a value %2.6f\n", n_f, xmin, fmin);
        fprintf("The final interval is [a, b] = [%2.3f, %2.3f]\n", ak, bk);
        fprintf("-----------------------------------------------\n\n");
    end
end

