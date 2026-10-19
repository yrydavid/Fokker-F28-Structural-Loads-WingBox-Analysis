% Script MATLAB pentru generarea diagramei momentului de torsiune repartizat mt(y)
% Avion de calcul: Fokker F28 Mk4000
clear; clc; close all;

% Definire constante geometrice si masice globale
b = 12.54;       % Semianvergura aripii [m]
c0 = 4.50;       % Coarda la incastrare (y=0) [m]
ce = 1.80;       % Coarda la extremitate (y=12.54) [m]
pg = 1118;       % Greutatea structurii distributed [N/m]
pgc = 6330.7;    % Greutatea combustibilului distributed [N/m]

% Coeficientul pentru momentul focar aerodinamic mF (0.5 * rho * V^2 * CmF)
coeff_mF = -756.48; 

% Pozitii remarcabile procentuale din coarda (Conform ghidului)
a_CE = 0.40;
a_CG = 0.50;
a_CGc = 0.45;
a_F = 0.25;

% --- DEFINIREA VECTORULUI DE ANVERGURA ---
y = linspace(0, b, 1000);
mt = zeros(size(y));

% --- CALCULUL VALORILOR PE INTERVALE ---
for i = 1:length(y)
    yi = y(i);
    
    % Legea de variatie a corzii locale c(y)
    cy = c0 + yi * (ce - c0) / b;
    
    % Aproximarea portantei aerodinamice pa(y) determinata anterior
    pa = 7500 + 32468 * sqrt(1 - (yi/b)^2);
    
    % Componenta aerodinamica a momentului de focar distributed
    m_F = coeff_mF * (cy^2);
    
    % Evaluare in functie de pozitia pe intervale
    if yi >= 8.50 && yi <= 12.54
        % Intervalul 1: Varful aripii (fara combustibil)
        mt(i) = (pa * (a_CE - a_F) + pg * (a_CG - a_CE)) * cy + m_F;
        
    elseif yi >= 3.20 && yi < 8.50
        % Intervalul 2: Zona rezervorului de combustibil
        mt(i) = (pa * (a_CE - a_F) + pg * (a_CG - a_CE) + pgc * (a_CGc - a_CE)) * cy + m_F;
        
    elseif yi >= 1.65 && yi < 3.20
        % Intervalul 3: Zona dintre motor si fuzelaj (cu combustibil distribuit)
        mt(i) = (pa * (a_CE - a_F) + pg * (a_CG - a_CE) + pgc * (a_CGc - a_CE)) * cy + m_F;
        
    else
        % Intervalul 4: Zona sub fuzelaj (fara combustibil)
        mt(i) = (pa * (a_CE - a_F) + pg * (a_CG - a_CE)) * cy + m_F;
    end
end

% --- TRASAREA DIAGRAMEI ---
figure('Color', [1 1 1]);
plot(y, mt, 'Color', [0.1 0.6 0.2], 'LineWidth', 2.5);
hold on;

% Marcarea liniilor verticale de demarcatie a intervalelor pentru vizualizare
plot([1.65 1.65], [min(mt)-500 max(mt)+500], 'k--', 'LineWidth', 1);
plot([3.20 3.20], [min(mt)-500 max(mt)+500], 'k--', 'LineWidth', 1);
plot([8.50 8.50], [min(mt)-500 max(mt)+500], 'k--', 'LineWidth', 1);

% Adaugare texte explicative pentru regiuni
text(0.3, max(mt)-200, 'Fuzelaj', 'FontSize', 9, 'FontWeight', 'bold');
text(2.0, max(mt)-200, 'Motor', 'FontSize', 9, 'FontWeight', 'bold');
text(5.0, max(mt)-200, 'Caseta Combustibil', 'FontSize', 9, 'FontWeight', 'bold');
text(10.0, max(mt)-200, 'Varf Aripa', 'FontSize', 9, 'FontWeight', 'bold');

% Configurare estetica axelor
grid on; grid minor;
xlabel('Pozitia pe anvergura aripii y [m]', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Momentul de torsiune repartizat m_t [Nm/m]', 'FontSize', 11, 'FontWeight', 'bold');
title('Variatia momentului de torsiune distribuit m_t(y) - Fokker F28', 'FontSize', 12, 'FontWeight', 'bold');
xlim([0 13]);
ylim([min(mt)-400 max(mt)+400]);

hold off;