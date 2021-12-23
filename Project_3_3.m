%% ====== Project 3.3 ======
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

x0 = -7;
y0 = 5;
gamma0 = 0.3;
sk = 10;

epsilon = 0.02;
max_steps = 1000;

%% (3) Steepest Descent with Projection 
%       [x0 = -7, y0 = 5, sk = 10, gk = 0.3, epsilon = 0.02]

X = [-15 15;
     -20 12];
    
fprintf('\n=== Steepest Descent Method [Projection] with constant gamma: %1.2f ===\n\n', gamma0);

[min, k, points_x, points_y] = ...
    SteepestDescentProjection(f, gradf, x0, y0, epsilon, sk, gamma0, X, max_steps);

if k > 1 && ~isnan(min)

    %% 2D diagram
    figure('PaperPosition',[.25 .25 8 6]);
    k2 = 1:k;
    plot(k2, f(points_x(k2), points_y(k2)), 'Marker','o','MarkerFaceColor','red');
    annotation('textbox', [0.4, 0.2, 0.1, 0.1], 'BackgroundColor','#D95319', ...
                'FaceAlpha', 0.2, 'String', "min = " + round(min,4) + ...
                " @ [X, Y] = [" + round(points_x(k), 4) + ", " + round(points_y(k), 4) + "]");
    xlabel('k');
    ylabel('f(xk, yk)');
    title(["Steepest Descent Method with Projection"
            "Starting Point: (" + x0 + ", " + y0+ ")   |   Epsilon = " + epsilon
            "Initial Gamma: " + gamma0 + "   |   sk: " + sk
            ]);
    grid on;
    saveas(gcf,"SDProj_2D_" + gamma0 + '_' + sk + '_' + epsilon*1000 + '.pdf');

    %% 3D diagram
    figure('PaperPosition',[.25 .25 8 6]);
    x = linspace(-abs(x0), abs(x0), 100);
    y = linspace(-abs(y0), abs(y0), 100)';
    z = (1/2)*(x.^2) + 2*(y.^2);
    p1 = surf(x, y, z, 'DisplayName','f(x, y)');
    hold on
    for j = 1:k
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
    title(["Steepest Descent Method with Projection"
            "Starting Point: (" + x0 + ", " + y0+ ")   |   Epsilon = " + epsilon
            "Initial Gamma: " + gamma0 + "   |   sk: " + sk
            ]);
    annotation('textbox', [0.65, 0.75, 0.1, 0.1], 'BackgroundColor','#D95319', ...
                    'FaceAlpha', 0.2, 'String', "k = " + k);
    grid on
    saveas(gcf,"SDProj_3D_" + gamma0 + '_' + sk + '_' + epsilon*1000 + '.pdf');

    %% Contours
    figure('PaperPosition',[.25 .25 8 6]);
    fcontour(f);
    hold on
    plot(points_x, points_y, '-*');
    colorbar 
    hold off
    xlabel('x');
    ylabel('y');
    title(["Steepest Descent Method with Projection"
            "Starting Point: (" + x0 + ", " + y0+ ")   |   Epsilon = " + epsilon
            "Initial Gamma: " + gamma0 + "   |   sk: " + sk
            ]);
    grid on
    saveas(gcf,"SDProj_cont_" + gamma0 + '_' + sk + '_' + epsilon*1000 + '.pdf');
end