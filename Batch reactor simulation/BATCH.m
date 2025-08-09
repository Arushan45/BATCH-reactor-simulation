% Define variables for data given in the question
v = 40;           % volumetric flow rate
CAo = 6;          % Initial CA value
CBo = 0;          % Initial CB value
CCo = 0;          % Initial CC value
kone = 0.5;       % Rate constant for reaction 1
ktwo = 0.15;      % Rate constant for reaction 2

% Anonymous function
dydx = @(t,C) [-kone*C(1); kone*C(1)-ktwo*C(2); ktwo*C(2)];

% Other parameters for integration
Co = [CAo, CBo, CCo];              % Initial conditions
tspan = linspace(0, 15, 2000);     % High resolution time vector
[t, C] = ode15s(dydx, tspan, Co);  % ODE solver

% Create professional figure
figure('Position', [100, 100, 1000, 600], 'Color', 'white');

% Main concentration plot
plot(t, C(:,1), 'LineWidth', 3, 'Color', [0.85, 0.33, 0.10]);
hold on;
plot(t, C(:,2), 'LineWidth', 3, 'Color', [0, 0.45, 0.74]);
plot(t, C(:,3), 'LineWidth', 3, 'Color', [0.47, 0.67, 0.19]);

% Find and highlight maximum CB
[Cmax, max_idx] = max(C(:,2));
tmax = t(max_idx);
plot(tmax, Cmax, 'o', 'MarkerSize', 12, 'MarkerFaceColor', [0, 0.45, 0.74], ...
     'MarkerEdgeColor', 'black', 'LineWidth', 2);
plot([tmax, tmax], [0, Cmax], '--', 'Color', [0.5, 0.5, 0.5], 'LineWidth', 2);

% Professional formatting
grid on;
box on;
xlabel('Time (min)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Concentration (mol/L)', 'FontSize', 14, 'FontWeight', 'bold');
title('Concentration Profiles in Consecutive Reaction System (A → B → C)', ...
      'FontSize', 16, 'FontWeight', 'bold');
legend('C_A', 'C_B', 'C_C', 'FontSize', 12, 'Location', 'best');

% Set axis properties with better tick divisions
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
xlim([0, 15]);
ylim([0, CAo*1.1]);
xticks(0:1:15);  % X-axis ticks every 1 minute from 0 to 15
yticks(0:0.5:7); % Y-axis ticks every 0.5 mol/L from 0 to 7

% Add value annotations for important points
% Maximum CB point
text(tmax + 0.5, Cmax + 0.2, sprintf('Max C_B: %.3f mol/L\nat t = %.2f min\nVolume: %.1f L', Cmax, tmax, tmax*v), ...
     'FontSize', 11, 'BackgroundColor', 'white', 'EdgeColor', 'black', 'Padding', 'compact');

% Initial CA value
text(0.2, CAo - 0.3, sprintf('C_A_0 = %.1f mol/L', CAo), ...
     'FontSize', 10, 'BackgroundColor', 'yellow', 'EdgeColor', 'black');

% Final concentrations
final_CA = C(end,1);
final_CB = C(end,2);
final_CC = C(end,3);
text(12, final_CA + 0.2, sprintf('Final C_A = %.3f mol/L', final_CA), ...
     'FontSize', 10, 'BackgroundColor', 'white', 'EdgeColor', [0.85, 0.33, 0.10]);
text(12, final_CB + 0.2, sprintf('Final C_B = %.3f mol/L', final_CB), ...
     'FontSize', 10, 'BackgroundColor', 'white', 'EdgeColor', [0, 0.45, 0.74]);
text(12, final_CC - 0.3, sprintf('Final C_C = %.3f mol/L', final_CC), ...
     'FontSize', 10, 'BackgroundColor', 'white', 'EdgeColor', [0.47, 0.67, 0.19]);

% Rate constants annotation
text(1, 5.5, sprintf('k_1 = %.2f min^-^1\nk_2 = %.2f min^-^1', kone, ktwo), ...
     'FontSize', 11, 'BackgroundColor', 'lightblue', 'EdgeColor', 'black');

% Display results
disp("Time at maximum CB is " + tmax + " mins");
disp("Volume at max CB is " + tmax*v + " litres");
