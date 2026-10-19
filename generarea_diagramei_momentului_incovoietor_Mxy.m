% Script MATLAB pentru generarea diagramei momentului incovoietor Mx(y)
% Avion de calcul: Fokker F28 Mk4000
clear; clc; close all;

% Definire constante geometrice comune
b = 12.54; % Semianvergura aripii [m]
coeff_arcsin = 203574.36;
coeff_elliptic = 850940.82;

% --- INTERVALUL 1: Vârful aripii (8.50 <= y <= 12.54 m) ---
y1 = linspace(8.50, 12.54, 500);
u1 = y1 / b;
term_common1 = coeff_arcsin * (y1 .* asin(u1) + 12.54 * sqrt(1 - u1.^2)) - coeff_elliptic * (1 - u1.^2).^1.5;
Mx1 = 501789.89 - 399804.14 * y1 + 3191 * y1.^2 + term_common1;

% --- INTERVALUL 2: Rezervor combustibil (3.20 <= y <= 8.50 m) ---
y2 = linspace(3.20, 8.50, 500);
u2 = y2 / b;
term_common2 = coeff_arcsin * (y2 .* asin(u2) + 12.54 * sqrt(1 - u2.^2)) - coeff_elliptic * (1 - u2.^2).^1.5;
Mx2 = 273093.36 - 345993.19 * y2 + 25.65 * y2.^2 + term_common2;

% --- INTERVALUL 3: Între încastrare și motor (1.65 <= y <= 3.20 m) ---
y3 = linspace(1.65, 3.20, 500);
u3 = y3 / b;
term_common3 = coeff_arcsin * (y3 .* asin(u3) + 12.54 * sqrt(1 - u3.^2)) - coeff_elliptic * (1 - u3.^2).^1.5;
Mx3 = 50793.10 - 276524.36 * y3 + 25.65 * y3.^2 + term_common3;

% --- INTERVALUL 4: Zona sub fuzelaj (0 <= y <= 1.65 m) ---
y4 = linspace(0, 1.65, 500);
u4 = y4 / b;
term_common4 = coeff_arcsin * (y4 .* asin(u4) + 12.54 * sqrt(1 - u4.^2)) - coeff_elliptic * (1 - u4.^2).^1.5;
Mx4 = 59410.78 - 286970.02 * y4 + 3191 * y4.^2 + term_common4;

% --- TRASAREA DIAGRAMEI ---
figure('Color', [1 1 1]);
hold on;

% Plotarea celor 4 sub-curbe (transformate in kNm)
plot(y1, Mx1/1000, 'b-', 'LineWidth', 2.5);
plot(y2, Mx2/1000, 'b-', 'LineWidth', 2.5);
plot(y3, Mx3/1000, 'b-', 'LineWidth', 2.5);
plot(y4, Mx4/1000, 'b-', 'LineWidth', 2.5);

% Evidențierea prin markeri negri a punctelor de trecere (continuitate perfecta)
plot(12.54, Mx1(end)/1000, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);
plot(8.50, Mx1(1)/1000, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);
plot(3.20, Mx2(1)/1000, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);
plot(1.65, Mx3(1)/1000, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);
plot(0, Mx4(1)/1000, 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 7);

% Adăugare etichete cu valori text pe grafic
text(12.6, 50, 'y=12.54 m (M_x=0)', 'FontSize', 9);
text(8.6, Mx1(1)/1000 + 50, sprintf('%.2f kNm', Mx1(1)/1000), 'FontSize', 9);
text(3.4, Mx2(1)/1000 - 50, sprintf('%.2f kNm', Mx2(1)/1000), 'FontSize', 9);
text(1.8, Mx3(1)/1000 + 50, sprintf('%.2f kNm', Mx3(1)/1000), 'FontSize', 9);
text(0.1, Mx4(1)/1000 + 50, sprintf('M_{x max} = %.2f kNm', Mx4(1)/1000), 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'r');

% Configurare estetică axe și caroiaj
grid on; grid minor;
xlabel('Poziția pe anvergura aripii y [m]', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Momentul încovoietor M_x [kNm]', 'FontSize', 11, 'FontWeight', 'bold');
title('Diagrama momentului încovoietor M_x(y) - Fokker F28 Mk4000', 'FontSize', 12, 'FontWeight', 'bold');
xlim([-0.5 13.5]);
ylim([-50 max(Mx4/1000)+150]);

% Linie de zero pentru axa Ox
plot([-1 14], [0 0], 'k-', 'LineWidth', 0.8);

hold off;