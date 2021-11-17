%% ====== Project 1.4 ======
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

syms x;

y1 = (x-3).^2 + (sin(x+3)).^2;
y2 = (x-1).*cos(x/2) + x.^2;
y3 = (x+2).^2 + exp(x-2).*sin(x+3);

f1d = diff(y1);
f2d = diff(y2);
f3d = diff(y3);

a0 = -4;
b0 = 4;

%% (4) Bisection Method (with derivatives)

fprintf("=#=#=#=\n");
fprintf("TEST 4 - Bisection Method (with derivatives)\n");
fprintf("=#=#=#=\n\n");

xmin_varL = zeros(8, 3);
print_table_varL = zeros(8, 6); % f1, f2, f3

make_plot = 0;
for i = 1:8
    l = i/200;
    [xmin_varL(i, 1), ~, ~, N_varL(1)] = BisectionDer(a0, b0, f1, f1d, l, 1, make_plot);
    [xmin_varL(i, 2), ~, ~, N_varL(2)] = BisectionDer(a0, b0, f2, f2d, l, 2, make_plot);
    [xmin_varL(i, 3), ~, ~, N_varL(3)] = BisectionDer(a0, b0, f3, f3d, l, 3, make_plot);
    
    for j = 1:3
        print_table_varL(i, 2*j-1) = round(xmin_varL(i, j), 5);
        print_table_varL(i, 2*j) = N_varL(j);
    end
end

%% Method to be plotted (l = 0.005)
l1 = 0.0001;
make_plot = 1;
[~, akV1_1, bkV1_1, N1_1] = BisectionDer(a0, b0, f1, f1d, l1, 1, make_plot);
[~, akV2_1, bkV2_1, N2_1] = BisectionDer(a0, b0, f2, f2d, l1, 2, make_plot);
[~, akV3_1, bkV3_1, N3_1] = BisectionDer(a0, b0, f3, f3d, l1, 3, make_plot);

%% Method to be plotted (l = 0.05)
l2 = 0.01;
make_plot = 0;
[~, akV1_2, bkV1_2, N1_2] = BisectionDer(a0, b0, f1, f1d, l2, 1, make_plot);
[~, akV2_2, bkV2_2, N2_2] = BisectionDer(a0, b0, f2, f2d, l2, 2, make_plot);
[~, akV3_2, bkV3_2, N3_2] = BisectionDer(a0, b0, f3, f3d, l2, 3, make_plot);

%% Figures ak, bk (l = 0.005)

figure()
hold on;
title({'BisectionDer Method Process (f1)';
        ['(l = ', num2str(l1), ', N = ', num2str(N1_1),')']});
xlabel("k");
ylabel("ak - bk");
p1 = plot(akV1_1, '-.k');
p2 = plot(bkV1_1, '-.b');
for i = 1:length(akV1_1)
    color = [rand, rand, rand];
    p3 = plot(i, akV1_1(i), '*', 'color', color);
    p4 = plot(i, bkV1_1(i), '*', 'color', color);
end
legend([p1, p2], ["ak", "bk"], 'Location','southeast');
hold off;
grid on;
saveas(gcf, 'BisectionDer_AB_1_1.pdf');

figure()
hold on;
title({'BisectionDer Method Process (f2)';
        ['(l = ', num2str(l1), ', N = ', num2str(N2_1),')']});
xlabel("k");
ylabel("ak - bk");
p1 = plot(akV2_1, '-.k');
p2 = plot(bkV2_1, '-.b');
for i = 1:length(akV2_1)
    color = [rand, rand, rand];
    p3 = plot(i, akV2_1(i), '*', 'color', color);
    p4 = plot(i, bkV2_1(i), '*', 'color', color);
end
legend([p1, p2], ["ak", "bk"], 'Location','southeast');
hold off;
grid on;
saveas(gcf, 'BisectionDer_AB_2_1.pdf');

figure()
hold on;
title({'BisectionDer Method Process (f3)';
        ['(l = ', num2str(l1), ', N = ', num2str(N3_1),')']});
xlabel("k");
ylabel("ak - bk");
p1 = plot(akV3_1, '-.k');
p2 = plot(bkV3_1, '-.b');
for i = 1:length(akV3_1)
    color = [rand, rand, rand];
    p3 = plot(i, akV3_1(i), '*', 'color', color);
    p4 = plot(i, bkV3_1(i), '*', 'color', color);
end
legend([p1, p2], ["ak", "bk"], 'Location','southeast');
hold off;
grid on;
saveas(gcf, 'BisectionDer_AB_3_1.pdf');

%% Figures ak, bk (l = 0.05)

figure()
hold on;
title({'BisectionDer Method Process (f1)';
        ['(l = ', num2str(l2), ', N = ', num2str(N1_2),')']});
xlabel("k");
ylabel("ak - bk");
p1 = plot(akV1_2, '-.k');
p2 = plot(bkV1_2, '-.b');
for i = 1:length(akV1_2)
    color = [rand, rand, rand];
    p3 = plot(i, akV1_2(i), '*', 'color', color);
    p4 = plot(i, bkV1_2(i), '*', 'color', color);
end
legend([p1, p2], ["ak", "bk"], 'Location','southeast');
hold off;
grid on;
saveas(gcf, 'BisectionDer_AB_1_2.pdf');

figure()
hold on;
title({'BisectionDer Method Process (f2)';
        ['(l = ', num2str(l2), ', N = ', num2str(N2_2),')']});
xlabel("k");
ylabel("ak - bk");
p1 = plot(akV2_2, '-.k');
p2 = plot(bkV2_2, '-.b');
for i = 1:length(akV2_2)
    color = [rand, rand, rand];
    p3 = plot(i, akV2_2(i), '*', 'color', color);
    p4 = plot(i, bkV2_2(i), '*', 'color', color);
end
legend([p1, p2], ["ak", "bk"], 'Location','southeast');
hold off;
grid on;
saveas(gcf, 'BisectionDer_AB_2_2.pdf');

figure()
hold on;
title({'BisectionDer Method Process (f3)';
        ['(l = ', num2str(l2), ', N = ', num2str(N3_2),')']});
xlabel("k");
ylabel("ak - bk");
p1 = plot(akV3_2, '-.k');
p2 = plot(bkV3_2, '-.b');
for i = 1:length(akV3_2)
    color = [rand, rand, rand];
    p3 = plot(i, akV3_2(i), '*', 'color', color);
    p4 = plot(i, bkV3_2(i), '*', 'color', color);
end
legend([p1, p2], ["ak", "bk"], 'Location','southeast');
hold off;
grid on;
saveas(gcf, 'BisectionDer_AB_3_2.pdf');

%% Figures various l

figure()
hold on;
x = -4:0.1:4;
color = [rand, rand, rand];
plot(x, f1(x), 'color', color);
color = [rand, rand, rand];
plot(x, f2(x), 'color', color);
color = [rand, rand, rand];
plot(x, f3(x), 'color', color);
for i = 1:8
    x1 = xmin_varL(i, 1);
    x2 = xmin_varL(i, 2);
    x3 = xmin_varL(i, 3);
    
    color = [rand, rand, rand];
    plot(x1, f1(x1),'*', 'color', color);
    color = [rand, rand, rand];
    plot(x2, f2(x2),'*', 'color', color);
    color = [rand, rand, rand];
    plot(x3, f3(x3),'*', 'color', color);
end
title("Minimum calculated (l = var)");
xlabel("x");
ylabel("y");
legend("f1", "f2", "f3");
hold off;
grid on;
saveas(gcf, 'BisectionDer_VarL.pdf');