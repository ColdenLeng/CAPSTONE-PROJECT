clear all;
close;
clc;

%load Dataset\ionosphere.mat;
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
%load Datasets\Zoo_data.mat; % dataset #18

ho = 0.2;
%HO = cvpartition(label,'HoldOut',ho);
% 
% lb  = 0; 
% ub  = 1;
N = 30;%popsize
fobj = @FitnessFunction;
%fobj = @FitnessFunction;%
T = 100;%max iteration
Stp_crit = 10e-6;
runs = 10;

AccArr = zeros(1, runs);
StpArr = zeros(1, runs);
solu_arr = zeros(1, runs);


file = fopen("Result\result.txt","w");

message = "dataset 1";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\BreastCancer_data.mat; % dataset #1
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

message = "dataset 2";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\BreastEW_data.mat; % dataset #2
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

message = "dataset 3";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\CongressEW_data.mat; % dataset #3
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message)

message = "dataset 4";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Exactly_data.mat; % dataset #4
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

message = "dataset 5";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Exactly2_data.mat; % dataset #5
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

message = "dataset 6";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\HeartEW_data.mat; % dataset #6
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

message = "dataset 7";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\ionosphere.mat; % dataset #7
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

message = "dataset 8";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\KrVsKpEW_data.mat; % dataset #8
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

message = "dataset 10";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\M-of-n_data.mat; % dataset #10
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

message = "dataset 12";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Sonar_data.mat; % dataset #12
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

message = "dataset 13";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\SpectEW_data.mat; % dataset #13
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

message = "dataset 14";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Tic-tac-toe_data.mat; % dataset #14
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

message = "dataset 15";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Vote_data.mat; % dataset #15
BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message);

fclose(file);


%[sFeat,Sf,Nf,Stp_runs,Xfood, fval,gbest_t] = SO(feat,label,N,Stp_crit,lb,ub,dim,fobj,HO)

% [sFeat,Sf,Nf,Stp_runs,Xfood, fval,gbest_t] = SO(feat,label,N,T,lb,ub,dim,fobj,HO);
% 
% Acc = KNN(sFeat, label,HO);
% fprint('\n Accuracy: %g %%' ,Acc)

%dim = size(feat,2);

%ub = ub * ones(1,dim);
%lb = lb * ones(1,dim);


%{
for i = 1:runs
    fprintf('\n');
    disp(['Run', num2str(i)]);
    HO = cvpartition(label,'HoldOut',ho,'Stratify',false);

    [sFeat,Sf,Nf,Stp_runs,Xfood,fval,gbest_t] = SO(feat,label,N,T,lb,ub,dim,fobj,Stp_crit,HO);
    Acc = KNN(sFeat,label, HO);
    fprintf('\n');

%     disp(sFeat);

    fprintf('\n');
    disp(['Accuracy: ', num2str(Acc)]);
    AccArr(i) = Acc;
    StpArr(i) = Stp_runs;
    solu_arr(i) = fval;
    disp('');
end

disp('');

for i = 1:runs
    fprintf('');
    disp(['Run: ', num2str(i), ' Accuracy:', num2str(AccArr(i)), ', Stopping Round: ',num2str(StpArr(i))]);
end

disp('');

display(['Mean best acc in', num2str(runs),'Indenpendt runs obtained by AFT is :', num2str(mean(solu_arr))]);
display(['std best acc in', num2str(runs),'Indenpendt runs obtained by AFY is :', num2str(std(solu_arr))]);
display(['Mean Acc in', num2str(runs),'Indenpendt runs obtained by AFY is :', num2str(mean(AccArr))]);
display(['Mean STPR in', num2str(runs),'Indenpendt runs obtained by AFY is :', num2str(mean(StpArr))]);

%}






%{
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
%}


