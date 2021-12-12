%% ====== Test 2 ======
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

epsilon = 0.01;
max_steps = 1000;

%% (3) Levenberg-Marquardt Method

gamma_methods_prints = ["CONSTANT"; "MINIMUM"; "ARMIJO"];

gamma_method = 3;

x0 = 1;
y0 = 1;

for gamma0 = 0.1:0.1:5
    
    [min, k, points_x, points_y] = ...
                LevMarq(f, gradf, hessf, x0, y0, epsilon, gamma_method, gamma0, max_steps);
            
    if k > 4
        min
        gamma0
    end
end