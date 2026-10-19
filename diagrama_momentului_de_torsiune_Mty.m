% Script MATLAB pentru diagrama momentului de torsiune Mt(y) - Fokker F28
clear; clc; close all;

b = 12.54;
coeff_as = 137412.69;

% Intervalul 1 (8.50 <= y <= 12.54 m)
y1 = linspace(8.50, 12.54, 500);
el1 = (-349.54*y1.^2 + 10957.95*y1 + 54965.08).*sqrt(1 - (y1/b).^2) + coeff_as*asin(y1/b);
Mt1 = 164811.88 + 11.69*y1.^3 - 599.80*y1.^2 + 9753.12*y1 - el1;

% Intervalul 2 (3.20 <= y <= 8.50 m)
y2 = linspace(3.20, 8.50, 500);
el2 = (-349.54*y2.^2 + 10957.95*y2 + 54965.08).*sqrt(1 - (y2/b).^2) + coeff_as*asin(y2/b);
Mt2 = 281177.72 + 11.69*y2.^3 - 565.73*y2.^2 + 8328.71*y2 - el2;

% Intervalul 3 (1.65 <= y <= 3.20 m)
y3 = linspace(1.65, 3.20, 500);
el3 = (-349.54*y3.^2 + 10957.95*y3 + 54965.08).*sqrt(1 - (y3/b).^2) + coeff_as*asin(y3/b);
Mt3 = 285981.50 + 11.69*y3.^3 - 599.80*y3.^2 + 9753.12*y3 - el3;

% Intervalul 4 (0 <= y <= 1.65 m)
y4 = linspace(0, 1.65, 500);
el4 = (-349.54*y4.^2 + 10957.95*y4 + 54965.08).*sqrt(1 - (y4/b).^2) + coeff_as*asin(y4/b);
Mt4 = 285981.50 + 11.69*y4.^3 - 599.80*y4.^2 + 9753.12*y4 - el4;

% Plot
figure('Color', [1 1 1]); hold on;
plot(y1, Mt1/1000, 'g-', 'LineWidth', 2.5);
plot(y2, Mt2/1000, 'g-', 'LineWidth', 2.5);
plot(y3, Mt3/1000, 'g-', 'LineWidth', 2.5);
plot(y4, Mt4/1000, 'g-', 'LineWidth', 2.5);

% Salt vertical la motor
plot([3.20 3.20], [Mt2(1)/1000, Mt3(end)/1000], 'r--', 'LineWidth', 1.5);

% Markeri si etichete
plot([12.54 8.50 3.20 3.20 1.65 0], [0 Mt1(1) Mt2(1) Mt3(end) Mt3(1) Mt4(1)]/1000, 'ko', 'MarkerFaceColor', 'k');
text(8.7, Mt1(1)/1000 + 5, sprintf('%.2f kNm', Mt1(1)/1000));
text(3.4, Mt2(1)/1000 - 5, sprintf('%.2f kNm', Mt2(1)/1000), 'Color', 'r');
text(3.4, Mt3(end)/1000 + 5, sprintf('%.2f kNm', Mt3(end)/1000), 'Color', 'r');
text(1.8, Mt3(1)/1000 + 5, sprintf('%.2f kNm', Mt3(1)/1000));
text(0.1, Mt4(1)/1000 + 5, sprintf('M_{t max} = %.2f kNm', Mt4(1)/1000), 'FontWeight', 'bold');

grid on; grid minor;
xlabel('Poziția pe anvergură y [m]', 'FontWeight', 'bold');
ylabel('Moment de torsiune M_t [kNm]', 'FontWeight', 'bold');
title('Diagrama momentului de torsiune M_t(y) - Fokker F28', 'FontWeight', 'bold');
xlim([-0.5 13.5]); hold off;