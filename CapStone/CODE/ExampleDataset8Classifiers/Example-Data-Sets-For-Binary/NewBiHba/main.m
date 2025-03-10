%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Honey Badger Algorithm source code 
%  paper:
%     Hashim, Fatma A., Essam H. Houssein, Kashif Hussain, Mai S. %     Mabrouk, Walid Al-Atabany. 
%     "Honey Badger Algorithm: New Metaheuristic Algorithm for %  %     Solving Optimization Problems." 
%     Mathematics and Computers in Simulation, 2021.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%doing Adaboost now<--
clc;clear;
close all;

%{
fitfun = @sumsqu;
dim=30;
T=1000;
Lb=-10;
Ub=10;
%}

%{
fitfun = 'F3';
T=1000;
N=30;
%}

%load Datasets\BreastCancer_data.mat; % dataset #1
%load Datasets\BreastEW_data.mat; % dataset #2
%load Datasets\CongressEW_data.mat; % dataset #3
%load Datasets\Exactly_data.mat; % dataset #4
%load Datasets\Exactly2_data.mat; % dataset #5
%load Datasets\HeartEW_data.mat; % dataset #6
%load Datasets\ionosphere.mat; % dataset #7
%load Datasets\KrVsKpEW_data.mat; % dataset #8
%load Datasets\Lymphography_data.mat; % dataset #9
%load Datasets\M-of-n_data.mat; % dataset #10
%load Datasets\PenglungEW_data.mat; % dataset #11
%load Datasets\Sonar_data.mat; % dataset #12
%load Datasets\SpectEW_data.mat; % dataset #13
%load Datasets\Tic-tac-toe_data.mat; % dataset #14
%load Datasets\Vote_data.mat; % dataset #15
%load Datasets\WaveformEW_data.mat; % dataset #16
%load Datasets\Wine_data.mat; % dataset #17
%load Datasets/Zoo_data.mat; % dataset #18

ho=0.2;


N = 30;%popssize
%T = 10;

Stp_crit= 10e-6;
% dim = size(feat,2);
% objfunc = @FitnessFunction;
% lb = 0;
% ub = 1;

% lb = lb*ones(1,dim);
% ub = ub*ones(1,dim);

% ub = ub*ones(1,dim);
% lb = lb*ones(1,dim);

runs = 10;
tmax = 100;

AccArr = zeros(1, runs);
StpArr = zeros(1, runs);
solu_arr = zeros(1, runs);

file = fopen("Result\result.txt","w");

message = "dataset 1";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\BreastCancer_data.mat; % dataset #1
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 2";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\BreastEW_data.mat; % dataset #2
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 3";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\CongressEW_data.mat; % dataset #3
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 4";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Exactly_data.mat; % dataset #4
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 5";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Exactly2_data.mat; % dataset #5
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 6";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\HeartEW_data.mat; % dataset #6
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 7";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\ionosphere.mat; % dataset #7
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 8";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\KrVsKpEW_data.mat; % dataset #8
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 10";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\M-of-n_data.mat; % dataset #10
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 12";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Sonar_data.mat; % dataset #12
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 13";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\SpectEW_data.mat; % dataset #13
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 14";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Tic-tac-toe_data.mat; % dataset #14
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

message = "dataset 15";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Vote_data.mat; % dataset #15
BinaryClass(feat,label,N,tmax,Stp_crit,runs,ho,file,message);

fclose(file);


%{
for i = 1:runs
    disp(['Run, ', num2str(i)]);
    HO = cvpartition(label, 'HoldOut',ho,'Stratify',false);
    [sFeat,Sf,Nf,Xprey, Food_Score,CNVG,stopping_run] = HBA(feat,label,objfunc, dim,lb,ub,tmax,N,Stp_crit,HO);
    Acc = KNN(sFeat, label, HO);
    disp('');
    fprintf('\n');
    disp(['Accuracy: ', num2str(Acc)]);
    AccArr(i) = Acc;
    StpArr(i) = stopping_run;
    solu_arr(i) = Food_Score;
    disp('');
end

disp('');

for i = 1:runs
    disp('');
    disp(['Run ', num2str(i), ':Accuracy: ', num2str(AccArr(i)),', Stopping Round:', num2str(StpArr(i))]);
end

disp('');

display(['Mean of the best accuracy in ', num2str(runs),'indenpendt runs obtained by AFT is: ', num2str(mean(solu_arr))]);
display(['Std of the best accuracy in ', num2str(runs),'indenpendt runs obtained by AFY is: ', num2str(std(solu_arr))]);
display(['Mean of the Acc run in ', num2str(runs),'indenpendt runs obtained by AFY is: ', num2str(mean(AccArr))]);
display(['Mean of the Stping run in ', num2str(runs),'indenpendt runs obtained by AFY is: ', num2str(mean(StpArr))]);

%}

%{
indep_run = 25;
mean_fitness = zeros(1,indep_run);
mean_iteration = zeros(1,indep_run);
[Lb,Ub,dim,fitfun,ans] = sumsqu(fitfun);
%}

%{
for i=1:indep_run
    [xmin,fmin,CNVG,stopping_run]=HBA(fitfun,dim,Lb,Ub,T,N,ans);
    mean_fitness(i) = fmin;
    mean_iteration(i) = stopping_run*N;
end

disp("Mean fitness " + mean(mean_fitness));
disp("Std fitness " + std(mean_fitness));
disp("Mean iteration stp " + mean(mean_iteration));
%}
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
        

