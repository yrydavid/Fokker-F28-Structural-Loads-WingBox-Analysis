% =========================================================================
% PROIECT STABILITATEA STRUCTURILOR DE AVIAȚIE
% Generare Profil Ampenaj Vertical: NACA 0015 40Y mod (Fokker F28 Mk 4000)
% =========================================================================
clear; clc; close all;

% 1. Definire parametri geometrici profil NACA 0015 40Y mod
t = 0.15;              % Grosimea relativă maximă (15%)
x_grosime_max = 0.4;   % Poziția grosimii maxime mutată la 40% din coardă
num_puncte = 200;      % Densitatea punctelor pentru trasare

% 2. Generare coordonate x (distribuție Cosinus)
theta = linspace(0, pi, num_puncte);
x = 0.5 * (1 - cos(theta));

y_ext = zeros(size(x));

% 3. Calculul ordonatelor pe extrados
for i = 1:length(x)
    if x(i) <= x_grosime_max
        z = x(i) / x_grosime_max;
        y_ext(i) = (t / 2.0) * (1.5 * sqrt(z) - 0.5 * z^1.5);
    else
        u = (1.0 - x(i)) / (1.0 - x_grosime_max);
        y_ext(i) = (t / 2.0) * (2.0 * u - u^2);
    end
end

y_int = -y_ext; % Profil simetric

% 4. Trasarea graficului în format academic UPB
figure('Color', 'w', 'Position', [200, 200, 850, 450]);
plot(x, y_ext, 'b-', 'LineWidth', 1.8); hold on;
plot(x, y_int, 'b-', 'LineWidth', 1.8);

% Setări axă și etichete text
title('Profil Aerodinamic Ampenaj Vertical - NACA 0015 40Y mod', 'FontSize', 12, 'FontName', 'Arial', 'FontWeight', 'bold');
xlabel('x / c (Poziția pe coardă)', 'FontSize', 10, 'FontName', 'Arial');
ylabel('y / c (Ordonata profilului)', 'FontSize', 10, 'FontName', 'Arial');

xlim([-0.05 1.05]);
ylim([-0.3 0.3]);
axis equal; % Păstrează scara reală 1:1 între axe pentru a vizualiza grosimea reală
grid on;
set(gca, 'GridLineStyle', ':', 'LineWidth', 0.8, 'XColor', [0.2 0.2 0.2], 'YColor', [0.2 0.2 0.2]);

% 5. Export imagine de înaltă calitate
print('Profil_Ampenaj_Vertical_F28', '-dpng', '-r300');
disp('Graficul ampenajului vertical a fost salvat ca "Profil_Ampenaj_Vertical_F28.png".');