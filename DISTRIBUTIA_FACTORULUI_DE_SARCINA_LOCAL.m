% =========================================================================
% PROIECT SAvMC / SSAv - DISTRIBUTIA FACTORULUI DE SARCINA LOCAL n(x')
% Aeronava: Fokker F28 Mk 4000
% =========================================================================

clear; clc; close all;

%% 1. Date de intrare (Specifice Fokker F28 Mk 4000)
L_tot = 29.61;          % Lungimea totala a fuzelajului [m]
x_CG = 13.5;            % Pozitia centrului de greutate de la varf [m]
r_y = 7.4;              % Raza de giratie [m]
L_ao = 11.5;            % Bratul de parghie al ampenajului orizontal [m]
G = 324809;             % Greutatea avionului la MTOW [N]
rho_H = 0.653;          % Densitatea aerului la H = 6096 m [kg/m^3]
V_A = 116.92;           % Viteza de manevra stabilita [m/s]
S_ao = 19.8;            % Suprafata ampenajului orizontal [m^2]
C_z_delta = 2.18;       % Panta curbei de portanta AO [rad^-1]

% Bracajele maxime de profundor (in radiani)
beta_max_plus = 25 * (pi / 180);    % 25 grade = 0.4363 rad
beta_max_minus = -20 * (pi / 180);  % -20 grade = -0.3491 rad

%% 2. Calculul variatiei de portanta pe AO (dP_ao)
q = 0.5 * rho_H * V_A^2;  % Presiunea dinamica
dP_ao_plus = q * S_ao * C_z_delta * beta_max_plus;    % 84056 N
dP_ao_minus = q * S_ao * C_z_delta * beta_max_minus;  % -67256 N

%% 3. Generarea distributiei liniare n(x')
x = linspace(0, L_tot, 500); 

n_plus = 1 + (dP_ao_plus / G) * (1 + (L_ao * (x - x_CG)) / r_y^2);
n_minus = 1 + (dP_ao_minus / G) * (1 + (L_ao * (x - x_CG)) / r_y^2);

%% 4. Trasarea Graficului
figure('Color', [1 1 1], 'Position', [100, 100, 850, 550]);
hold on; box on;

plot(x, n_plus, 'Color', [0 0.4470 0.7410], 'LineWidth', 2.5);
plot(x, n_minus, 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 2.5);

plot([0 35], [1 1], '--', 'Color', [0.4 0.4 0.4], 'LineWidth', 1.2); 
plot([x_CG x_CG], [0 2.2], '--', 'Color', [0.4 0.4 0.4], 'LineWidth', 1.2); 

text(L_tot + 0.3, 1.02, 'n = 1', 'FontSize', 11, 'FontWeight', 'normal');
text(x_CG + 0.2, 1.92, 'x_{CG}', 'FontSize', 11, 'Rotation', 90, 'HorizontalAlignment', 'center');

xlim([0 32]);
ylim([0.2 2]);
grid on;
set(gca, 'GridLineStyle', ':', 'GridAlpha', 0.6, 'FontSize', 11);

xlabel('x'' [m]', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('n(x'')', 'FontSize', 12, 'FontWeight', 'bold');
title('Distributia factorului de sarcina pe lungimea aeronavei Fokker F-28 Mk 4000', ...
      'FontSize', 12, 'FontWeight', 'bold');

legend({'Bracaj maxim pozitiv', 'Bracaj maxim negativ', 'n = 1', 'x_{CG}'}, ...
       'Location', 'east', 'FontSize', 10);

hold off;