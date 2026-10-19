% =========================================================================
% PROIECT STABILITATEA STRUCTURILOR DE AVIAȚIE
% Generare Profil Ampenaj Orizontal: NACA 64A012 (Fokker F28 Mk 4000)
% =========================================================================
clear; clc; close all;

% 1. Definire parametri geometrici profil NACA 64A012
t = 0.12;              % Grosimea relativă maximă (12%)
x_grosime_max = 0.4;   % Poziția grosimii maxime la 40% din coardă
num_puncte = 200;      % Densitatea punctelor pentru trasare fluidă

% 2. Generare coordonate x (distribuție Cosinus pentru fidelitate la borduri)
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

y_int = -y_ext; % Profil simetric (Intradosul este oglindit)

% 4. Trasarea graficului în format academic
figure('Color', 'w', 'Position', [150, 150, 850, 450]);
plot(x, y_ext, 'b-', 'LineWidth', 1.8); hold on;
plot(x, y_int, 'b-', 'LineWidth', 1.8);

% Configurare elemente grafice (identic cu stilul din carțile tehnice UPB)
title('Profil Aerodinamic Ampenaj Orizontal - NACA 64A012', 'FontSize', 12, 'FontName', 'Arial', 'FontWeight', 'bold');
xlabel('x / c (Poziția pe coardă)', 'FontSize', 10, 'FontName', 'Arial');
ylabel('y / c (Ordonata profilului)', 'FontSize', 10, 'FontName', 'Arial');

xlim([-0.05 1.05]);
ylim([-0.3 0.3]);
axis equal; % Garantează proporțiile geometrice reale nescalate asimetric
grid on;
set(gca, 'GridLineStyle', ':', 'LineWidth', 0.8, 'XColor', [0.2 0.2 0.2], 'YColor', [0.2 0.2 0.2]);

% 5. Export imagine la calitate înaltă
print('Profil_Ampenaj_Orizontal_F28', '-dpng', '-r300');
disp('Graficul ampenajului a fost salvat ca "Profil_Ampenaj_Orizontal_F28.png".');