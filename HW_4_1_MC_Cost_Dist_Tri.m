% Program: HW_4_1_MC_Cost_Dist_Tri
% Author: Sarvesha Kumar Kombaiah Seetha
% Version: 2.2
% Date: 2/5/18
% Description: This program uses Monte Carlo simulation to generate
% random tasks costs from a triangular distribution of staff hours and 
%per staff costs.
clear;
clf;
clc;
% Input
Ns = 1000;     
% Number of samples
% Task Labour Hours Data (in hrs)
HrMin = 16* [4 2 1 6 5 7 5 1 2 10 6]
HrMax = 16* [8 8 7 12 15 18 12 3 6 20 11]
HrLkly = 16* [6 4 3 9 10 12 9 2 3 15 9]
% Hrly Cost Data (in $/hr)
CLMin =  [100 100 100 100 100 90 90 90 90 90 90]
CLMax =  [150 150 150 150 150 110 110 110 110 110 110]
CLLkly = [120 120 120 120 120 100 100 100 100 100 100]
CostProj = zeros(1,Ns);  % Vector holding MC-generated Task costs
CRMProjCost = zeros(1,Ns); % Vector holding cum running mean Task 
costsSample = zeros(1,Ns);  % Vector holding sample numnber
Nb = 10;        % Number of bins
% Main Program
% Generate Distributions
for j = 1:11
    pdh(j) = makedist('triangular', 'a', HrMin(j), 'b', HrLkly(j), 'c', HrMax(j));
    pdcl(j) = makedist('triangular', 'a', CLMin(j), 'b', CLLkly(j), 'c', CLMax(j));
    % Seed the RN Generation Algorithmend
    % Run 1st Sample & Seed CRM Project 
    CostSample(1) = 1;
    CostProj(1) = 0;
    for j = 1:11   
        % Sum over project tasks
        CostProj(1) = CostProj(1) + random(pdh(j))*random(pdcl(j));
        CRMProjCost(1) = CostProj(1);
    end
    % Run 1st Samples
    for i= 2:Ns
        Sample(i) = i;
        CostProj(i) = 0;
        for j = 1:11   
            % Sum over project tasks
            CostProj(i) = CostProj(i) + random(pdh(j))*random(pdcl(j));
        end
        % Update the Cum Run Mean 
        CRMProjCost(i) = ((i-1)* CRMProjCost(i-1) + CostProj(i))/i;
    end
    % Text Output
    ProjCostmean = mean(CostProj)
    ProjCostcumrm = CRMProjCost(Ns)
    SD = std(CostProj)
    SE = SD/sqrt(Ns)
    % Graphical Output
    hist(CostProj,Nb)   
    % Graph Results
    pause
    plot(Sample, CRMProjCost)% axis([0,Sample(Ns),0, Tsh*Csh*1.3])