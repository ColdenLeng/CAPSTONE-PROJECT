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
close;

%Adaboost

MaxIt = 100;
Stp_crit = 10e-6;
runs = 10;
AccArr = zeros(1, runs);
StpArr = zeros(1, runs);
solu_arr = zeros(1,runs);

ho = 0.2;


BenFUnctions = @FitnessFunction;
lb = 0;
ub = 1;
%dim = size(feat,2);
nPop=30;

file = fopen("Result\result.txt","w");

message = "dataset 9";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Lymphography_data.mat; % dataset #9
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 11";
fprintf(file,message);
fprintf(file,"\n\n");
%load Datasets\PenglungEW_data.mat; % dataset #11
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 16";
fprintf(file,message);
fprintf(file,"\n\n");
%load Datasets\WaveformEW_data.mat; % dataset #16
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 17";
fprintf(file,message);
fprintf(file,"\n\n");
%load Datasets\Wine_data.mat; % dataset #17
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 18";
fprintf(file,message);
fprintf(file,"\n\n");
%load Datasets\Zoo_data.mat; % dataset #18
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

%{
message = "dataset 1";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\BreastCancer_data.mat; % dataset #1
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 2";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\BreastEW_data.mat; % dataset #2
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 3";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\CongressEW_data.mat; % dataset #3
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 4";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Exactly_data.mat; % dataset #4
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 5";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Exactly2_data.mat; % dataset #5
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 6";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\HeartEW_data.mat; % dataset #6
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 7";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\ionosphere.mat; % dataset #7
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 8";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\KrVsKpEW_data.mat; % dataset #8
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 10";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\M-of-n_data.mat; % dataset #10
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 12";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Sonar_data.mat; % dataset #12
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 13";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\SpectEW_data.mat; % dataset #13
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 14";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Tic-tac-toe_data.mat; % dataset #14
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);

message = "dataset 15";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Vote_data.mat; % dataset #15
BinaryClass(feat,label,nPop,MaxIt,Stp_crit,runs,ho,file,message);
%}
fclose(file);

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

% ho = 0.2;
% 
% 
% BenFUnctions = @FitnessFunction;
% lb = 0;
% ub = 1;
% dim = size(feat,2);
% nPop=30;
% ub = ub*ones(1, dim);
% lb = lb*ones(1, dim);
% disp('');
% for i = 1:runs
%     disp(['Run ', num2str(i)]);
%     HO = cvpartition(label,'HoldOut',ho,'Stratify',false);
%     [Sf,Nf,sFeat,BestX,BestF,HisBestFit,VisitTable,Stp_Runs]=AHA(feat,label,MaxIt,nPop,lb,ub,dim,BenFUnctions,Stp_crit,HO);
%     Acc = KNN(sFeat, label, HO);
%     disp('');
%     disp(['Accuracy: ', num2str(Acc)]);
%     AccArr(i) = Acc;
%     StpArr(i)=Stp_Runs;
%     solu_arr(i) = BestF;
%     disp('');
% end
% 
% disp('');
% 
% for i=1:runs
%     disp(['Run ', num2str(i),': Accuracy: ', num2str(AccArr(i)),', Stopping Round: ', num2str(StpArr(i))]);
% end
% 
% disp('');
% 
% display(['Mean of the best acc in ', num2str(runs), ', indenpendt runs obtained by AFT is: ', num2str(mean(solu_arr))]);
% display(['STD of the best acc in ', num2str(runs), ', indenpendt runs obtained by AFY is: ', num2str(std(solu_arr))]);
% display(['Mean of the stopping round in ', num2str(runs), ', indenpendt runs obtained by AFY is: ', num2str(mean(AccArr))]);
% display(['Mean of the stping rounds in ', num2str(runs), 'indenpendt runs obtained by AFY is :', num2str(mean(StpArr))]);




%{
FunIndex=8;

mean_BestF = zeros(1,25)
mean_iteration = zeros(1,25)

for i=1:25
    [BestX,BestF,HisBestF,VisitTable,Stp_Runs]=AHA(FunIndex,MaxIteration,nPop);
    mean_BestF(i) = BestF;
    mean_iteration(i) = Stp_Runs*nPop;
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

%}










