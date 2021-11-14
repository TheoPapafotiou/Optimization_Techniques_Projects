function [xmin, akV, bkV] = BisectionDer(a0, b0, f, fd, l, n_f, make_plot)
    
    syms x;
    a = a0;
    b = b0;
    x1 = (a + b)/2;
    
    k = 1;
    
    if make_plot == 1
        figure()
        hold on;
        x0 = a:0.1:b;
        plot(x0, f(x0), 'k');
        xlabel("x");
        ylabel("y");
        plot(x1, f(x1), 'r*');
    end
    
    akV = a;
    bkV = b;
    while abs(a - b) > l
        der = vpa(subs(fd,x,x1));
        
        if der > 0
            b = x1;
        elseif der < 0
            a = x1;
        else
            break;
        end
        
        x1 = (a + b)/2;
        
        if make_plot == 1
            plot(x1, f(x1), 'r*');
        end
        
        akV = [akV; a];
        bkV = [bkV; b];
        k = k + 1;
    end
    
    if make_plot == 1
        plot(x1, f(x1), 'g*');
        title({['BisectionDer Method Process - ', num2str(k), ' iterations'];
                ['(l = ', num2str(l), ')']});
        hold off;
        grid on;
    end
    
    xmin = x1;
    ak = a;
    bk = b;
    fmin = f(xmin);
    
    if make_plot == 1
        fprintf("The minimum of the f%d is %2.6f\n\t at a value %2.6f\n", n_f, xmin, fmin);
        fprintf("The final interval is [a, b] = [%2.3f, %2.3f]\n", ak, bk);
        fprintf("-----------------------------------------------\n\n");
    end

end
