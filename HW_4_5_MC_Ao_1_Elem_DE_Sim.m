% Script/Function Name: HW_4_5_MC_Ao_1_Elem_DE_Sim
% Version: 3.0
% Date: 2/20/18
% Author: Sarvesha Kumar Kombaiah Seetha
% Description: This scritpt calculates how the mean Ao of a 1-Element 
% System evolves over times using descrete-event MC simulation.
% It calculates the SD and SE for Ao and plots Ao(t).
% The inputs are the MTBCF and the MDT, and it assumes these have 
% exp dist.
clc
clear
clf
tic
% Input Module
MTBFa = 100    % Theoretical Mean time between failures (TBF) (in hrs)
MDTa = 20      % Theoretical Mean down time (DT) (in hrs)
Nf = 2000      % Number of failures (MC samples/iterations)
Nr = Nf        % Number of repairs over period.
Nb = 10TBFa = zeros(1,Nf);   % Create/initialize TBCF Vector 
DTa = zeros(1,Nr);    % Create/initialize DT Vector 
FailCnt = zeros(1,Nf);     % Failure 
counterTime = zeros(1,Nf+Nr+1);   % Create/intialize Timeline vector
Ao = zeros(1,Nf+Nr+1);     % Create/initialize Ao(t) vector
MAomc = zeros(1,Nf+Nr+1);  % Create/initialize mean Ao(t) 
vectorAo(1) = 1;             % System is available at t=0
MAomc(1) = 1;
SumTf = 0;             % Initialize sum of times between failureSum
Tr = 0;             % Initialize sum of down times
% Calculation Module
% Generate TBFs & DTs using expdistribution
pdf = makedist('exponential', 'mu', MTBFa);
pdr = makedist('exponential', 'mu', MDTa);
for i = 1:1:Nf
    TBFa(i) = random(pdf);
    DTa(i) = random(pdr);
end% Exectute timeline.  
% Time of each failure (even #) and repair (odd #) is recorded  
for j = 1:1:Nf
    FailCnt(i) = i;
    % Time of failue (i) = time of last repair + time to failure
    Time(2*j) = Time(2*j-1) + TBFa(j);SumTf = SumTf + TBFa(j);       
    % Sum of TBCFas at time 2i
    % Time repair complete (i) = time of failuire + time to repair
    Time(2*j+1) = Time(2*j) + DTa(j);SumTr = SumTr + DTa(j);         
    % Sum of DTas at time 2i+1
    Ao(2*j) =  Ao(2*j-1);   % Ao at time 2i over last fail-repair cycle
    Ao(2*j+1) = TBFa(j)/(TBFa(j)+DTa(j)); % Aoover current cycle   
    MAomc(2*j)= SumTf/(SumTf+SumTr);  % Time-averaged (CRM) Ao at t=2i
    MAomc(2*j+1)= SumTf/(SumTf+SumTr); % Time-averaged Ao at time 2i+1
end
% End Calc & Output Module
MTBFmc = SumTf/Nf
SDtbcf = std(TBFa)
SEtbcf = SDtbcf/sqrt(Nf)
MDTmc = SumTr/Nr
SDdt = std(DTa)
SEdr = SDdt/sqrt(Nr)
T = Time(Nf+Nr+1)
Aossan = MTBFa/(MTBFa+MDTa)
Aossmc = MTBFmc/(MTBFmc+MDTmc)
MeanAomc = MAomc(Nf+Nr+1)
SDao = std(Ao)
SEao = SDao/sqrt(Nf)
toc
%Graphical Output:
hist(Ao,Nb)   % Note that histogram double counts each availability.
pause
plot(Time,MAomc)
axis([0 T 0 1])