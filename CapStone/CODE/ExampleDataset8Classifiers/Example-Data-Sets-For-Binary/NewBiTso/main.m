%___________________________________________________________________%
%                    Tuna swarm optimization (TSO)                  %
%                                                                   %
% Developed in MATLAB R2016b                                        %
%                                                                   %
% Author and programmer: Andi Tang                                  %
%                                                                   %
%         E-mail: 418932433@qq.com                                  %
%                 andisu_afeu@163.com                               %
%                                                                   %
% Main paper: Tuna swarm optimization: A novel swarm-based            %
%             metaheuristic algorithm for global optimization       %
%               DOI: 10.1155/2021/9210050                                                    %
%             Computational Intelligence and Neuroscience%
%                                                                   %
%                                                                   %
%___________________________________________________________________%

% To run TSO: [Best_score,Best_pos,TSO_cg_curve]=TSO_final_version_submit(Particles_no,Max_iter,lb,ub,Dim,fobj);
%__________________________________________

clear all 
clc

%doing adaboost now<-

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








%fobj = @FitnessFunction;
%dim = size(feat,2);
%lb = 0;
%ub = 1;

Max_iter = 100;
runs = 10;
Stp_crit = 10e-6;

AccArr = zeros(1, runs);
StpArr = zeros(1, runs);
solu_arr = zeros(1,runs);
ho = 0.2;
Particles_no=30;%Particles_no


file = fopen("Result\result.txt","w");

message = "dataset 1";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\BreastCancer_data.mat; % dataset #1
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 2";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\BreastEW_data.mat; % dataset #2
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 3";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\CongressEW_data.mat; % dataset #3
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 4";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Exactly_data.mat; % dataset #4
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 5";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Exactly2_data.mat; % dataset #5
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 6";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\HeartEW_data.mat; % dataset #6
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 7";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\ionosphere.mat; % dataset #7
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 8";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\KrVsKpEW_data.mat; % dataset #8
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 10";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\M-of-n_data.mat; % dataset #10
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 12";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Sonar_data.mat; % dataset #12
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 13";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\SpectEW_data.mat; % dataset #13
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 14";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Tic-tac-toe_data.mat; % dataset #14
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);

message = "dataset 15";
fprintf(file,message);
fprintf(file,"\n\n");
load Datasets\Vote_data.mat; % dataset #15
BinaryClass(feat,label,Particles_no,Max_iter,Stp_crit,runs,ho,file,message);


fclose(file);

%{
ub = ub*ones(1, dim);
lb = lb*ones(1, dim);

for i = 1:runs
    disp(['Run', num2str(i)]);
    HO = cvpartition(label,'HoldOut',ho,'Stratify',false);
    [sFeat, Sf, Nf,Tuna1_fit,Tuna1,Convergence_curve,Stp_Run]=TSO_final_version_submit(feat,label,Particles_no,Max_iter,lb,ub,dim,fobj,Stp_crit,HO);    
    Acc = KNN(sFeat, label, HO);
    solu_arr(i)=Tuna1_fit;

    disp(['Accuracy:', num2str(Acc)]);
    AccArr(i) = Acc;
    StpArr(i) = Stp_Run;
    disp('');
end

disp('');

for i = 1:runs
    disp(['Run', num2str(i),': Accuracy: ', num2str(AccArr(i)),', Stopping Round: ', num2str(StpArr(i))]);
end

disp('');
display(['Mean of the best fit in ', num2str(runs), 'indenpendt runs obtained by AFT is :', num2str(mean(solu_arr))]);
display(['STD of the best acc in ', num2str(runs), 'indenpendt runs obtained by AFY is :', num2str(std(solu_arr))]);
display(['Mean of the best acc in ', num2str(runs), 'indenpendt runs obtained by AFT is :', num2str(mean(AccArr))]);
display(['Mean of the stping rounds in ', num2str(runs), 'indenpendt runs obtained by AFY is :', num2str(mean(StpArr))]);





%{
Particles_no=30; % Number of search agents

Function_name='F7'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iter=1000; % Maximum numbef of iterations

mean_BestF = zeros(1,25);
mean_iteration = zeros(1,25);

% Load details of the selected benchmark function
[lb,ub,Dim,fobj,ans]=Get_Functions_details(Function_name);

for i=1:25
    [Best_score,Best_pos,TSO_cg_curve,iteration]=TSO_final_version_submit(Particles_no,Max_iter,lb,ub,Dim,fobj,ans);
    mean_BestF(i) = Best_score;
    mean_iteration(i) = iteration*Particles_no;
   

end

display("Mean BF " + mean(mean_BestF));
display("Std BF " + std(mean_BestF));
display("Mean iteration " + mean(mean_iteration));
%}


% figure('Position',[500 500 660 290])
% %Draw search space
% subplot(1,2,1);
% func_plot(Function_name);
% title('Parameter space')
% xlabel('x_1');
% ylabel('x_2');
% zlabel([Function_name,'( x_1 , x_2 )'])
% 
% %Draw objective space
% subplot(1,2,2);
% semilogy(TSO_cg_curve,'Color','r')
% title('Objective space')
% xlabel('Iteration');
% ylabel('Best score obtained so far');
% 
% axis tight
% grid on
% box on
% legend('TSO')

%display(['The best solution obtained by TSO is : ', num2str(Best_pos)]);
%display(['The best optimal value of the objective funciton found by TSO is : ', num2str(Best_score)]);

%}
        



