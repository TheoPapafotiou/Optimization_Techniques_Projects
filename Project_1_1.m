%% ====== Project 1.1 ======
%
% Theodoros Papafotiou
% AEM: 9708
% ==========================

clear;
close all;
clc;

f1 = @(x) (x-3).^2 + (sin(x+3)).^2;
f2 = @(x) (x-1).*cos(x/2) + x.^2;
f3 = @(x) (x+2).^2 + exp(x-2).*sin(x+3);

a0 = -4;
b0 = 4;

%% (1) Bisection Method (without derivatives)

fprintf("=#=#=#=\n");
fprintf("TEST 1 - Bisection Method (without derivatives)\n");
fprintf("=#=#=#=\n\n");

xmin_varL = zeros(8, 3);
xmin_varE = zeros(8, 3);

make_plot = 0;
for i = 1:8
    
    % 2*e < l
    l = 0.01;
    e = i/2000;
    [xmin_varE(i, 1), ~, ~] = BisectionNoDer(a0, b0, f1, e, l, 1, make_plot);
    [xmin_varE(i, 2), ~, ~] = BisectionNoDer(a0, b0, f2, e, l, 2, make_plot);
    [xmin_varE(i, 3), ~, ~] = BisectionNoDer(a0, b0, f3, e, l, 3, make_plot);
    
    %%
    l = i/200;
    e = 0.001;
    [xmin_varL(i, 1), ~, ~] = BisectionNoDer(a0, b0, f1, e, l, 1, make_plot);
    [xmin_varL(i, 2), ~, ~] = BisectionNoDer(a0, b0, f2, e, l, 2, make_plot);
    [xmin_varL(i, 3), ~, ~] = BisectionNoDer(a0, b0, f3, e, l, 3, make_plot);

end

l = 0.01;
e = 0.001;
make_plot = 1; 
[~, akV1, bkV1] = BisectionNoDer(a0, b0, f1, e, l, 1, make_plot);
[~, akV2, bkV2] = BisectionNoDer(a0, b0, f2, e, l, 2, make_plot);
[~, akV3, bkV3] = BisectionNoDer(a0, b0, f3, e, l, 3, make_plot);

%% Figures ak, bk

figure()
hold on;
title({'BisectionNoDer Method Process (f1)';
        ['(l = ', num2str(l), ' e = ', num2str(e), ')']});
xlabel("k");
ylabel("ak - bk");

for i = 1:length(akV1)
    color = [rand, rand, rand];
    plot(i, akV1(i), '*', 'color', color);
    plot(i, bkV1(i), '*', 'color', color);
end
hold off;
grid on;

figure()
hold on;
title({'BisectionNoDer Method Process (f2)';
        ['(l = ', num2str(l), ' e = ', num2str(e), ')']});
xlabel("k");
ylabel("ak - bk");

for i = 1:length(akV2)
    color = [rand, rand, rand];
    plot(i, akV2(i), '*', 'color', color);
    plot(i, bkV2(i), '*', 'color', color);
end
hold off;
grid on;

figure()
hold on;
title({'BisectionNoDer Method Process (f3)';
        ['(l = ', num2str(l), ' e = ', num2str(e), ')']});
xlabel("k");
ylabel("ak - bk");

for i = 1:length(akV3)
    color = [rand, rand, rand];
    plot(i, akV3(i), '*', 'color', color);
    plot(i, bkV3(i), '*', 'color', color);
end
hold off;
grid on;

%% Figures various e, l
figure()
hold on;
x = -4:0.1:4;
plot(x, f1(x));
plot(x, f2(x));
plot(x, f3(x));
for i = 1:8
    x1 = xmin_varE(i, 1);
    x2 = xmin_varE(i, 2);
    x3 = xmin_varE(i, 3);
    
    plot(x1, f1(x1),'r*');
    plot(x2, f2(x2),'m*');
    plot(x3, f3(x3),'k*');
end
title("Minimum calculated (l = 0.01, e --> var)");
xlabel("x");
ylabel("y");
legend("f1", "f2", "f3");
hold off;
grid on;

figure()
hold on;
x = -4:0.1:4;
plot(x, f1(x));
plot(x, f2(x));
plot(x, f3(x));
for i = 1:8
    x1 = xmin_varL(i, 1);
    x2 = xmin_varL(i, 2);
    x3 = xmin_varL(i, 3);
    
    plot(x1, f1(x1),'r*');
    plot(x2, f2(x2),'m*');
    plot(x3, f3(x3),'k*');
end
title("Minimum calculated (l --> var, e = 0.001)");
xlabel("x");
ylabel("y");
legend("f1", "f2", "f3");
hold off;
grid on;