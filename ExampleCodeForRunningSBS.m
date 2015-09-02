%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  SBS experiments using LIBSVM implementation                      %
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
%%
clear all
clc
load('./feature_vector')
fileName = imageName; % each feature
label = imageLabel;
data = features;
P=data';
Options=' -s 0 -t 2 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%RBF
T=num2cell(imageLabel');
for i=1:size(T,2)
d.period{i}=num2str(T{i});
end
Fold=10;
[T]=Creat_Target(d);
f = @(xtrain, ytrain, xtest, ytest) sum(ytest ~= SVM_class_fun2(xtrain, ytrain,xtest,ytest));
Dim=size(P,2);    
for i=1:Fold
  [traindex,testindex]=Divide_kfold(T,Fold,Dim);
  for j=1:Fold
    Tr.T=T(:,traindex{j});
    Tr.P=P(:,traindex{j});
    Ts.T=T(:,testindex{j}); 
    Ts.P=P(:,testindex{j});
    tr.P=Tr.P';
    tr.T=vec2ind(Tr.T)';    
    opt = statset('UseParallel','always','display','iter'); 
    [inmodel h]= sequentialfs(f,tr.P,tr.T,'cv','resubstitution','options',opt,'direction','backward');
    Tr.P=Tr.P(inmodel,:);
    Ts.P=Ts.P(inmodel,:);
    [bm,cm,acc,Y]=Apply_CL(Tr,Ts,T,Options,'SVM',[]);
    data.bm{i,j}=bm;
    data.inmodel{i,j}=inmodel;
    data.history{i,j}=h;
    data.cm{i,j}=cm;
    data.acc{i,j}=acc;
    data.Y{i,j}=Y;
    data.traindex{i,j}=traindex{j};
    data.testindex{i,j}=testindex{j};
  end
end
