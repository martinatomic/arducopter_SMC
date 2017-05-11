%%%%% DIPLOMSKI RAD %%%%%
clear; clc;

%% Inicijalizacija konstanti

% MASA
m = 0.208;                  % Mass of a movable mass
mq = 2.083;                 % Quadrotor body mass (including motors)
M = mq + 4 * m;             % Total mass

% DIMENZIJE
lm = 0.17;                  % Mass path max length
arm_offset = 0.08;          % Motor - arm offset from the origin
l = lm + arm_offset;        % Motor - arm length
l_rot = 0.265               % Rotor - center length

% MOMENTI INERCIJE - BODY (WITHOUT MASSES) (yaml)
Iq_xx = 0.00528525; 
Iq_yy = 0.00528250;
Iq_zz = 0.0104;
Iq = [Iq_xx 0 0; 0 Iq_yy 0; 0 0 Iq_zz];

% MOMENT INERCIJE LETJELICE Iyy
Iyy_b = 0.00528250;
Iyy_mm = m * (lm/2)^2;      % Pretpostavka tockaste mase
I_yy = Iyy_b + 2 * Iyy_mm

% IDENTIFICIRANI MOMENT 
I_yy = 0.0857;

% Ostali parametri
g = 9.81;                   % Gravity constant
cd = 0;                     % Drag constant (translational)

beta = deg2rad(0);          % Inclination angle of the motor arms 0 deg
beta_gm = deg2rad(0);       % This is additional angle of the gas motor prop w.r.t. the motor arm MATIJA

zm = 0;                     % Mass displacement iz z-axis
Km = 1;                     % Voltage to acceleration
Tr = 12.24268;              % Transmission rate [m/rad]


%% GAS MOTOR PARAMS

Tgm = 0.2;                  % Time constant
w_gm_n = 7000 / 60 * 2*pi;  % rpm to rad/s
F_n = 25 * 9.81;
b_gm_f = F_n / (w_gm_n^2);
b_gm_m = 0.01;              % Lucky guess

w_gm_0 = sqrt(M*g/4/b_gm_f);
F0 = b_gm_f * w_gm_0^2;

zeta = [1 -1 1 -1];         % [cw ccw cw ccw]

%% Mass PID default params

kp_mp = 25;
ki_mp = 0.25 ;
kd_mp = 0.015;

kp_mv = 0.6;
ki_mv = 06;
kd_mv = 0.01;

%% Height control params

% Velocity loop
kp_vz = 75; 
ki_vz = 20;
kd_vz = 10;

% Position loop
kp_z = 4;
ki_z = 0;
kd_z = 1;

%% Referenca prefiltar

Tf1 = 0.12;
Tf2 = 0.12;

%% Q - filter
T_obz1 = 5;
T_obz2 = 5;
D = 0.01;

%% RUN SIM
%sim('morus_uav_smc_EXT');

%% PLOT

figure
plot(smc(:,1), smc(:,2))
hold on;
plot(smc(:,1), smc(:,3))
grid on; 
title('Odziv na referencu')


figure 
plot(masa_ref(:,1), masa_ref(:,2))
title('Referenca na masu')
grid on;

figure
plot(delta(:,1), delta(:,2))
grid on;
title('DOB \delta')

