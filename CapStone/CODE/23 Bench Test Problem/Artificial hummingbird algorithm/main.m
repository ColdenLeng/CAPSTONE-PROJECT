%--------------------------------------------------------------------------
% AHA code v1.0.
% Developed in MATLAB R2016b
% The code is based on the following paper:
% W. Zhao, L. Wang and S. Mirjalili, Artificial hummingbird algorithm: A
% new bio-inspired optimizer with its engineering applications, Computer
% Methods in Applied Mechanics and Engineering (2021) 114194, https:
% //doi.org/10.1016/j.cma.2021.114194.
%--------------------------------------------------------------------------

clc;
clear;
MaxIteration=1000;
PopSize=30;
FunIndex=8; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)

mean_BestF = zeros(1,25)
mean_iteration = zeros(1,25)

for i=1:25
    [BestX,BestF,HisBestF,VisitTable,iteration_record]=AHA(FunIndex,MaxIteration,PopSize);
    mean_BestF(i) = BestF;
    mean_iteration(i) = iteration_record*PopSize;
end

display(['FunIndex=', num2str(FunIndex)]);
%display(['The best fitness is: ', num2str(BestF)]);
%display(['The best solution is: ', num2str(BestX)]);
display("Mean of Best fitness " + mean(mean_BestF));
display("Std of Best fitness " + std(mean_BestF));
display("Mean of iteration " + mean(mean_iteration));

if BestF>0
    semilogy(HisBestF,'r','LineWidth',2);
else
    plot(HisBestF,'r','LineWidth',2);
end
xlabel('Iterations');
ylabel('Fitness');
title(['F',num2str(FunIndex)]);










