% =========================================================================
% PROIECT SAvMC / SSAv - DISTRIBUTIA FACTORULUI DE SARCINA LATERAL n_y(x')
% Stil adaptat exact dupa modelul grafic cerut
% Aeronava: Fokker F28 Mk 4000
% =========================================================================

clear; clc; close all;

%% 1. Date de intrare (Specifice Fokker F28 Mk 4000)
L_tot = 29.61;          % Lungimea totala a fuzelajului [m]
x_CG = 13.5;            % Pozitia centrului de greutate de la varf [m]
r_z = 7.6743;           % Raza de giratie de giratie [m]
L_av = 11.5;            % Bratul ampenajului vertical [m]
G = 324809;             % Greutatea avionului la MTOW [N]
S = 79.0;               % Suprafata aripii [m^2]
S_av = 14.5;            % Suprafata ampenajului vertical [m^2]
C_z_delta = 1.97;       % Panta curbei de portanta AV [rad^-1]
rho_H = 0.653;          % Densitatea aerului la H = 6096 m [kg/m^3]
V_A = 116.92;           % Viteza de manevra [m/s]

% Bracajele maxime de directie
beta_max_plus = 25 * (pi / 180);
beta_max_minus = -25 * (pi / 180);

%% 2. Calcule aerodinamice de baza
q = 0.5 * rho_H * V_A^2;
G_p_S = G / S;

factor_plus = (q / G_p_S) * (S_av / S) * C_z_delta * beta_max_plus;
factor_minus = (q / G_p_S) * (S_av / S) * C_z_delta * beta_max_minus;

%% 3. Generarea distributiei liniare n_y(x') pana la capatul avionului
x = linspace(0, L_tot, 500);
ny_plus = factor_plus * (1 + (L_av * (x - x_CG)) / (r_z^2));
ny_minus = factor_minus * (1 + (L_av * (x - x_CG)) / (r_z^2));

%% 4. Trasarea Graficului 
figure('Color', [1 1 1], 'Position', [100, 100, 850, 550]);
hold on; box on;

% Liniile pentru factorul de sarcina lateral (Culori si stiluri identice)
plot(x, ny_plus, 'r-', 'LineWidth', 2);   % ny+(x) - Rosie Continua
plot(x, ny_minus, 'b:', 'LineWidth', 2);  % ny-(x) - Albastra Punctata

% Linia de referinta n = 1 (Verde intrerupta pe toata intinderea axei)
plot([0 30], [1 1], 'g--', 'LineWidth', 2); 

% Ajustare axe si aspect grafic exact ca in imagine
xlim([0 30]);
ylim([-2 2]);
grid on;
set(gca, 'FontSize', 11);

% Etichetarea axelor conform cerintelor profesorului 
xlabel('x'' [m]', 'FontSize', 11);
ylabel('ny^+(x), ny^-(x), n=1', 'FontSize', 11);
title('Distributia factorului de sarcina laterala - Fokker F-28 Mk 4000', ...
      'FontSize', 11, 'FontWeight', 'bold');

% Legenda configurata identic in coltul stanga-jos
legend({'ny^+(x)', 'ny^-(x)', 'n = 1'}, 'Location', 'southwest', 'FontSize', 10);

hold off;