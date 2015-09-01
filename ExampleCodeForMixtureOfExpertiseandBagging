%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB example code for                                          %
%                                                                   %
%  generating combination of bagging on individual feature types and% 
%  mixture of experties  using LIBSVM implementation                %
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
clear all
clc
% load extracted features as a big feature vector
load('feature_vector')

fileName = imageName; % each feature
label = imageLabel;
data = features;
%     Options=' -s 0 -t 2 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%RBF
%     Options=' -s 0 -t 0 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%Linear
    Options=' -s 0 -t 1 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%Polynomial

Px=data';
Tx=num2cell(imageLabel');
for i=1:size(Tx,2)
d.period{i}=num2str(Tx{i});
end
Fold=10;
[Tx]=Creat_Target(d);
data2=data;
Dim=size(Px,2);  
CL_Obj.Extra=Options;
for i=1:Fold
            [traindex,testindex,valindex]=Divide_kfold(Tx,Fold,Dim);
            for j=1:Fold
                idx=[];
                for k=1:10
                    for ll=1:100
                        data_feature=[];
                        [data_feature, name] = getFeature(data2,k);
                        P=data_feature';
                        [bm,cm,acc,Y,idx]=Fusion_Bagging_SVM_IDX_Func2(idx,P,Tx,traindex,valindex,j,CL_Obj,0);
                        data.traindex{i,j}=traindex{j};
                        data.testindex{i,j}=testindex{j};
                        data.valindex{i,j}=valindex{j};
                        data.idx{i,j}=idx;
                        data.Val.bm{i,j,k,ll}=bm;
                        data.Val.cm{i,j,k,ll}=cm;
                        data.Val.acc{i,j,k,ll}=acc;
                        data.Val.Y{i,j,k,ll}=Y;                               
                        [bm,cm,acc,Y,idx]=Fusion_Bagging_SVM_IDX_Func2(idx,P,Tx,traindex,testindex,j,CL_Obj,0);
                        data.bm{i,j,k,ll}=bm;
                        data.cm{i,j,k,ll}=cm;
                        data.acc{i,j,k,ll}=acc;
                        data.Y{i,j,k,ll}=Y;
                    end
                end
                k=11;
                for ll=1:100
                        [bm,cm,acc,Y,idx]=Fusion_Bagging_SVM_IDX_Func2(idx,Px,Tx,traindex,valindex,j,CL_Obj,0);
                        data.traindex{i,j}=traindex{j};
                        data.testindex{i,j}=testindex{j};
                        data.valindex{i,j}=valindex{j};
                        data.idx{i,j}=idx;
                        data.Val.bm{i,j,k,ll}=bm;
                        data.Val.cm{i,j,k,ll}=cm;
                        data.Val.acc{i,j,k,ll}=acc;
                        data.Val.Y{i,j,k,ll}=Y;                               
                        [bm,cm,acc,Y,idx]=Fusion_Bagging_SVM_IDX_Func2(idx,Px,Tx,traindex,testindex,j,CL_Obj,0);
                        data.bm{i,j,k,ll}=bm;
                        data.cm{i,j,k,ll}=cm;
                        data.acc{i,j,k,ll}=acc;
                        data.Y{i,j,k,ll}=Y;
                end
                data.idx{i,j}=idx;                        
            end
end
    data.caption='NewTmpPolyBagMix10FoldCV';
    t=cat(2,[],data.caption,' \n');
    fprintf(1,t);
    save(cat(2,[],data.caption),'data');
