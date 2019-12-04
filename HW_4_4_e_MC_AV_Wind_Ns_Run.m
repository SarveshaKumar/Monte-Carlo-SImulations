% Script/Function Name: HW_4_4_e_MC_AV_Wind_Ns_Run
% Version: 1.2
% Date: 2/15/18
% Author: Sarvesha Kumar Kombaiah Seetha
% Description: This script produces random wind that affects the motion 
% of an autonomous vehicle (AV) and plots the motion of the AV. It runs
% the simulation Ns times to get statistics on expected behavior.
clear
clc  
clf
% Input Module
% Single Run Params
Xo = 0        
% Initial AV position in X directon in m
Yo = 0        % Initial AV position in Y directon in m
C = 1000/3600; % m/km & sec/hr conversion to MKS
Vxo = 60*C    % Initial AV velocity in X directon in m/s
Vyo = 0       % Initial AV velocity in Y directon in m/s
Mav = 2       % Mass of the AV  
MIwy = 0      % Mean impulse delivered by wind in Y direction (kg m/s).
SDIwy = 10*C  % SD of impulse in Y direction in kg m/s.
Tend = 1000    % Simulation Duration in secd
t = 5        % Time Step in sec 
Nts = Tend/dt % Number of time steps
% Multiple Run Params
Ns = 2000
Nb = 10
Yf = zeros(1,Ns); % Final Y positions for each sample
% Calculation Module
for k = 1:Ns
    % Initialize vectors for each sample run
    Time = zeros(1,Nts+1);  % Initialize time vector
    X = zeros(1,Nts+1); % Initialize X position vector
    Y = zeros(1,Nts+1); % Initialize Y position vector
    T(1) = 0;X(1) = Xo;
    Y(1) = Yo;
    Vx = Vxo;
    Vy = Vyo;
    % Calculation Module
    for i = 2:1:Nts+1
        Time(i) = i*dt;       % Record time
        Imp = MIwy + SDIwy * randn;  % Generate wind impulse
        % find new V & X at end of dt.
        X(i) = X(i-1) + Vx * dt;
        Y(i) = Y(i-1) + Vy * dt + 0.5*Imp/Mav*dt;
        % Note that a = Imp/Mav * dt
        Vx = Vx;Vy = Vy + Imp/Mav;
    end
    Yf(k) = Y(Nts+1);
end
% Ouput Module
% Text
Yfmean = mean(Yf)
SDYf = std(Yf)
SEYfm = std(Yf)/sqrt(Ns)
% Graphical Output
histogram(Yf, Nb)