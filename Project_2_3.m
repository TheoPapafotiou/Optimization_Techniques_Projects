%% ====== Project 2.3 ======
%
% Theodoros Papafotiou
% AEM: 9708
% ==========================

clear;
close all;
clc;

syms x y
f = @(x, y) (x.^3).*exp(-(x.^2)-(y.^4));
gradf = gradient(f, [x, y]);
hessf = hessian(f, [x, y]);

x0 = [0, 1, 1, -0.8];
y0 = [0, -1, 1, 0.4];
gamma0 = 0.2;

epsilon = 0.01;
max_steps = 1000;

%% (2) Newton Method

min = zeros(4, 1);
k = zeros(4, 1);
gamma_methods_prints = ["CONSTANT"; "MINIMUM"; "ARMIJO"];

for gamma_method = 1:3
    
    fprintf('\n=== Newton Method with gamma: %s ===\n\n', gamma_methods_prints(gamma_method));
    for i = 1:4
        [min(i), k(i), points_x, points_y] = ...
            Newton(f, gradf, hessf, x0(i), y0(i), epsilon, gamma_method, gamma0, max_steps);
    
        if k(i) > 1
            %% 3D diagram
            figure('PaperPosition',[.25 .25 8 6]);
            k2 = 1:k(i);
            plot(k2, f(points_x(k2), points_y(k2)), 'Marker','o','MarkerFaceColor','red');
            annotation('textbox', [0.4, 0.2, 0.1, 0.1], 'BackgroundColor','#D95319', ...
                        'FaceAlpha', 0.2, 'String', "min = " + round(min(i),4) + ...
                        " @ [X, Y] = [" + round(points_x(k(i)), 4) + ", " + round(points_y(k(i)), 4) + "]");
            xlabel('k');
            ylabel('f(xk, yk)');
            title(["Newton Method"
                    "Starting Point: (" + x0(i) + ", " + y0(i)+ ")   |   Epsilon = " + epsilon
                    "Gamma Calculation Method: " + gamma_methods_prints(gamma_method)
                    ]);
            grid on;
            saveas(gcf,"NEW_2D_" + gamma_methods_prints(gamma_method) + '_' + i + '_' + epsilon*1000 + '.pdf');

            %% 2D diagram
            figure('PaperPosition',[.25 .25 8 6]);
            x = linspace(-4, 4, 100);
            y = x';
            z = (x.^3).*exp(-(x.^2)-(y.^4));
            p1 = surf(x, y, z, 'DisplayName','f(x, y)');
            hold on
            for j = 1:k(i)
                xp = points_x(j);
                yp = points_y(j);
                zp = (xp.^3).*exp(-(xp.^2)-(yp.^4));
                p2 = plot3(xp, yp, zp, '-*', 'LineWidth', 2, 'MarkerSize', 30, 'DisplayName', ['Data ', int2str(j)]);            
            end
            colorbar
            hold off
            xlabel('x');
            ylabel('y');
            zlabel('f(x, y)');
            title(["Newton Method"
                    "Starting Point: (" + x0(i) + ", " + y0(i)+ ")   |   Epsilon = " + epsilon
                    "Gamma Calculation Method: " + gamma_methods_prints(gamma_method)
                    ]);
            legend
            grid on
            saveas(gcf,"NEW_3D_" + gamma_methods_prints(gamma_method) + '_' + i + '_' + epsilon*1000 + '.pdf');
        
            %% Contours
            figure('PaperPosition',[.25 .25 8 6]);
            fcontour(f);
            hold on
            plot(points_x, points_y, '-*');
            colorbar 
            hold off
            grid on
        end
    end
end