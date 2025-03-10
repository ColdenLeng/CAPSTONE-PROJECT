function  BinaryClass(feat,label,Cr_Number,MaxIteation,stp_crit,runs,ho,file,message);
%ALGORITHM Summary of this function goes here
%   Detailed explanation goes here
% Initial Arrays
% solutionArr=zeros(1, runs);
AccArr=zeros(1, runs);
StpArr=zeros(1, runs);
solu_arr=zeros(1,runs);

% Hold-out method
HO = cvpartition(label,'HoldOut',ho,'Stratify',false);
% Prepare the problem
lb  = 0; 
ub  = 1;
Var_Number = size(feat,2);
fobj = @FitnessFunction; 


for i=1:runs
    disp(['Run',num2str(i)]);
    [Sf,Nf,sFeat,Eval_Number,BestFitness,BestCr,Conv_History,Stp_run] = Crystalforpublishfinal(feat,label,Cr_Number,MaxIteation,Var_Number,lb,ub,fobj,stp_crit,HO);
    solu_arr(i)=BestFitness;
    % Acc = KNN(sFeat,label,HO); 
    Acc = KNN(sFeat,label,HO);
    disp([' Accuracy:', num2str(Acc)]);
    AccArr(i)=Acc;
    StpArr(i)=Stp_run;
    HO = cvpartition(label,'HoldOut',ho,'Stratify',false);
    disp(' ');
end


disp(' ');

for i=1:runs
    disp(['Run ', num2str(i),': ']);
    disp(['Fitness: ', num2str(solu_arr(i)),': Accuracy: ', num2str(AccArr(i)),', Stopping Round: ', num2str(StpArr(i))]);
end

disp(' ');
disp(message);
display(['The Mean of the best fitness in ', num2str(runs),' indenpendt runs obtained by Chameleon is : ', num2str(mean(solu_arr))]);
display(['The STD of the best fitness in ', num2str(runs),' indenpendt runs obtained by Chameleon is : ', num2str(std(solu_arr))]);
disp(['The Mean of the best accuracy in ', num2str(runs),' indenpendt runs obtained by Chameleon is : ', num2str(mean(AccArr)),'%']);
display(['The Mean of stopping round in ', num2str(runs),' indenpendt runs obtained by Chameleon is : ', num2str(mean(StpArr))]);

disp(' ');
disp('Cppy here: (Crystal-AUTO - Multi - Decision Tree - Processed 10/100 - data 1->15 - Binary)');
display(num2str(mean(solu_arr)));
display(num2str(std(solu_arr)));
disp([num2str(mean(AccArr)),'%']);
display(num2str(mean(StpArr)));
disp(' ');

fprintf(file,'%f\n',mean(solu_arr));
fprintf(file,'%f\n',std(solu_arr));
per = "%";
fprintf(file,'%f%s\n',mean(AccArr),per);
fprintf(file,'%f\n\n',mean(StpArr));
end

