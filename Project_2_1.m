%% ====== Project 2.1 ======
%
% Theodoros Papafotiou
% AEM: 9708
% ==========================

clear;
close all;
clc;

figure('PaperPosition',[.25 .25 8 6]);
f = @(x, y) (x.^3).*exp(-(x.^2)-(y.^4));
fcontour(f, 'LineWidth', 1);
colorbar
title('Contours graph of the main function');
grid on;
saveas(gcf,'contour_F.pdf')

figure('PaperPosition',[.25 .25 8 6]);
x = linspace(-4, 4, 100);
y = x';
z = (x.^3).*exp(-(x.^2)-(y.^4));
surf(x, y, z);
colorbar
title('3D Visualization of the main function');
grid on;
saveas(gcf,'3D_F.pdf')