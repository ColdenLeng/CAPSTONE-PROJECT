%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Honey Badger Algorithm source code 
%  paper:
%     Hashim, Fatma A., Essam H. Houssein, Kashif Hussain, Mai S. %     Mabrouk, Walid Al-Atabany. 
%     "Honey Badger Algorithm: New Metaheuristic Algorithm for %  %     Solving Optimization Problems." 
%     Mathematics and Computers in Simulation, 2021.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function [Xprey, Food_Score,CNVG,stopping_run] = HBA(objfunc, dim,lb,ub,tmax,N,ans)

function [sFeat,Sf,Nf,Xprey, Food_Score,CNVG,stopping_run] = HBA(feat,label,objfunc, dim,lb,ub,tmax,N,Stp_crit,HO)


beta       = 6;     % the ability of HB to get the food  Eq.(4)
C       = 2;     %constant in Eq. (3)
vec_flag=[1,-1];
stopping_run = 0;
%initialization
X=initialization(N,dim,ub,lb);
%Evaluation
%fitness = fun_calcobjfunc(objfunc, X);
fitness = fun_calcobjfunc(feat, label,objfunc, X, HO);

[GYbest, gbest] = min(fitness);
Xprey = X(gbest,:);

for t = 1:tmax
    alpha=C*exp(-t/tmax);   %density factor in Eq. (3)
    I=Intensity(N,Xprey,X); %intensity in Eq. (2)
    for i=1:N
        r =rand();
        F=vec_flag(floor(2*rand()+1));
        for j=1:1:dim
            di=((Xprey(j)-X(i,j)));
            if r<.5
                r3=rand;                r4=rand;                r5=rand;
                
                Xnew(i,j)=Xprey(j) +F*beta*I(i)* Xprey(j)+F*r3*alpha*(di)*abs(cos(2*pi*r4)*(1-cos(2*pi*r5)));
            else
                r7=rand;
                Xnew(i,j)=Xprey(j)+F*r7*alpha*di;
            end
        end
        FU=Xnew(i,:)>ub;FL=Xnew(i,:)<lb;Xnew(i,:)=(Xnew(i,:).*(~(FU+FL)))+ub.*FU+lb.*FL;
        
        tempFitness = fun_calcobjfunc(feat, label,objfunc, Xnew(i,:)>0.5,HO);

        if tempFitness<fitness(i)
            fitness(i)=tempFitness;
            X(i,:)= Xnew(i,:);
        end
    end
    FU=X>ub;FL=X<lb;X=(X.*(~(FU+FL)))+ub.*FU+lb.*FL;
    [Ybest,index] = min(fitness);
    CNVG(t)=min(Ybest);
    if Ybest<GYbest
        GYbest=Ybest;
        Xprey = X(index,:);
    end
    Food_Score = GYbest;
    
    %{
    if(abs(ans - GYbest) <= 10e-6)
        stopping_run = t;
        t = tmax;
        break;
    end
    %}
    stopping_run = t*N;
    CNVG(t) = Food_Score;

if t ==1
    fprintf('\nIteration %d Best = %f', t, CNVG(t));
end

if t > 1
    if CNVG(t) ~= CNVG(t-1)
        fprintf('\nIteration %d Best = %f', t,CNVG(t));
    end
end

if Food_Score < Stp_crit
    break;
end

end
%Food_Score = GYbest;

%Xprey is the best position
%dim is the dim
%Food_Score = fitness best value
Pos =1:dim;
Sf = Pos((Xprey > 0.5) == 1);
Nf = length(Sf);
sFeat = feat(:,Sf);
%Eval_number = FEs;
%Best_Pos = BestPop;


end

function Y = fun_calcobjfunc(feat, label,func, X,HO)
N = size(X,1);
for i = 1:N
    %Y(i) = func(X(i,:));
     Y(i) = func(feat, label, X(i,:)>0.5, HO);
end
end

function I=Intensity(N,Xprey,X)
for i=1:N-1
    di(i) =( norm((X(i,:)-Xprey+eps))).^2;
    S(i)=( norm((X(i,:)-X(i+1,:)+eps))).^2;
end
di(N)=( norm((X(N,:)-Xprey+eps))).^2;
S(N)=( norm((X(N,:)-X(1,:)+eps))).^2;
for i=1:N
    r2=rand;
    I(i)=r2*S(i)/(4*pi*di(i));
end
end

function [X]=initialization(N,dim,up,down)
if size(up,2)==1
    X=rand(N,dim).*(up-down)+down;

end

if size(up,2)>1
    for i=1:dim
        high=up(i);low=down(i);
        X(:,i)=rand(N,1).*(high-low)+low;
    end
end
end
