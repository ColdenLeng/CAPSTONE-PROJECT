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


%function [Tuna1_fit,Tuna1,Convergence_curve,Stp_Run]=TSO_final_version_submit(Particles_no,Max_iter,lb,up,dim,fobj,ans)
function [sFeat,Sf,Nf,Tuna1_fit,Tuna1,Convergence_curve,Stp_Run]=TSO_final_version_submit(feat,label,Particles_no,Max_iter,lb,up,dim,fobj,Stp_crit,HO)


Stp_Run = 0;
Tuna1 = zeros(1,dim);   
Tuna1_fit=inf;

T=initialization(Particles_no,dim,up,lb);
Iter=0;
aa=0.7;
z=0.05;

while Iter<Max_iter+1
    C=Iter/Max_iter;
    a1=aa+(1-aa)*C;
    a2=(1-aa)-(1-aa)*C;
    for i=1:size(T,1)
        
        Flag4ub=T(i,:)>up;
        Flag4lb=T(i,:)<lb;
        T(i,:)=(T(i,:).*(~(Flag4ub+Flag4lb)))+up.*Flag4ub+lb.*Flag4lb;
        
        %fitness(i)=fobj(T(i,:));
        fitness(i) = fobj(feat,label,(T(i,:)>0.5),HO);
        
        if fitness(i)<Tuna1_fit
            Tuna1_fit=fitness(i);  
            Tuna1=T(i,:);
        end
    end
    
    %---------------- Memory saving-------------------
    if Iter==0
        fit_old=fitness;  C_old=T;
    end
    
    for i=1:Particles_no
        if fit_old(i)<fitness(i)
            fitness(i)=fit_old(i); T(i,:)=C_old(i,:);
            
        end
    end
    
    C_old=T;  fit_old=fitness;
    %-------------------------------------------------
    
    t=(1-Iter/Max_iter)^(Iter/Max_iter);                   

    
    if rand<z
        T(1,:)= (up-lb)*rand+lb;
    else
        if  0.5<rand
            r1=rand;
            Beta=exp(r1*exp(3*cos(pi*((Max_iter-Iter+1)/Max_iter))))*(cos(2*pi*r1));
            if  C>rand
                T(1,:)=a1.*(Tuna1+Beta*abs(Tuna1-T(1,:)))+a2.*T(1,:); %Equation (8.3)
                
            else
                IndivRand=rand(1,dim).*(up-lb)+lb;
                T(1,:)=a1.*(IndivRand+Beta*abs(IndivRand-T(i,:)))+a2.*T(1,:);%Equation (8.1)
            end
        else
            TF = (rand>0.5)*2-1;
            if 0.5>rand
                T(1,:)=Tuna1+rand(1,dim).*(Tuna1-T(1,:))+TF.*t^2.*(Tuna1-T(1,:));%Equation (9.1)
            else
                T(1,:) =TF.* t^2.*T(1,:);%Equation (9.2)
            end
            
        end
        
    end
    
    for i=2:Particles_no
        if rand<z    
            
            T(i,:)= (up-lb)*rand+lb;
        else
            if  0.5<rand
                r1=rand;
                Beta=exp(r1*exp(3*cos(pi*((Max_iter-Iter+1)/Max_iter))))*(cos(2*pi*r1));
                if  C>rand
                    T(i,:)=a1.*(Tuna1+Beta*abs(Tuna1-T(i,:)))+a2.*T(i-1,:);%Equation (8.4)
                else
                    
                    IndivRand=rand(1,dim).*(up-lb)+lb;
                    T(i,:)=a1.*(IndivRand+Beta*abs(IndivRand-T(i,:)))+a2.*T(i-1,:);%Equation (8.2)
                end
            else
                TF = (rand>0.5)*2-1;
                if 0.5>rand
                    T(i,:)=Tuna1+rand(1,dim).*(Tuna1-T(i,:))+TF*t^2.*(Tuna1-T(i,:)); %Equation (9.1)
                else
                    T(i,:) = TF*t^2.*T(i,:);%Equation (9.2)
                end
            end
        end
    end

    
    %{
    if(abs(ans - Tuna1_fit) <= 10e-6)
        ("Met the criteria ");
        
        Stp_Run = Iter;
        
        Iter = Max_iter;
    end
    %}
   
    Stp_Run = Iter*Particles_no;

    if fit_old<Stp_crit
        break;
    end
    

    Iter = Iter+1;
    
    Convergence_curve(Iter)=Tuna1_fit;

    
    
end

Pos = 1:dim;
Sf = Pos((Tuna1 > 0.5) == 1);
Nf = length(Sf);
sFeat = feat(:,Sf);

end




