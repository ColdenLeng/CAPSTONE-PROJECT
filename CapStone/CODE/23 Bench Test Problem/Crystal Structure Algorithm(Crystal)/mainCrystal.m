clear
close all
clc
%% Initializing parameters

maxit = 1000 ; % Maximum number of Iterations ;
nPop = 30 ; % Maximum number of initial Crystals (population size) ;
ObjFuncName = 'F7'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
runs =25;
run_arr = zeros(1, runs);
sol_arr = zeros(1, runs);
for i=1:runs
    [lb,ub,dim,fobj,solu] = Get_Functions_details(ObjFuncName);

    [Eval_Number,BestFitness,BestCr,Conv_History] = Crystalforpublishfinal(nPop,maxit,lb,ub,dim,fobj,solu);
    run_arr(i) = Eval_Number;
    sol_arr(i) = BestFitness;
    % disp(['The best crystal at' num2str(i) ' is ' num2str(BestFitness)]);
end

display([num2str(ObjFuncName),' solution: ', num2str(solu)]);
display(['Max iteration:', num2str(maxit)]);
display(['Population: ', num2str(nPop)]);

display(['The Mean of the best solution in ', num2str(runs),' indenpendt runs obtained by SHO is : ', num2str(mean(sol_arr))]);
display(['The STD of the best solution in ', num2str(runs),' indenpendt runs obtained by SHO is : ', num2str(std(sol_arr))]);
display(['The Mean of stopping iteration in ', num2str(runs),' indenpendt runs obtained by SHO is : ', num2str(mean(run_arr))]);