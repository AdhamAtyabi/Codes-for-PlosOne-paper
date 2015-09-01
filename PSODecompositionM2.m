%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  PSODecomposition with Mutation using LIBSVM implementation       %
%  of support vectyor machine as fitness evakuator                  %
%  Version 1.0 - Aug. 2015                                          %
%                                                                   %
%  According to:                                                    %
%  H.R. Tavakoli, A. Atyabi, Antti Rantanen, Seppo J. Laukka,       %
%  Samia Nefti-Meziani, & Janne Heikkilä,                           %
%  "Predicting the valence of a scene from observers' eye movements"%
%  PLOS ONE, 2015.                                                  %
%                                                                   %
%                                                                   %
%  Programmed By: A. Atyabi                                         %
%                                                                   %
%         e-Mail: a.atyabi@salford.ac.uk                            %
%                 adham.atyabi@flinders.edu.au                      %
%                                                                   %
% Homepage: http://www.seek.salford.ac.uk/profiles/AAtyabi.jsp      %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [i,Bm,CM,ACC,Y,Gbest]=PSODecompositionM2(MaskDim1,PopSize,itr,Bm,Tr,Ts,Val,Options,TypeCL,Settings)
    Eva=[];Premature_Count=[];
    [Population,Gbest]=Initialization_Population(MaskDim1,PopSize,size(Tr.P,1));
    [Eva,Population,Gbest,Premature_Count]=Evaluate_Population(Population,Tr,Val,Options,Gbest,TypeCL,Eva,Premature_Count,Settings,1,itr);
    i=1;
    while (Gbest.bm<Bm) && (i<itr)
        [Population]=Update_Population(Population,i,Gbest,Settings);
        [Eva,Population,Gbest,Premature_Count]=Evaluate_Population(Population,Tr,Val,Options,Gbest,TypeCL,Eva,Premature_Count,Settings,i,itr);
        i=i+1;
    end
    [Bm,CM,ACC,Y]=FinalEvaluation(Gbest,Tr,Ts,Options,TypeCL,Settings);    
end
function [Pop2]=Update_Population(Pop,itr,Gbest,Settings)
Pop2=[];
    for i=1:length(Pop)
        M=Update_Pop(Pop(i),itr,Gbest,size(Pop(i).Mask,1),Settings);% generate new members of the population
        if(isempty(Pop2)), Pop2=M;
        else
        Pop2=[Pop2;M];%Pop=cat(2,Pop,M);
        end
    end
end
function  Pop=Update_Pop(Pop,CurItr,Gbest,dim2,Settings)
 % same population with updated mask   
    r1=rand(1);
    r2=rand(1);
    C1=Settings.C1;% acceleration coefficients
    C2=Settings.C2;
    w1=Settings.W1;
    w2=Settings.W2;
    maxitr=Settings.Itr;
    if (w1==w2), W=w1;
        else W=((w1-w2)*(maxitr-CurItr)/maxitr)+w2;
    end    
%     ymin=1;
%     ymax=dim2;   
    LV=Pop.V;
    x=W*LV(:);
    x2=C1*r1*(Pop.Mask(:,1)-Pop.Pbest.Mask(:,1));
    x3=C2*r2*(Pop.Mask(:,1)-Gbest.Mask(:,1));
    NV=x+x2+x3;
    xx=Pop.Mask(:,1)+NV;       
%     t = min(xx,[],2);
%     xx = (ymax-ymin)*bsxfun(@rdivide,bsxfun(@minus,xx,t),max(xx,[],2)-t)+ymin;
%     xx=abs(xx);
%     [xx,~]=sort(xx,'ascend');
    for k=1:size(xx,1)
       if(xx(k,1)<1||xx(k,1)>dim2)
             xx(k,1)=randi(dim2,1,1);
       end
    end
    Pop.Mask(:,1)=xx;
    Pop.V=NV;    
end
function [Eva,Pop,Gbest,Premature_Count]=Evaluate_Population(Pop,Tr,Val,Options,Gbest,TypeCL,Eva_Last,Premature_Count,Settings,CurItr,maxitr)
bm=cell(1,length(Pop));
Tr2=Tr;
Val2=Val;
for i=1:length(Pop)
            x=Pop(i).Mask(:,1);       
            Tr2.P=Tr.P(round(x),:);
            Val2.P=Val.P(round(x),:);
            [bm{i},~,~,~]=Apply_CL(Tr2,Val2,Tr2.T,Options,TypeCL,Settings);
            Eva.bm(i)=bm{i};   
            if (Eva.bm(i)>Pop(i).Pbest.bm)
               Pop(i).Pbest.bm=Eva.bm(i);
               Pop(i).Pbest.Mask=Pop(i).Mask;
               if(Pop(i).Pbest.bm>=Gbest.bm)
                   Gbest=Pop(i);                   
                   Gbest.Mask=Pop(i).Pbest.Mask;
                   Gbest.bm=Pop(i).Pbest.bm;
               end
            end
end
    if isempty(Eva_Last) 
        Eva_Last=Eva; 
        Premature_Count=zeros(1,length(Pop));
    end
    if (length(Premature_Count)<length(Eva.bm))
        Premature_Count=[Premature_Count,zeros(1,length(Eva.bm)-length(Premature_Count))];
        Eva_Last.bm=[Eva_Last.bm,zeros(1,length(Eva.bm)-length(Eva_Last.bm))];
    end
    for i=1:length(Premature_Count)
        if (Eva_Last.bm(i)>=Eva.bm(i))
            Premature_Count(i)=Premature_Count(i)+1;
            if (Premature_Count(i)>5)
                 Premature_Count(i)=0;
                 xx=randi(size(Tr.P,1),[size(Pop(i).Mask,1),1]);
                 Pop(i).Mask(:,1)=xx;
                 Pop(i).V=rand(1,[size(Pop(i).Mask,1)]);
                 Eva_Last.bm(i)=0;
                 Eva.bm(i)=0;                
            end
        else
            Eva_Last.bm(i)=Eva.bm(i);
            Premature_Count(i)=0;
        end
    end        
end
function [bm,cm,acc,Y]=FinalEvaluation(Pop,Tr,Ts,Options,TypeCL,Settings)
dim2=size(Tr.P,1);
x=Pop.Mask(:,1);       
for k=1:size(x,1)
   if(x(k,1)<1||x(k,1)>dim2)
      x(k,1)=randi(dim2,1,1);
   end
end
Tr.P=Tr.P(round(x),:);
Ts.P=Ts.P(round(x),:);
[bm,cm,acc,Y]=Apply_CL(Tr,Ts,Tr.T,Options,TypeCL,Settings);
end
function [Population,Gbest]=Initialization_Population(MaskDim1,PopSize,dim2)
for i=1:PopSize   
    Mask=randi(dim2,[MaskDim1,1]);
    Population(i).Mask=Mask;
    Population(i).Pbest.bm=0;
    Population(i).Pbest.Mask=randi(dim2,[MaskDim1,1]);    
    Population(i).V=rand(1,[size(Population(i).Mask,1)]);
    
end
     Gbest=Population(1);
    Gbest.Mask=randi(dim2,[MaskDim1,1]);
    Gbest.bm=0;   
end
