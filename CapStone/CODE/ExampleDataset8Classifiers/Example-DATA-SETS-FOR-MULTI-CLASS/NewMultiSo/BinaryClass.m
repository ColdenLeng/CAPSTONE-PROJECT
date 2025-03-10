function  BinaryClass(feat,label,N,T,Stp_crit,runs,ho,file,message)
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
dim = size(feat,2);
fobj = @FitnessFunction; 


for i=1:runs
    disp(['Run',num2str(i)]);
   [sFeat,Sf,Nf,Stp_run,Xfood,fval,gbest_t] = SO(feat,label,N,T,lb,ub,dim,fobj,Stp_crit,HO);
    solu_arr(i) = fval;
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
disp('Cppy here: (BinarySnakeO - AUTO) -->Multi-Decision Tree-->1/00 --> 1/15');
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

