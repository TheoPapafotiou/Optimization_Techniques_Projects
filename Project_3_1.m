%% ====== Project 3.1 ======
%
% Theodoros Papafotiou
% AEM: 9708
% ==========================

clear;
close all;
clc;

syms x y
f = @(x, y) (1/2)*(x.^2) + 2*(y.^2);
gradf = gradient(f, [x, y]);

x0 = -2;
y0 = 4;
gamma0 = [0.05, 0.4, 0.5, 2, 10];

epsilon = 0.01;
max_steps = 1000;
gamma_method = 1;

%% (1) Steepest Descent Method

min = zeros(length(gamma0), 1);
k = zeros(length(gamma0), 1);
points_x = zeros(length(gamma0), max_steps);
points_y = zeros(length(gamma0), max_steps);

for i = 1:length(gamma0)
    
    fprintf('\n=== Steepest Descent Method with constant gamma: %1.2f ===\n\n', gamma0(i));

    [min(i), k(i), points_x, points_y] = ...
        SteepestDescent(f, gradf, x0, y0, epsilon, gamma_method, gamma0(i), max_steps);
        
    if k(i) > 1 && ~isnan(min(i))

        %% 2D diagram
        figure('PaperPosition',[.25 .25 8 6]);
        k2 = 1:k(i);
        plot(k2, f(points_x(k2), points_y(k2)), 'Marker','o','MarkerFaceColor','red');
        annotation('textbox', [0.4, 0.2, 0.1, 0.1], 'BackgroundColor','#D95319', ...
                    'FaceAlpha', 0.2, 'String', "min = " + round(min(i),4) + ...
                    " @ [X, Y] = [" + round(points_x(k(i)), 4) + ", " + round(points_y(k(i)), 4) + "]");
        xlabel('k');
        ylabel('f(xk, yk)');
        title(["Steepest Descent Method"
                "Starting Point: (" + x0 + ", " + y0+ ")   |   Epsilon = " + epsilon
                "Initial Gamma: " + gamma0(i)
                ]);
        grid on;
        saveas(gcf,"SD_2D_" + gamma0(i) + '_' + i + '_' + epsilon*1000 + '.pdf');

        %% 3D diagram
        figure('PaperPosition',[.25 .25 8 6]);
        x = linspace(-abs(x0), abs(x0), 100);
        y = linspace(-abs(y0), abs(y0), 100)';
        z = (1/2)*(x.^2) + 2*(y.^2);
        p1 = surf(x, y, z, 'DisplayName','f(x, y)');
        hold on
        for j = 1:k(i)
            xp = points_x(j);
            yp = points_y(j);
            zp = (1/2)*(xp.^2) + 2*(yp.^2);
            p2 = plot3(xp, yp, zp, '-*', 'LineWidth', 2, 'MarkerSize', 30, 'DisplayName', ['Data ', int2str(j)]);
        end
        colorbar
        hold off
        xlabel('x');
        ylabel('y');
        zlabel('f(x, y)');
        title(["Steepest Descent Method"
                "Starting Point: (" + x0 + ", " + y0+ ")   |   Epsilon = " + epsilon
                "Initial Gamma: " + gamma0(i)
                ]);
        annotation('textbox', [0.65, 0.75, 0.1, 0.1], 'BackgroundColor','#D95319', ...
                    'FaceAlpha', 0.2, 'String', "k = " + k(i));
        grid on
        saveas(gcf,"SD_3D_" + gamma0(i) + '_' + i + '_' + epsilon*1000 + '.pdf');

        %% Contours
        figure('PaperPosition',[.25 .25 8 6]);
        fcontour(f);
        hold on
        plot(points_x, points_y, '-*');
        colorbar 
        hold off
        xlabel('x');
        ylabel('y');
        title(["Steepest Descent Method"
                "Starting Point: (" + x0 + ", " + y0+ ")   |   Epsilon = " + epsilon
                "Initial Gamma: " + gamma0(i)
                ]);
        grid on
        saveas(gcf,"SD_cont_" + gamma0(i) + '_' + i + '_' + epsilon*1000 + '.pdf');
    end
end