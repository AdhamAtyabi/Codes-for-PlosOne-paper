%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  SFS experiments using LIBSVM implementation                      %
%  of support vectyor machine                                       %
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
%Options=' -s 0 -t 2 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%RBF
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
        for i=1:Fold
            [traindex,valindex,testindex]=Divide_kfold(T,Fold,Dim);
            for j=1:Fold
                 Tr.T=T(:,traindex{j});
                 Tr.P=P(:,traindex{j});
                 Ts.T=T(:,testindex{j}); 
                 Ts.P=P(:,testindex{j});
                 Val.T=T(:,valindex{j}); 
                 Val.P=P(:,valindex{j});
                 tr.P=Tr.P';
                 tr.T=vec2ind(Tr.T)';
                 val.P=Val.P';
                 val.T=vec2ind(Val.T)';
                 f = @(xtrain, ytrain, xtest, ytest) sum(ytest ~= classify(xtest, xtrain, ytrain));
                 [fs1, history] = sequentialfs(f,tr.P,tr.T); 
                 [bm,cm,acc,Y]=Apply_CL(Tr,Ts,T,Options,'SVM',[]);
                 data.bm{i,j}=bm;
                 data.cm{i,j}=cm;
                 data.acc{i,j}=acc;
                 data.Y{i,j}=Y;  
             end
        end
    data.caption='PolyTst10FoldCVELM';
    t=cat(2,[],' ',data.caption,' \n');
    fprintf(1,t);
    save(cat(2,[],' ',data.caption),'data');
    
