%% ====== Project 1.3 ======
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

%% (3) Fibonacci

fprintf("=#=#=#=\n");
fprintf("TEST 3 - Fibonacci Method\n");
fprintf("=#=#=#=\n\n");

xmin_varL = zeros(8, 3);

make_plot = 0;
for i = 1:8
    
    l = i/200;
    n = 0;
    fibon(n+1) = fibonacci(n);
    while fibon(n + 1) < (b0 - a0)/l
        n = n + 1;
        fibon(n + 1) = fibonacci(n);
    end
    fprintf("----> The chosen n for l = %1.3f is %d (Fn > (b-a)/l)\n\n", l, n); 
    [xmin_varL(i, 1), ~, ~] = Fibonacci(a0, b0, f1, n, fibon, l, 1, make_plot);
    [xmin_varL(i, 2), ~, ~] = Fibonacci(a0, b0, f2, n, fibon, l, 2, make_plot);
    [xmin_varL(i, 3), ~, ~] = Fibonacci(a0, b0, f3, n, fibon, l, 3, make_plot);
end

l = 0.01;
n = 0;
fibon(n+1) = fibonacci(n);
while fibon(n + 1) < (b0 - a0)/l
    n = n + 1;
    fibon(n + 1) = fibonacci(n);
end
fprintf("----> The chosen n for l = %1.3f is %d (Fn > (b-a)/l)\n\n", l, n); 

make_plot = 1;
[~, akV1, bkV1] = Fibonacci(a0, b0, f1, n, fibon, l, 1, make_plot);
[~, akV2, bkV2] = Fibonacci(a0, b0, f2, n, fibon, l, 2, make_plot);
[~, akV3, bkV3] = Fibonacci(a0, b0, f3, n, fibon, l, 3, make_plot);

%% Figures ak, bk

figure()
hold on;
title({'Fibonacci Method Process (f1)';
        ['(l = ', num2str(l), ' n = ', num2str(n), ')']});
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
title({'Fibonacci Method Process (f2)';
        ['(l = ', num2str(l), ' n = ', num2str(n), ')']});
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
title({'Fibonacci Method Process (f3)';
        ['(l = ', num2str(l), ' n = ', num2str(n), ')']});
xlabel("k");
ylabel("ak - bk");

for i = 1:length(akV3)
    color = [rand, rand, rand];
    plot(i, akV3(i), '*', 'color', color);
    plot(i, bkV3(i), '*', 'color', color);
end
hold off;
grid on;

%% Figures various l

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
title("Minimum calculated (l --> var)");
xlabel("x");
ylabel("y");
legend("f1", "f2", "f3");
hold off;
grid on;
