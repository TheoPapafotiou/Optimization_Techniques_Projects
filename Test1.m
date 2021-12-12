%% ====== Test ======
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

f(-1, -1)
x = 0;
y = 0;
subs(gradf)

k = 0;
for i = -5:0.2:5
    for j = -5:0.2:5
        x = i;
        y = j;
        hessfMatrix = subs(hessf);
        if hessfMatrix(1, 1) > 0 && det(hessfMatrix) > 0
            k = k+1;
            fprintf("%d point X: %f\n", k, x);
            fprintf("%d point Y: %f\n", k, y);
        end
    end
end
