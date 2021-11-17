function [xmin, akV, bkV, N] = BisectionNoDer(a0, b0, f, e, l, n_f, make_plot)

    a = a0;
    b = b0;
    x1 = (a+b)/2 - e;
    x2 = (a+b)/2 + e;
    
    k = 0;
    
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
        
        if f(x1) < f(x2)
            b = x2;
        elseif f(x1) > f(x2)
            a = x1;
        else
            a = x1;
            b = x2;
        end
        
        x1 = (a+b)/2 - e;
        x2 = (a+b)/2 + e;
        
        if make_plot == 1
            plot((a+b)/2, f((a+b)/2), 'r*');
        end
        
        akV = [akV; a];
        bkV = [bkV; b];
        k = k + 1;
    end
    
    if make_plot == 1
        plot((a+b)/2, f((a+b)/2), 'g*');
        title({['BisectionNoDer Method Process - ', num2str(k), ' iterations'];
                ['(l = ', num2str(l), ' e = ', num2str(e), ')']});
        hold off;
        grid on;
        saveas(gcf, ['BisectionNoDer_', int2str(n_f),'.pdf']);
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

