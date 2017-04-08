m = 0.25; % mass of a movable mass
mq = 30.8; % mass of the quadrotor body (including gas motors) IZRACUNATI
M = mq + 4 * m;  % total mass
g = 9.81;   %gravity constant
cd = 0;     % drag constant (translational) BILO 1.5
beta = deg2rad(0);   % inclination angle of the motor arms
beta_gm = deg2rad(0); % this is additional angle of the gas motor prop w.r.t. the motor arm MATIJA
zm = 0.05; % mass displacement iz z-axis OKO 0, MOZDA MLAO NEGATIVNO - TREBA IZRACUNATI
Km = 1; % voltage to acceleration

lm = 0.6; % mass path maximal length
arm_offset = 0.1; % motor arm offset from the origin IZMJERITI
l = lm + arm_offset; % motor arm length
l_rot = 0.1 % IZRACUNATI
% rotoc-centar uvesti jos
Tr = 100; % transmission rate
Iq_xx = 5.5268 + 0.2;  % moment of inertia of the quadrotor body (without masses)
Iq_yy = 5.5268 + 0.2;
Iq_zz = 6.8854 + 0.4;
Iq = [Iq_xx 0 0; 0 Iq_yy 0; 0 0 Iq_zz];

%%
% gas motor params
Tgm = 0.2;  % time constant
w_gm_n = 7000 / 60 * 2*pi; % rpm to rad/s
F_n = 25 * 9.81;
b_gm_f = F_n / (w_gm_n^2);
b_gm_m = 0.01; % lucky guess

w_gm_0 = sqrt(M*g/4/b_gm_f);
F0 = b_gm_f * w_gm_0^2;

zeta = [1 -1 1 -1]; % cw ccw cw ccw

%% 
% mass PID default params
kp_mp = 25;
ki_mp = 0.25 ;
kd_mp = 0.015;
kp_mv = 0.6;
ki_mv = 0.6;
kd_mv = 0.01;

%%
% height control params
% velocity loop
kp_vz = 75; 
ki_vz = 20;
kd_vz = 10;

% position loop
kp_z = 4;
ki_z = 0;
kd_z = 1;
%%
% roll and pitch PID control params
kp_roll = 1;
ki_roll = 0;
kd_roll = 0;

kp_roll_rate = 1.5;
ki_roll_rate = 0;
kd_roll_rate = 0;

kp_pitch = 1;
ki_pitch = 0;
kd_pitch = 0;

kp_pitch_rate = 1.5;
ki_pitch_rate = 0;
kd_pitch_rate = 0;

%% Referenca prefiltar

Tf1 = 2;
Tf2 = 2;

%% PLOT

figure
plot(smc(:,1), smc(:,2), 'LineWidth', 1.5)
hold on;
plot(smc(:,1), smc(:,3))
grid on; 