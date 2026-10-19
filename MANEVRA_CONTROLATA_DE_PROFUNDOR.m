% =========================================================================
% PROIECT SAvMC / SSAv - MANEVRA CONTROLATA DE PROFUNDOR
% Aeronava: Fokker F28 Mk 4000
% =========================================================================

clear; clc; close all;

%% 1. Date de intrare specifice
L_tot = 29.61;          % Lungimea totala a fuzelajului [m]
x_CG = 13.5;            % Pozitia centrului de greutate de la varf [m]
r_y = 7.4;              % Raza de giratie [m]
L_ao = 11.5;            % Bratul ampenajului orizontal [m]
g = 9.81;               % Acceleratia gravitationala [m/s^2]
V_A = 116.92;           % Viteza de manevra [m/s]
n1 = 2.5;               % Factorul de sarcina maxim (FAR-25)

%% 2. Calcule cinematice si dinamice
epsilon_y = (20 / V_A) * n1 * (n1 - 1.5); % 0.4276 rad/s^2

%% 3. Generarea distributiei n(x')
x = linspace(0, L_tot, 500);
n_x = 1 - (epsilon_y / g) * ((r_y^2 / L_ao) + (x - x_CG));

%% 4. Trasarea Graficului 
figure('Color', [1 1 1], 'Position', [150, 150, 850, 550]);
hold on; box on;

plot(x, n_x, 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 2.5);
plot([0 32], [n1 n1], 'k:', 'LineWidth', 1.5);

xlim([0 32]);
ylim([-0.2 3.0]);
grid on;
set(gca, 'GridLineStyle', ':', 'GridAlpha', 0.6, 'FontSize', 11);

text(L_tot - 2, n1 + 0.08, 'n_1 = 2.5', 'FontSize', 10, 'FontWeight', 'bold');
text(x_CG, -0.05, 'x''_{CG}', 'FontSize', 10, 'HorizontalAlignment', 'center');

plot([0 35], [0 0], 'k-', 'LineWidth', 0.8);
plot([x_CG x_CG], [-0.2 3.0], '--', 'Color', [0.5 0.5 0.5]);

xlabel('x'' [m] (masurat de la varful avionului)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('n(x''), n_1', 'FontSize', 12, 'FontWeight', 'bold');
title('Factorul de sarcina local in lungul axei Ox - Manevra controlata', ...
      'FontSize', 12, 'FontWeight', 'bold');

legend({'n(x'')', 'n_1 limit'}, 'Location', 'southwest', 'FontSize', 10);

hold off;