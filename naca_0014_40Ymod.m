% =========================================================================
% PROIECT STABILITATEA STRUCTURILOR DE AVIAȚIE
% Generare Profil Aerodinamic Modificat: NACA 0014 40Y mod (Fokker F28)
% =========================================================================
clear; clc; close all;

% 1. Definire parametri geometrici
t = 0.14;              % Grosimea relativă maximă (14%)
x_grosime_max = 0.4;   % Poziția grosimii maxime la 40% din coardă
num_puncte = 150;      % Densitatea punctelor pe suprafață

% 2. Generare coordonate x folosind distribuția Cosinus (îndesire la margini)
theta = linspace(0, pi, num_puncte);
x = 0.5 * (1 - cos(theta));

y_ext = zeros(size(x));

% 3. Calculul ordonatelor pentru profilul modificat
for i = 1:length(x)
    if x(i) <= x_grosime_max
        % Zona frontală (Bord de atac -> Grosime maximă)
        z = x(i) / x_grosime_max;
        y_ext(i) = (t / 2.0) * (1.5 * sqrt(z) - 0.5 * z^1.5);
    else
        % Zona posterioară (Grosime maximă -> Bord de fugă)
        u = (1.0 - x(i)) / (1.0 - x_grosime_max);
        y_ext(i) = (t / 2.0) * (2.0 * u - u^2);
    end
end

y_int = -y_ext; % Profil simetric (Intrados oglindit)

% 4. Trasarea graficului conform formatului cerut
figure('Color', 'w', 'Position', [100, 100, 800, 500]);
plot(x, y_ext, 'b-', 'LineWidth', 1.2); hold on;
plot(x, y_int, 'b-', 'LineWidth', 1.2);

% Configurare estetică identică cu imaginea martor
title('NACA 0014 40Y mod', 'FontSize', 12, 'FontName', 'Arial');
xlim([0 1]);
ylim([-0.3 0.3]);
grid on;
set(gca, 'GridLineStyle', ':', 'LineWidth', 0.8, 'XColor', [0.3 0.3 0.3], 'YColor', [0.3 0.3 0.3]);

% Afișare mesaj în Command Window
disp('Coordonatele profilului au fost generate cu succes pentru modelul structural.');