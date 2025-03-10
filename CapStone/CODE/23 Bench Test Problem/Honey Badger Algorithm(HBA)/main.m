%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Honey Badger Algorithm source code 
%  paper:
%     Hashim, Fatma A., Essam H. Houssein, Kashif Hussain, Mai S. %     Mabrouk, Walid Al-Atabany. 
%     "Honey Badger Algorithm: New Metaheuristic Algorithm for %  %     Solving Optimization Problems." 
%     Mathematics and Computers in Simulation, 2021.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

clc;clear all;
close all;

%{
fitfun = @sumsqu;
dim=30;
T=1000;
Lb=-10;
Ub=10;
%}
fitfun = 'F3'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
T=1000;
N=30;
indep_run = 25;
mean_fitness = zeros(1,indep_run);
mean_iteration = zeros(1,indep_run);
[Lb,Ub,dim,fitfun,ans] = sumsqu(fitfun);

for i=1:indep_run
    [xmin,fmin,CNVG,stopping_run]=HBA(fitfun,dim,Lb,Ub,T,N,ans);
    mean_fitness(i) = fmin;
    mean_iteration(i) = stopping_run*N;
end

disp("Mean fitness " + mean(mean_fitness));
disp("Std fitness " + std(mean_fitness));
disp("Mean iteration " + mean(mean_iteration));
%{
figure,
semilogy(CNVG,'r')
xlim([0 T]);
title('Convergence curve')
xlabel('Iteration');
ylabel('Best fitness obtained so far');
legend('HBA')

display(['The best location= ', num2str(xmin)]);
display(['The best fitness score = ', num2str(fmin)]);
%}
        

