%___________________________________________________________________%
%  Snake Optimizer (SO) source codes version 1.0                    %
%                                                                   %
%  Developed in MATLAB R2021b                                       %
%                                                                   %
%  Author and programmer:  Fatma Hashim & Abdelazim G. Hussien      %
%                                                                   %
%         e-Mail: fatma_hashim@h-eng.helwan.edu.eg                  %
%                 abdelazim.hussien@liu.se                          %
%                 aga08@fayoum.edu.eg                               %
%                                                                   %
%                                                                   %
%   Main paper: Fatma Hashim & Abdelazim G. Hussien                 %
%               Knowledge-based Systems                             %
%               in press,                                           %
%               DOI: 10.1016/j.knosys.2022.108320                   %
%                                                                   %
%___________________________________________________________________%
clear all
clc

F_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
popsize=30; % Number of search agents

[lb,ub,dim,fobj,ans]=Get_Functions_details(F_name);

Max_iter=1000; % Maximum iteration
Stp_crit=10e-6; % Stopping criteria
runs=25; % Number of indenpendt runs
solutionArr=zeros(1, runs);
runArr=zeros(1, runs);

for i=1:runs
    % [Xfood, Xvalue,CNVG,iteration] = SO(popsize,Max_iter,fitfun,dim,lb,ub,ans);
    [Stp_runs,Xfood,Xvalue,CNVG] = SO(popsize,ans,Max_iter,Stp_crit,lb,ub,dim,fobj);
    solutionArr(i) = Xvalue;
    runArr(i) = Stp_runs;
end

display([num2str(F_name),' solution: ', num2str(ans)]);
display(['Max iteration:', num2str(Max_iter)]);
display(['Population: ', num2str(popsize)]);
% display(['The best solution of ', num2str(Max_iter),' iterations obtained by SHO is : ', num2str(ObjectiveFitness)]);
% display(['The best optimal sea horse of the objective funciton found by SHO is : ', num2str(ObjectivePosition)]);
% display(solutionArr);
display(['The Mean of the best solution in ', num2str(runs),' indenpendt runs obtained by SHO is : ', num2str(mean(solutionArr))]);
display(['The STD of the best solution in ', num2str(runs),' indenpendt runs obtained by SHO is : ', num2str(std(solutionArr))]);
display(['The Mean of stopping iteration in ', num2str(runs),' indenpendt runs obtained by SHO is : ', num2str(mean(runArr))]);
%{
figure,
plot(CNVG,'Color', 'r')
xlim([1 1000]);

display(['The best solution : ', num2str(Xfood)]);
display(['The best fitness : ', num2str(Xvalue)]);
%}
