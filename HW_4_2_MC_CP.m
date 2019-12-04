% Program: HW_4_2_MC_CP
% Author: Sarvesha Kumar Kombaiah Seetha
% Version: 3.0
% Date: 2/20/18
% Descripiton: This program uses Monte Carlo simulation with the 
% Longest Path CP Algorithm to obtain the distribution of of project% duration times.
clear;
clf;
clc;
% Input
% Specify Nodes:
Names ={'Start Project', 'Node 2', 'Node 3','Node 4', 'Node 5', 'Node 6', 'Node 7','Node 8', 'End Project'};
% Specify Edge 
DataN1 =  [1  1   2  3  3  3    4  5  6   7  8];
N2 =  [2  3   4  4  5  6    7  7  8   9  9];
Dur = [6 4.3 3.3 9 10 12.2 8.8 2 3.3 15 8.8];
% Define 
GraphG = digraph(N1, N2, Dur, Names);
% Plot Graph  
plot(G,'EdgeLabel', G.Edges.Weight)
% Task Mean and SD Data
Nn = 9;    
% Number of Nodes
Mean = [0 6 4.3 0  0  0   0  0  0; 0 0  0 3.3 0  0   0  0  0 ;0 0  0  9 10 12.2 0  0  0 ; 0 0  0  0  0  0  8.8 0  0;0 0  0  0  0  0   2  0  0; 0 0  0  0  0  0   0 3.3 0;0 0  0  0  0  0   0  0 15; 0 0  0  0  0  0   0  0 8.8;0 0  0  0  0  0   0  0  0];SD =   [0 0.7 1 0  0   0  0  0  0; 0  0  0 1  0   0  0  0  0 ;0  0  0 1 1.7 1.8 0  0  0 ; 0  0  0 0  0   0 1.2 0  0;0  0  0 0  0   0 0.3 0  0; 0  0  0 0  0   0  0 0.7 0;0  0  0 0  0   0  0  0 1.7; 0  0  0 0  0   0  0  0 0.8;0  0  0 0  0   0  0  0  0];
% Number of trials/samples
Ns = 2000
Nb = 20
CritPathLn = zeros(1,Ns); % Vector holding critical paths
NSamePath = 0;      % Number of times CP was different from mean case.
SampNum = zeros(1,Ns);  % Vector of sample numbers
% Main Program
% Generate Random Numbers
for n = 1:Ns
    SampNum(n) = n;
    % 9x9 matrix of normally dist deviations from mean
    R = [0 0.7*randn 1*rand 0  0   0  0  0  0; 0  0  0 1*randn  0   0  0  0  0 ;0  0  0 1*randn 1.7*randn 1.8*randn 0  0  0 ; 0  0  0 0  0   0 1.2*randn 0  0;0  0  0 0  0   0 0.3*randn 0  0; 0  0  0 0  0   0  0 0.7*randn 0;0  0  0 0  0   0  0  0 1.7*randn; 0  0  0 0  0   0  0  0 0.8*randn;0  0  0 0  0   0  0  0  0];
    D = Mean + R;
    % Calculate and plot the longest path
    CLP = zeros(Nn,1);    
    % Cumulative Longest Path 
    CostPath = zeros(Nn,1);   
    % Path 
    vectorPath(1) = 1;            
    % Path Starts at Node 1
    for k = 2:Nn
        for m = k:-1:1       
            % Check for longest path to previous nodes
            if D(m,k) ~= 0
                PLPn = CLP(m) + D(m,k);  % Potential new LP to k (from m)
                if PLPn > CLP(k)         % If it is a longer path, 
                    CLP(k) = PLPn;         % Set new LP to 
                    kPath(k-1) = m;         % Source node for new LP to k
                end
            end
        end
    end
    Path(Nn) = Nn;                 % Path Ends at Node NnCritPath
    Ln(n) = CLP(Nn);
    % Calc CP 
    CRMifn == 1
    CPcrm(1) = CritPathLn(1)
    else
        CPcrm(n) = ((n-1)* CPcrm(n-1) + CritPathLn(n))/n; 
end
% Path 
% Debugging line
if Path == [1; 1; 3; 3; 3; 4; 6; 7; 9]
    NSamePath = NSamePath + 1;
end
% Text Output
Crit_Path_Len = mean(CritPathLn)
SD = std(CritPathLn)
SE = SD/sqrt(Ns)
NSamePath
% Graphical Output
hist(CritPathLn,Nb) 
% Graph Results
pause
plot(SampNum, CPcrm)
axis([0,Ns,0, 40])