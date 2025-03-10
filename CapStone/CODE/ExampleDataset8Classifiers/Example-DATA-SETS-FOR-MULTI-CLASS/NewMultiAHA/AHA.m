%function [BestX,BestF,HisBestFit,VisitTable,Stp_Runs]=AHA(FunIndex,MaxIt,nPop)
function [Sf,Nf,sFeat,BestX,BestF,HisBestFit,VisitTable,Stp_Runs]=AHA(feat,label,MaxIt,nPop,lb,ub,dim,BenFUnctions,Stp_crit,HO)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FunIndex: The index of function.                    %
% MaxIt: The maximum number of iterations.            %
% nPop: The size of hummingbird population.           %
% PopPos: The position of population.                 %
% PopFit: The fitness of population.                  %
% dim: The dimensionality of prloblem.                %
% BestX: The best solution found so far.              %
% BestF: The best fitness corresponding to BestX.     %
% HisBestFit: History best fitness over iterations.   %
% lb: The lb boundary of search space               %
% ub: The ub boundary of search space.                %
% VisitTable: The visit table.                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%[lb,ub,dim,ans]=FunRange(FunIndex);

    PopPos=zeros(nPop,dim);
    PopFit=zeros(1,nPop);
    Stp_Runs=0;

    for i=1:nPop

        PopPos(i,:)=rand(1,dim).*(ub-lb)+lb;
        %PopFit(i)=BenFunctions(PopPos(i,:),FunIndex,dim);
        PopFit(i) = BenFUnctions(feat,label,(PopPos(i,:)>0.5),HO);

    end

    BestF=inf;
    BestX=[];

    for i=1:nPop
        if PopFit(i)<=BestF
            BestF=PopFit(i);
            BestX=PopPos(i,:);
        end
    end

    % Initialize visit table
    HisBestFit=zeros(MaxIt,1);
    VisitTable=zeros(nPop) ;
    VisitTable(logical(eye(nPop)))=NaN;    
    
    for It=1:MaxIt
        DirectVector=zeros(nPop,dim);% Direction vector/matrix

        for i=1:nPop
            r=rand;
            if r<1/3     % Diagonal flight
                Randdim=randperm(dim);
                if dim>=3
                    RandNum=ceil(rand*(dim-2)+1);
                else
                    RandNum=ceil(rand*(dim-1)+1);
                end
                DirectVector(i,Randdim(1:RandNum))=1;
            else
                if r>2/3  % Omnidirectional flight
                    DirectVector(i,:)=1;
                else  % Axial flight
                    RandNum=ceil(rand*dim);
                    DirectVector(i,RandNum)=1;
                end
            end

            if rand<0.5   % Guided foraging
                [MaxUnvisitedTime,TargetFoodIndex]=max(VisitTable(i,:));
                MUT_Index=find(VisitTable(i,:)==MaxUnvisitedTime);
                if length(MUT_Index)>1
                    [~,Ind]= min(PopFit(MUT_Index));
                    TargetFoodIndex=MUT_Index(Ind);
                end

                newPopPos=PopPos(TargetFoodIndex,:)+randn*DirectVector(i,:).*...
                    (PopPos(i,:)-PopPos(TargetFoodIndex,:));
                newPopPos=SpaceBound(newPopPos,ub,lb);

                %newPopFit=BenFunctions(newPopPos,FunIndex,dim);
                newPopFit= BenFUnctions(feat,label,(PopPos(i,:)>0.5),HO);
                
                if newPopFit<PopFit(i)
                    PopFit(i)=newPopFit;
                    PopPos(i,:)=newPopPos;
                    VisitTable(i,:)=VisitTable(i,:)+1;
                    VisitTable(i,TargetFoodIndex)=0;
                    VisitTable(:,i)=max(VisitTable,[],2)+1;
                    VisitTable(i,i)=NaN;
                else
                    VisitTable(i,:)=VisitTable(i,:)+1;
                    VisitTable(i,TargetFoodIndex)=0;
                end
            else    % Territorial foraging
                newPopPos= PopPos(i,:)+randn*DirectVector(i,:).*PopPos(i,:);
                newPopPos=SpaceBound(newPopPos,ub,lb);

                %newPopFit=BenFunctions(newPopPos,FunIndex,dim);
                newPopFit = BenFUnctions(feat,label,(newPopPos>0.5),HO);


                if newPopFit<PopFit(i)
                    PopFit(i)=newPopFit;
                    PopPos(i,:)=newPopPos;
                    VisitTable(i,:)=VisitTable(i,:)+1;
                    VisitTable(:,i)=max(VisitTable,[],2)+1;
                    VisitTable(i,i)=NaN;
                else
                    VisitTable(i,:)=VisitTable(i,:)+1;
                end
            end
        end

        if mod(It,2*nPop)==0 % Migration foraging
            [~, MigrationIndex]=max(PopFit);
            PopPos(MigrationIndex,:) =rand(1,dim).*(ub-lb)+lb;

            %PopFit(MigrationIndex)=BenFunctions(PopPos(MigrationIndex,:),FunIndex,dim);
            PopFit(MigrationIndex) = BenFUnctions(feat,label,(PopPos(MigrationIndex,:)>0.5),HO);



            VisitTable(MigrationIndex,:)=VisitTable(MigrationIndex,:)+1;
            VisitTable(:,MigrationIndex)=max(VisitTable,[],2)+1;
            VisitTable(MigrationIndex,MigrationIndex)=NaN;            
        end

        for i=1:nPop
            if PopFit(i)<BestF
                BestF=PopFit(i);
                BestX=PopPos(i,:);
            end
        end

        Stp_Runs = It*nPop;
        %{
        if(abs(ans - BestF) <= 10e-6)
            break;
        end
        %}

        HisBestFit(It)=BestF;

        
   if It == 1
        fprintf('\nIteration %d Best = %f', It, HisBestFit(It));
        
    end

    if It > 1
        if HisBestFit(It) ~= HisBestFit(It-1)
            fprintf('\nIteration %d Best = %f',It,HisBestFit(It));
        end
    end

    if BestF < Stp_crit
       break;

    
    end


   
    end

    fprintf('\nIteration %d Best = %f \n',It,HisBestFit(It));
    disp('');
    
    Pos = 1:dim;
    Sf = Pos((BestX > 0.5)==1);
    Nf = length(Sf);
    sFeat = feat(:,Sf);


end


