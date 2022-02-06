function [] = plot_3D(choosePlot, chromosome)

    global min_x
    global max_x
    global min_y
    global max_y
    
    interval = 50;

    if choosePlot == 1
        u1 = linspace(min_x, max_x, interval);
        u2 = linspace(min_y, max_y, interval)';
        z = sin(u1 + u2).*sin(u2.^2);
        
        figure('PaperPosition',[.25 .25 8 6]);
        surf(u1, u2, z)
        grid on
        xlabel('x');
        ylabel('y');
        title("3D Visualization of test function");
        saveas(gcf,'3D_test.pdf');
        
        
    elseif choosePlot == 2
        
        z = zeros(interval);
        countX = 0;
        for x = linspace(min_x, max_x, interval)
            countX = countX + 1;
            countY = 0;
            for y = linspace(min_y, max_y, interval)
                countY = countY + 1;
                z(countY, countX) = f_analytic(x, y, chromosome);
            end
        end
        
        u1 = linspace(min_x, max_x, interval);
        u2 = linspace(min_y, max_y, interval)';
        
        figure('PaperPosition',[.25 .25 8 6]);
        surf(u1, u2, z);
        grid on
        xlabel('x');
        ylabel('y');
        title("3D Visualization of analytic function");
        saveas(gcf,'3D_analytic.pdf');
    end

end

