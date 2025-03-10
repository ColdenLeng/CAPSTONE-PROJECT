function [lb,ub,dim,fobj,solu] = Get_Fun(F)
    switch F
        case 'F1'
            lb=-100;
            ub=100;
            dim=30;
            fobj=@F1;
            solu=0;
    end
end

function z=F1(x)
    z=sum(x.^2);
end