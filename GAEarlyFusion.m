%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  GA feature type fusion experiments using LIBSVM implementation   %
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
function [BestPerf,BestMask]=GAEarlyFusion(Tr,Ts,traindex,valindex,Options,Target,Itr,TypeCL,Settings)
pop_size=100;
load('./feature_vector')
% P=Tr.P;
% initialization of population
Mask=cell(1,pop_size);
for j=1:pop_size    
     Mask{j}=round(rand(10));
end
current_Perf=0;
premature=0;
t=Itr/10;
ddd=[];
iii=0;
BestMask=Mask{1};
BestPerf=0;
while(Target>current_Perf)&&(Itr>0)
     % mutation
    if premature>t
      [data,Mask]=Mutate(traindex,valindex,pop_size,Mask,features,Options,Tr.T,Ts,data,TypeCL,Settings);
       premature=0;
    end
    % Evaluation
    [data,BestMask,BestPerf]=Evaluate(BestPerf,BestMask,traindex,valindex,pop_size,Mask,features,Options,Tr.T,Ts,TypeCL,Settings);
    %    
    Itr=Itr-1;
    premature=premature+1;
    % re-generation (breading)
   [Mask,current_Perf,ddd,iii]=Regenerate(pop_size,Mask,data,ddd,iii);
end
x=cell2mat(data.bm);
[~,dr]=sort(x);
f=Mask{dr(1)};
dd= f(:,1)==1;
P=[];
for k=1:10
    if(dd(k)==1)
        [data_feature, name] = getFeature(features,k);
        if(isempty(P)) P=data_feature';
        else
            P=cat(1,P,data_feature');    
        end
    end
end
end

function [data,Mask]=Mutate(traindex,valindex,pop_size,Mask,features,Options,T,Ts,data,TypeCL,Settings)
        x=randi(pop_size,1);
        Mask{x}=round(rand(10));
        f=Mask{x};
        dd= f(:,1)==1;
        XP=zeros(size(dd));
        P=[];
        for k=1:10
            if(dd(k)==1)
                [data_feature, name] = getFeature(features, k);
                if(isempty(P)) P=data_feature';
                else
                    P=cat(1,P,data_feature');    
                end
            end
        end
        if(~isequal(dd,XP))
            Tr3.P=P(:,traindex);
            Tr3.T=T;          
            Ts3.P=P(:,valindex);
            Ts3.T=Ts.T;
            [bm,cm,acc,Y]=Apply_CL(Tr3,Ts3,T,Options,TypeCL,Settings);
            data.bm{x}=bm;
            data.cm{x}=cm;
            data.acc{x}=acc;
            data.Y{x}=Y;
        else
            data.bm{x}=0;
            data.cm{x}=[];
            data.acc{x}=0;
            data.Y{x}=[];
        end
end
function [data,BestMask,BestPerf]=Evaluate(BestPerf,BestMask,traindex,valindex,pop_size,Mask,features,Options,T,Ts,TypeCL,Settings)
for j=1:pop_size 
        f=Mask{j};
        
        dd= f(:,1)==1;
        P=[];
        XP=zeros(size(dd));
        for k=1:10
            if(dd(k)==1)
                [data_feature, name] = getFeature(features, k);
                if(isempty(P)), P=data_feature';
                else
                    P=cat(1,P,data_feature');    
                end
            end
        end
        if(~isequal(dd,XP))
            Tr3.P=P(:,traindex);
            Tr3.T=T;          
            Ts3.P=P(:,valindex);
            Ts3.T=Ts.T;
            [bm,cm,acc,Y]=Apply_CL(Tr3,Ts3,T,Options,TypeCL,Settings);
            data.bm{j}=bm;
            data.cm{j}=cm;
            data.acc{j}=acc;
            data.Y{j}=Y;
        else
            bm=0;
            data.bm{j}=0;
            data.cm{j}=[];
            data.acc{j}=0;
            data.Y{j}=[];
        end
        if(bm>BestPerf)
            BestPerf=bm;
            BestMask=Mask{j};
        end
end
end
function [Mask,current_Perf,ddd,iii]=Regenerate(pop_size,Mask,data,ddd,iii)
    x=cell2mat(data.bm);    
    current_Perf=max(x);
    [~,dr]=sort(x);
    M=cell(1,pop_size/2);
    for i=1:pop_size/2
        M{i}=Mask{dr(i)};
    end
    Mask=M;
    iii=iii+1;
    k=size(Mask,2);
    j2=size(Mask,2);
    j1=1;
    while (j2>j1)&&(j1<pop_size)&&(size(Mask,2)<pop_size)
        k=k+1;
        x=Mask{j1};
        x1=x(1:end/2,1);
        x2=x((end/2)+1:end,1);
        xx=Mask{j2};
        x3=xx(1:end/2,1);
        x4=xx((end/2)+1:end,1);
        x=[x1;x3];
        Mask{k}=x;
        x=[x2;x4];
        k=k+1;
        Mask{k}=x;        
        j2=j2-1;
        j1=j1+1;
    end    
    ddd{iii}.Mask=Mask;
    ddd{iii}.current_Perf=current_Perf;    
end
