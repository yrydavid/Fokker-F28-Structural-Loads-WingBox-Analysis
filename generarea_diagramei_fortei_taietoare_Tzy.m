% Script MATLAB pentru generarea diagramei fortei taietoare Tz(y)
% Avion de calcul: Fokker F28 Mk4000
clear; clc; close all;

% Definire constante si parametri geometrici
b = 12.54; % Semianvergura aripii [m]
coeff_arcsin = 203574.36;

% --- INTERVALUL 1: Vârful aripii (8.50 <= y <= 12.54 m) ---
y1 = linspace(8.50, 12.54, 500);
elliptic_1 = coeff_arcsin * (asin(y1/b) + (y1/b).*sqrt(1 - (y1/b).^2));
Tz1 = 399804.14 - 6382 * y1 - elliptic_1;

% --- INTERVALUL 2: Rezervor combustibil (3.20 <= y <= 8.50 m) ---
y2 = linspace(3.20, 8.50, 500);
elliptic_2 = coeff_arcsin * (asin(y2/b) + (y2/b).*sqrt(1 - (y2/b).^2));
Tz2 = 345993.19 - 51.3 * y2 - elliptic_2;

% --- INTERVALUL 3: Între încastrare și motor (1.65 <= y <= 3.20 m) ---
y3 = linspace(1.65, 3.20, 500);
elliptic_3 = coeff_arcsin * (asin(y3/b) + (y3/b).*sqrt(1 - (y3/b).^2));
Tz3 = 276524.36 - 51.3 * y3 - elliptic_3;

% --- INTERVALUL 4: Zona sub fuzelaj (0 <= y <= 1.65 m) ---
y4 = linspace(0, 1.65, 500);
elliptic_4 = coeff_arcsin * (asin(y4/b) + (y4/b).*sqrt(1 - (y4/b).^2));
Tz4 = 286970.02 - 6382 * y4 - elliptic_4;

% --- TRASAREA DIAGRAMEI ---
figure('Color', [1 1 1]);
hold on;

% Trasare curbe pentru fiecare interval (transformate in kN pentru lizibilitate)
plot(y1, Tz1/1000, 'b-', 'LineWidth', 2.5);
plot(y2, Tz2/1000, 'b-', 'LineWidth', 2.5);
plot(y3, Tz3/1000, 'b-', 'LineWidth', 2.5);
plot(y4, Tz4/1000, 'b-', 'LineWidth', 2.5);

% Trasare salt vertical la cota y = 3.20 m
plot([3.20 3.20], [Tz2(1)/1000, Tz3(end)/1000], 'r--', 'LineWidth', 1.5);

% Evidențiere puncte remarcabile prin markeri
plot(12.54, Tz1(end)/1000, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);
plot(8.50, Tz1(1)/1000, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);
plot(3.20, Tz2(1)/1000, 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 6);
plot(3.20, Tz3(end)/1000, 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 6);
plot(1.65, Tz3(1)/1000, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);
plot(0, Tz4(1)/1000, 'ko', 'MarkerFaceColor', 'b', 'MarkerSize', 6);

% Adaugare etichete cu valori text pe grafic langa punctele cheie
text(12.6, 5, 'y=12.54 m (T_z=0 kN)', 'FontSize', 9);
text(8.6, Tz1(1)/1000 + 10, sprintf('%.2f kN', Tz1(1)/1000), 'FontSize', 9);
text(3.3, Tz2(1)/1000 + 10, sprintf('%.2f kN', Tz2(1)/1000), 'FontSize', 9, 'Color', 'r');
text(3.3, Tz3(end)/1000 - 15, sprintf('%.2f kN', Tz3(end)/1000), 'FontSize', 9, 'Color', 'r');
text(1.7, Tz3(1)/1000 + 10, sprintf('%.2f kN', Tz3(1)/1000), 'FontSize', 9);
text(0.1, Tz4(1)/1000 + 10, sprintf('T_{z max} = %.2f kN', Tz4(1)/1000), 'FontSize', 10, 'FontWeight', 'bold');

% Configurare aspect axe si caroiaj
grid on; grid minor;
xlabel('Poziția pe anvergura aripii y [m]', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Forța tăietoare T_z [kN]', 'FontSize', 11, 'FontWeight', 'bold');
title('Diagrama forței tăietoare T_z(y) - Fokker F28 Mk4000', 'FontSize', 12, 'FontWeight', 'bold');
xlim([-0.5 13.5]);
ylim([-20 max(Tz4/1000)+50]);

% Linie de zero pentru referinta axei Ox
plot([-1 14], [0 0], 'k-', 'LineWidth', 0.8);

hold off;