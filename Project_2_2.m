%% ====== Project 2.2 ======
%
% Theodoros Papafotiou
% AEM: 9708
% ==========================

clear;
close all;
clc;

f1 = @(x1, x2) (x1.^3).*exp(-(x1.^2)-(x2.^4));

step = 0.001;
x = -4:step:4;
y = x';
z = (x.^3).*exp(-(x.^2)-(y.^4));

x0 = [0, -1, -2];
y0 = [0, -1, -1];
gamma0 = 1;

epsilon = 0.08;

%% (1) Steepest Descent Method

min = zeros(3, 1);
k = zeros(3, 1);
gamma_methods_prints = ["Constant"; "Minimum"; "Armijo"];

for gamma_method = 1:3
    
    fprintf('\n=== Steepest Descent Method with gamma: %s ===\n\n', gamma_methods_prints(gamma_method));
    for i = 1:3
        [min(i), k(i)] = SteepestDescent(f1, x0(i), y0(i), epsilon, gamma_method, gamma0);
    end
end