% =========================================================================
% PROIECT SAvMC / SSAv - REPARTIȚIA SARCINILOR PE ARIPĂ (VARIANTA NETEDĂ)
% Aeronava: Fokker F28 Mk 4000 (H = 1500 m, V_c = 224 m/s, n = 2.5)
% =========================================================================

clear; clc; close all;

%% 1. Date Geometrice și Aerodinamice (Fokker F28 Mk 4000)
b = 12.535;             % Semianvergura aripii [m]
CMG = 3.15;             % Coarda medie geometrică [m]

% Coeficienți Diederich / Torenbeek citiți din diagrame
C1 = 0.50; 
C2 = 0.16; 
C3 = 0.38;

%% 2. Vectorul Anvergurii (y) de la 0 la b
y = linspace(0, b, 500);
eta = y / b;            % Coordonata adimensională

%% 3. Legile de Variație a Corzilor și Repartiția Diederich
c_y = 4.70 - 0.2473 * y; % Legea corzilor pentru aripa ta [m]

% Funcția f(eta) pentru aripă în săgeată
f_eta = 1.25 * sqrt(1 - eta.^2); 

% Repartitia adimensională a portanței L_a(eta)
L_a = C1 * (c_y / CMG) + C2 * (4 / pi) * sqrt(1 - eta.^2) + C3 * f_eta;

%% 4. Calculul Forțelor Repartizate [N/m] (Varianta Continuă)
% Forța aerodinamică normală distribuită p_a(y)
P_a = 827650;           % Portanța totală pentru n=2.5 [N]
p_a = (P_a / (2*b)) * L_a; 

% Greutatea proprie a structurii aripii -p_g(y)
p_g = 1118 * c_y; 

% Greutatea combustibilului -p_gc(y) extinsă continuu pentru un grafic curat
p_gc = 2485 * c_y; 

%% 5. Trasarea Graficului (Identic cu modelul din Pagina 23)
figure('Color', [1 1 1], 'Position', [100, 100, 850, 550]);
hold on; box on;

% Trasarea celor 3 curbe continue
plot(y, p_a, 'r-', 'LineWidth', 2.5);       % p_a(y) - Roșu continuu
plot(y, -p_g, 'b-', 'LineWidth', 2.5);      % -p_g(y) - Albastru continuu
plot(y, -p_gc, 'g-', 'LineWidth', 2.5);     % -p_gc(y) - Verde continuu

% Linia de zero (Axa neutră a aripii)
plot([0 b+1], [0 0], 'k-', 'LineWidth', 1.2);

% Setări axe și proporții (Să nu fie fuzelajul deformat)
xlim([0 13]);
ylim([-15000 50000]); 
grid on;
set(gca, 'FontSize', 11, 'GridLineStyle', ':');

% Marcaje text pe grafic direct lângă linii (Stil Mathcad)
text(0.5, 45000, 'p_a(y)', 'Color', 'r', 'FontSize', 11, 'FontWeight', 'bold');
text(0.5, -4000, '-p_g(y)', 'Color', 'b', 'FontSize', 11, 'FontWeight', 'bold');
text(0.5, -10000, '-p_{gc}(y)', 'Color', 'g', 'FontSize', 11, 'FontWeight', 'bold');

% Etichetarea axelor
xlabel('y [m] (Anvergura aripii)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Forțe repartizate [N/m]', 'FontSize', 12, 'FontWeight', 'bold');
title('Repartiția sarcinilor aerodinamice și masice pe semianvergura aripii - Fokker F28', ...
      'FontSize', 11, 'FontWeight', 'bold');

legend({'p_a(y) - Portanță aerodinamică', '-p_g(y) - Greutate structură', '-p_{gc}(y) - Greutate combustibil'}, ...
       'Location', 'southwest', 'FontSize', 10);

hold off;