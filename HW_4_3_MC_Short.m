% Configuration Data:
% Program: HW_4_3_MC_Short
% Author: Sarvesha Kumar Kombaiah Seetha
% Version: 1.2
% Date: 2/28/18
clear
clf
clc
% Inputs  
% Specify Nodes:
Names ={'Source', 'N2', 'N3', 'N4', 'N5', 'N6', 'Dest'};
% Specify Edge Data
% From Node (Node 1 = Source)
FrmNd = [1  1  2  3  2  3  3  4  5  5  6  4  5  6];    
ToNd =  [2  3  3  2  4  5  6  5  4  6  5  7  7  7];
MeanCost =  [60 30 10 10 30 50 70 10 10 10 10 50 30 10];
% Plot Graph%  
plot(G,'EdgeLabel', G.Edges.Weight);
Ns = 1000
Nb = 10  
SPathLn = zeros(Ns,1);
SampCnt = zeros(Ns,1);
SPcrm = zeros(Ns,1);
% Main Program
for i = 1:Ns
    SampCnt = i;
    R = 0.1*[rand() 0   0    0   0    0   0    0   0     0   0    0   0    0; 0   rand() 0    0   0    0   0    0   0     0   0    0   0    0;0      0 rand() 0   0    0   0    0   0     0   0    0   0    0;0      0   0 rand() 0    0   0    0   0     0   0    0   0    0;0      0   0    0rand() 0   0    0   0     0   0    0   0    0;0      0   0    0   0 rand() 0    0   0     0   0    0   0    0;0      0   0    0   0    0 rand() 0   0     0   0    0   0    0;0      0   0    0   0    0   0 rand() 0     00    0   0    0;0      0   0    0   0    0   0    0  rand() 0   0    0   0    0;0      0   0    0   0    0   0    0   0  rand() 0    0   0    0;0      0   0    0   0    0   0    0   0     0 rand() 0   0    0;0      0   0    0   0    0   0    0   0     0   0 rand() 0    0;0      0   0    0   0    0   0    0   0     0   0    0 rand() 0;0      0   0    0   0    0   0    0   0     0   0    0   0 rand()];
    MCCost = MeanCost+MeanCost*R;
    % Define 
    GraphG = digraph(FrmNd, ToNd, MCCost, Names);
    % Calculate and plot the shortest path
    [ShortPath,Length] = shortestpath(G,'Source','Dest');
    SPathLn(i) = Length;
    % Calc CP CRM
    if i == 1
        SPcrm(1) = SPathLn(1);
    else
        SPcrm(i) = ((i-1)* SPcrm(i-1) + SPathLn(i))/i; 
    end
end
% Text Output
MeanPathLen = mean(SPathLn)
SD = std(SPathLn)
SE = SD/sqrt(Ns)
% Graphical Output
hist(SPathLn,Nb)   
% Graph Results
pause
plot(SampCnt, SPcrm)
axis([0, Ns, 0, 120])