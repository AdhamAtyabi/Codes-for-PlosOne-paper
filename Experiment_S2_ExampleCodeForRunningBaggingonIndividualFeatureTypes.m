%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB example code for  running bagging on individual features  %
%                                                                   %
%  using LIBSVM implementation of support vectyor machine as fitness% 
%  evaluator                                                        %
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
clear all
clc
load('./feature_vector');
fileName = imageName; % each feature
label = imageLabel;
data = features;
%%
% fprintf('Feature : %s , File : %s ,  mean valence : %f , std valence : %f \n', name, fileName{1}, meanValence, stdValence);
% Options=' -s 0 -t 2 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%RBF
% Options=' -s 0 -t 0 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%Linear
Options=' -s 0 -t 1 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%Polynomial
T=num2cell(imageLabel');
for i=1:size(T,2)
d.period{i}=num2str(T{i});
end
Fold=10;
[T]=Creat_Target(d);
Dim=size(data,1);    
CL_Obj.Extra=Options;
data2=data;
data=[];
for L=1:10
    data_feature=[];
    [data_feature, name] = getFeature(data2,L);
    P=data_feature';
    for i=1:Fold
                [traindex,testindex,valindex]=Divide_kfold(T,Fold,Dim);
                for j=1:Fold
                     Tr.P=P(:,traindex{j});    
                     Tr.T=T(:,traindex{j});
                     Ts.P=P(:,testindex{j});
                     Ts.T=T(:,testindex{j});                 
                     Val.P=P(:,valindex{j});
                     Val.T=T(:,valindex{j});
                     for k=1:100 
                        [bm,cm,acc,Y,idx]=Fusion_Bagging_SVM_IDX_Func2([],P,T,traindex,valindex,j,CL_Obj,0);
                        data.Bag.Val.bm{i,j,k}=bm;
                        data.Bag.Val.cm{i,j,k}=cm;
                        data.Bag.Val.acc{i,j,k}=acc;
                        data.Bag.Val.Y{i,j,k}=Y;
                        [bm,cm,acc,Y,idx]=Fusion_Bagging_SVM_IDX_Func2(idx,P,T,traindex,testindex,j,CL_Obj,0);
                        data.Bag.bm{i,j,k}=bm;
                        data.Bag.cm{i,j,k}=cm;
                        data.Bag.acc{i,j,k}=acc;
                        data.Bag.Y{i,j,k}=Y;
                        data.Bag.idx{i,j}=idx;                    
                     end                
                     data.valindex{i,j}=valindex{j};
                     data.traindex{i,j}=traindex{j};
                     data.testindex{i,j}=testindex{j};
                end
    end
        data.caption='PolyTstBagging10FoldCVELM';
        t=cat(2,name,'_',data.caption,'F',num2str(L));
        fprintf(1,t);
        save(t,'data');
end