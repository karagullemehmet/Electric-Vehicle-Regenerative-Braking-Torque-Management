%% =======================================================================
% Appendix A – MATLAB Code for Regenerative Braking Simulation
% Author: Mehmet Karagülle
% Model: EV_Powertrain
% Purpose: Export and plot SOC, Battery Current, T_cell, Torque and Speed
% ========================================================================

clear; clc; close all;

model = 'Regenerative_Braking';
simTime = 300;   % Adjust according your simulation time

load_system(model);

%% ========================== Run Simulation ==============================
simOut = sim(model, ...
    'StopTime', num2str(simTime), ...
    'SrcWorkspace', 'base', ...
    'SaveOutput', 'on');

%% ===================== Extract Logged Signals ===========================

SOC      = simOut.get('SOC');          % From To Workspace block
Ibatt    = simOut.get('I_batt');
Tcell    = simOut.get('Tcell');
Speed    = simOut.get('speed');
Treq     = simOut.get('T_req_cmd');
Tm_req   = simOut.get('T_m_req');
WheelT   = simOut.get('Wheel_Torque_Nm');
Te_req   = simOut.get('T_e_cmd');

% ------------------------ Time Vector Generation -------------------------
% Each signal may have different sampling → generate time individually
t_SOC    = linspace(0, simTime, length(SOC));
t_Ibatt  = linspace(0, simTime, length(Ibatt));
t_Tcell  = linspace(0, simTime, length(Tcell));
t_spd    = linspace(0, simTime, length(Speed));
t_Treq   = linspace(0, simTime, length(Treq));
t_Tm     = linspace(0, simTime, length(Tm_req));
t_WT     = linspace(0, simTime, length(WheelT));
t_Te     = linspace(0, simTime, length(Te_req));

%% ========================== Plot Results ================================

figure('Name','Regenerative Braking Results','Color','w','Position',[150 80 1100 1200]);

% 1 – SOC
subplot(4,2,1); 
plot(t_SOC, SOC, 'LineWidth', 1.8); grid on;
xlabel('Time (s)'); ylabel('SOC (%)'); title('Battery SOC');

% 2 – Battery Current
subplot(4,2,2); 
plot(t_Ibatt, Ibatt, 'LineWidth', 1.8); grid on;
xlabel('Time (s)'); ylabel('I_{batt} (A)');
title('Battery Current');

% 3 – Cell Temperature / Terminal Voltage Signal
subplot(4,2,3); 
plot(t_Tcell, Tcell, 'LineWidth', 1.8); grid on;
xlabel('Time (s)'); ylabel('T_{cell} (V or °C)');
title('Battery Terminal Condition');

% 4 – Vehicle Speed
subplot(4,2,4); 
plot(t_spd, Speed, 'LineWidth', 1.8); grid on;
xlabel('Time (s)'); ylabel('Speed (km/h)');
title('Vehicle Speed');

% 5 – Requested Torque (ECU Output)
subplot(4,2,5); 
plot(t_Treq, Treq, 'LineWidth', 1.8); grid on;
xlabel('Time (s)'); ylabel('T_{req} (Nm)');
title('Requested Torque from ECU');

% 6 – Motor/Mechanical Torque
subplot(4,2,6); 
hold on; grid on;
plot(t_Tm, Tm_req, 'LineWidth', 1.8);
plot(t_WT, WheelT, 'LineWidth', 1.4);
xlabel('Time (s)'); ylabel('Torque (Nm)');
title('Motor/Wheel Torque Comparison');
legend('Motor Torque','Wheel Torque');

%7- Regenerative Torque 
subplot(4,2,7); 
hold on; grid on;
plot(t_Te, Te_req, 'LineWidth', 1.8);
xlabel('Time (s)'); ylabel('Torque (Nm)');
title('Regenerative Torque');


%% =========================== DONE ======================================
disp("Plots generated successfully.");
