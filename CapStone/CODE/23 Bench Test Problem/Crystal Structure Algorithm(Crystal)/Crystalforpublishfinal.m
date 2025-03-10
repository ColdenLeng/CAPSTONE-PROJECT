% ----------------------------------------------------------------------- %
%% CryStAl for Unconstrained Benchmark Problems
% a simplified version, last revised: 1-3-2021
% ----------------------------------------------------------------------- %
%  Author and programmer: Siamak Talatahari                       
%         E-mail:  siamak.talat@gmail.com                              
%  Main paper:                                                      
%    Crystal Structure Algorithm (CryStAl): A Metaheuristic Optimization Method
%    Siamak Talatahari, Mahdi Azizi, Mohamad Tolouei, Babak Talatahari and Pooya Sareh
%     IEEE Access
%%
%% Get Required Problem Information
function [Eval_Number,BestFitness,BestCr,Conv_History] = Crystalforpublishfinal(Cr_Number,MaxIteation,LB,UB,Var_Number,fobj,solu)
%% Initializing parameters
%ObjFuncName = @(x) Sphere(x); % @CostFunction ;
%Var_Number = 100 ; % Number of variables (dimensions);
%LB = -10 *ones(1,Var_Number) ;  % Lower bound of variable ;
%UB = 10 *ones(1,Var_Number) ;  % Upper bound of variable ;

%% Get Required Algorithm Parameters
%MaxIteation = 1000 ; % Maximum number of Iterations ;
%Cr_Number = 30 ; % Maximum number of initial Crystals (population size) ;
%% Outputs:
% BestCr        (Best solution)
% BestFitness     (final Best fitness)
% Conv_History    (Convergence History Curve)
close_re = power(10,-6);
%% Updating the Size of ProblemParameters
if length(LB)==1
    LB=repmat(LB,1,Var_Number);
end
if length(UB)==1
    UB=repmat(UB,1,Var_Number);
end
%% Initialization
% Initializing the Position of first probs
for i=1:Cr_Number
    Crystal(i,:)=unifrnd(LB,UB); % intial position
    % Evaluating the initial probs
    % Fun_eval(i)=feval(fobj,Crystal(i,:)); 
%     Fun_eval(i,1)=feval(fobj(Crystal(i,:))); 
    Fun_eval(i,1)=fobj(Crystal(i,:)); 

end
% The best Crystal
[BestFitness,idbest]=min(Fun_eval); % best fittness value
Crb=Crystal(idbest,:); % best position
% Number of Function Evaluations
Eval_Number=0;
%% Search Process
Iter=1;
while Iter<MaxIteation
    for i=1:Cr_Number
        %% Generate New Crystals
        % Main Crystal
        Crmain=Crystal(randperm(Cr_Number,1),:);
        % Random-selected Crystals
        RandNumber=randperm(Cr_Number,1);
        RandSelectCrystal=randperm(Cr_Number,RandNumber);
        % Mean of randomly-selected Crystals
        Fc=mean(Crystal(RandSelectCrystal,:)).*(length(RandSelectCrystal)~=1)...
            +Crystal(RandSelectCrystal(1,1),:)*(length(RandSelectCrystal)==1);   
        % Random numbers (-1,1)
       r=2*rand-1;       r1=2*rand-1;
       r2=2*rand-1;     r3=2*rand-1;        
        % New Crystals
       NewCrystal(1,:)=Crystal(i,:)+r*Crmain;
       NewCrystal(2,:)=Crystal(i,:)+r1*Crmain+r2*Crb;
       NewCrystal(3,:)=Crystal(i,:)+r1*Crmain+r2*Fc;
       NewCrystal(4,:)=Crystal(i,:)+r1*Crmain+r2*Crb+r3*Fc;

        for i2=1:4
            % Checking/Updating the boundary limits for Crystals
            NewCrystal(i2,:)=bound(NewCrystal(i2,:),UB,LB);

            % Evaluating New Crystals
%             Fun_evalNew(i2)=feval(fobj(NewCrystal(i2,:)));
            Fun_evalNew(i2)=fobj(NewCrystal(i2,:));

            % Updating the Crystals
            if Fun_evalNew(i2)<Fun_eval(i)
                Fun_eval(i)=Fun_evalNew(i2);
                Crystal(i,:)=NewCrystal(i2,:);
            end
            % Updation the Number of Function Evalutions
            Eval_Number=Eval_Number+1;
        end
    end % End of One Iteration
    Iter=Iter+1;
   % The best Crystal
    [BestFitness,idbest]=min(Fun_eval);
    Crb=Crystal(idbest,:);
    BestCr=Crb;
    Conv_History(Iter)=BestFitness;
    if Eval_Number >= 30000 
        break;
    end
    
    if abs(solu-BestCr) < close_re  
        break;
    end
    % Show Iteration Information
    %disp(['Iteration ' num2str(Iter) ': Best Cost = ' num2str(Conv_History(Iter))]);
end % End of Main Looping
% semilogy(Conv_History)

%% Boundary Handling
function x=bound(x,UB,LB)
x(x>UB)=UB(x>UB); x(x<LB)=LB(x<LB);
end
%% Objective Function
% function z=Sphere(x)
%     z=sum(x.^2);
% end
end
