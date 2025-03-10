clear
close all
clc
%% Initializing parameters

%load Datasets/BreastCancer_data.mat; % dataset #1
%load Datasets/BreastEW_data.mat; % dataset #2
%load Datasets/CongressEW_data.mat; % dataset #3
%load Datasets/Exactly_data.mat; % dataset #4
%load Datasets/Exactly2_data.mat; % dataset #5
%load Datasets/HeartEW_data.mat; % dataset #6
%load Datasets/ionosphere.mat; % dataset #7
%load Datasets/KrVsKpEW_data.mat; % dataset #8
%load Datasets/Lymphography_data.mat; % dataset #9
%load Datasets/M-of-n_data.mat; % dataset #10
%load Datasets/PenglungEW_data.mat; % dataset #11
%load Datasets/Sonar_data.mat; % dataset #12
%load Datasets/SpectEW_data.mat; % dataset #13
%load Datasets/Tic-tac-toe_data.mat; % dataset #14
%load Datasets/Vote_data.mat; % dataset #15
%load Datasets/WaveformEW_data.mat; % dataset #16
%load Datasets/Wine_data.mat; % dataset #17
%load Datasets/Zoo_data.mat; % dataset #18

ho = 0.2;

% 
% lb = 0;
% ub = 1;



%fobj = @FitnessFunction;
%Var_Number = size(feat,2);%dim=size(feat,2);




stp_crit = 10e-6;

MaxIteation = 100; % Maximum number of Iterations ;
runs = 10;

Cr_Number = 30 ; % Maximum number of initial Crystals (population size) dim;
%ObjFuncName = 'F7';
AccArr = zeros(1, runs);
StpArr = zeros(1, runs);
solu_arr = zeros(1, runs);
%Var_Number = dim;

file = fopen("Result\result.txt","w");

message = "dataset 9";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Lymphography_data.mat; % dataset #9
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 11";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\PenglungEW_data.mat; % dataset #11
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 16";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\WaveformEW_data.mat; % dataset #16
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 17";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Wine_data.mat; % dataset #17
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 19";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Zoo_data.mat; % dataset #18
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

%{
message = "dataset 1";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\BreastCancer_data.mat; % dataset #1
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 2";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\BreastEW_data.mat; % dataset #2
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 3";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\CongressEW_data.mat; % dataset #3
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 4";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Exactly_data.mat; % dataset #4
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 5";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Exactly2_data.mat; % dataset #5
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 6";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\HeartEW_data.mat; % dataset #6
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 7";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\ionosphere.mat; % dataset #7
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 8";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\KrVsKpEW_data.mat; % dataset #8
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 10";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\M-of-n_data.mat; % dataset #10
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 12";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Sonar_data.mat; % dataset #12
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 13";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\SpectEW_data.mat; % dataset #13
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 14";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Tic-tac-toe_data.mat; % dataset #14
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);

message = "dataset 15";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Vote_data.mat; % dataset #15
BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);
%}

fclose(file);


% ub = ub*ones(1,Var_Number);
% lb = lb*ones(1,Var_Number);
% 

% for i=1:runs 
%     disp(['Run',num2str(i)]);
%     [Sf,Nf,sFeat,Eval_Number,BestFitness,BestCr,Conv_History] = Crystalforpublishfinal(feat,label,Cr_Number,MaxIteation,Var_Number,lb,ub,fobj,HO)
%     Acc = KNN(sFeat,label,HO);
%     disp(['Accuray:', num2str(Acc)]);
%     AccArr(i) = Acc;
%     StpArr(i) = Stp_run;
%     disp('');
% 
% end

%Eval_Number Stp
%{
disp('');
[Sf,Nf,sFeat,Eval_Number,BestFitness,BestCr,Conv_History] = Crystalforpublishfinal(feat,label,Cr_Number,MaxIteation,Var_Number,lb,ub,fobj,HO);
 Acc = KNN(sFeat,label,HO);
    disp(['Accuray:', num2str(Acc)]);
%}

%{
 for i=1:runs
     disp(['Run ', num2str(i)]);
     HO = cvpartition(label,'HoldOut',ho,'Stratify',false);
     [Sf,Nf,sFeat,Eval_Number,BestFitness,BestCr,Conv_History,Stp_run] = Crystalforpublishfinal(feat,label,Cr_Number,MaxIteation,Var_Number,lb,ub,fobj,stp_crit,HO);
     Acc = KNN(sFeat, label, HO);
     fprintf('\n');
     disp(['Accuracy: ', num2str(Acc)]);
     AccArr(i) = Acc;
     StpArr(i) = Stp_run;
     solu_arr(i) = BestFitness;
     disp('');
 end

 disp('');

 for i = 1:runs
     disp('');
     disp(['Runs ', num2str(i),': Accuracy ', num2str(AccArr(i)), ', Stopping Round: ', num2str(StpArr(i))]);
 end

 disp('');

 disp(['The Mean of the best Acc in: ', num2str(runs), 'indenpendt runs obtained by AFT is: ', num2str(mean(solu_arr))]);
 disp(['The STD of the best Acc in: ', num2str(runs), 'indenpendt runs obtained by AFT is: ', num2str(std(solu_arr))]);
 disp(['The Mean of Acc in: ', num2str(runs), 'indenpendt runs obtained by AFT is: ', num2str(mean(AccArr))]);
 disp(['The Mean of stopping rounds in: ', num2str(runs), 'indenpendt runs obtained by AFT is: ', num2str(mean(StpArr))]);

%}

%{
for i=1:runs
    
    %[Sf,Nf,sFeat,Eval_Number,BestFitness,BestCr,Conv_History] = Crystalforpublishfinal(feat,label,Cr_Number,MaxIteation,Var_Number,lb,ub,fobj,HO)
    [Eval_Number,BestFitness,BestCr,Conv_History] = Crystalforpublishfinal(Cr_Number,MaxIteation,lb,ub,Var_Number,fobj);
    run_arr(i) = Eval_Number;
    sol_arr(i) = BestFitness;
    % disp(['The best crystal at' num2str(i) ' is ' num2str(BestFitness)]);
end


display(['Max iteration:', num2str(maxit)]);
display(['Population: ', num2str(nPop)]);

display(['The Mean of the best solution in ', num2str(runs),' indenpendt runs obtained by SHO is : ', num2str(mean(sol_arr))]);
display(['The STD of the best solution in ', num2str(runs),' indenpendt runs obtained by SHO is : ', num2str(std(sol_arr))]);
display(['The Mean of stopping iteration in ', num2str(runs),' indenpendt runs obtained by SHO is : ', num2str(mean(run_arr))]);
%}
