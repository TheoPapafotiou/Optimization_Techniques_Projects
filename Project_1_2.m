%% ====== Project 1.2 ======
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

%% (2) Golden Section

fprintf("=#=#=#=\n");
fprintf("TEST 2 - Golden Section Method\n");
fprintf("=#=#=#=\n\n");

xmin_varL = zeros(8, 3);

make_plot = 0;
for i = 1:8
    
    l = i/200;
    [xmin_varL(i, 1), ~, ~] = GoldenSection(a0, b0, f1, l, 1, make_plot);
    [xmin_varL(i, 2), ~, ~] = GoldenSection(a0, b0, f2, l, 2, make_plot);
    [xmin_varL(i, 3), ~, ~] = GoldenSection(a0, b0, f3, l, 3, make_plot);
end

l = 0.001;
make_plot = 1;
[~, akV1, bkV1] = GoldenSection(a0, b0, f1, l, 1, make_plot);
[~, akV2, bkV2] = GoldenSection(a0, b0, f2, l, 2, make_plot);
[~, akV3, bkV3] = GoldenSection(a0, b0, f3, l, 3, make_plot);

%% Figures ak, bk

figure()
hold on;
title({'Golden Section Method Process (f1)';
        ['(l = ', num2str(l), ')']});
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
title({'Golden Section Method Process (f2)';
        ['(l = ', num2str(l), ')']});
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
title({'Golden Section Method Process (f3)';
        ['(l = ', num2str(l), ')']});
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
