%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  PSODecomposition experiments using LIBSVM implementation         %
%  of support vectyor machine as fitness evaluator                  %
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
load('./feature_vector')
fileName = imageName; % each feature
label = imageLabel;
data = features;
% Options=' -s 0 -t 2 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%RBF
% Options=' -s 0 -t 0 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%Linear
Options=' -s 0 -t 1 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%Polynomial
P=data';
T=num2cell(imageLabel');
for i=1:size(T,2)
d.period{i}=num2str(T{i});
end
Fold=10;
[T]=Creat_Target(d);
Dim=size(P,2);
Settings.C1=0.5;
Settings.C2=2.5;
Settings.W1=0.2;
Settings.W2=1;
Settings.Itr=100;
MaskDim1=size(P,1)/10; %only 10% of features to be selected
        for i=1:Fold
            [traindex,testindex,valindex]=Divide_kfold(T,Fold,Dim);
            for j=1:Fold
                 Tr.P=P(:,traindex{j});    
                 Tr.T=T(:,traindex{j});
                 Ts.P=P(:,testindex{j});
                 Ts.T=T(:,testindex{j}); 
                 Val.P=P(:,valindex{j});
                 Val.T=T(:,valindex{j});  
                 [itr,bm,cm,acc,Y,Gbest]=PSODecompositionM2(MaskDim1,100,Settings.Itr,0.8,Tr,Ts,Val,Options,'SVM',Settings);
                 data.bm{i,j}=bm;
                 data.cm{i,j}=cm;
                 data.acc{i,j}=acc;
                 data.Y{i,j}=Y;  
                 data.itr{i,j}=itr;
                 data.Val.BestPerf{i,j}=Gbest.bm;
                 data.Val.BestMask{i,j}=Gbest.Mask;
                 data.traindex{i,j}=traindex{j};
                 data.testindex{i,j}=testindex{j};
                 data.valindex{i,j}=valindex{j};
            end
        end
    data.caption='PolyTstPSODecompositionM210FoldCV';
    t=cat(2,[],' ',data.caption,' \n');
    fprintf(1,t);
    save(data.caption,'data');
    
