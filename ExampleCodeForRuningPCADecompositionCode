%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB example code for   runing                                 %
%                                                                   %
%  PCA Decomposition experiments using LIBSVM implementation        %
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

% function [feature, fname] = getFeature(features, type)
% recieves a big feature vector and extract the feature needed
% type varies from 1~10
[data_feature, name] = getFeature(data, 1);

% [meanValence, stdValence] = getValenceMeta(fileName, metaName)
% for a given fileName checks the underlying meta data


% there are 3 meta data, 
% metadata.mat ---> female + male
% metadata_female ---> female information
% metadata_male ---> male information

[meanValence, stdValence] = getValenceMeta(fileName{1}, 'MetaData.mat');
%%
fprintf('Feature : %s , File : %s ,  mean valence : %f , std valence : %f \n', name, fileName{1}, meanValence, stdValence);
% Options=' -s 0 -t 2 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%RBF
Options=' -s 0 -t 0 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%Linear
% Options=' -s 0 -t 1 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%Polynomial
P=data';
T=num2cell(imageLabel');
for i=1:size(T,2)
d.period{i}=num2str(T{i});
end
Fold=10;
[T]=Creat_Target(d);
Dim=size(P,2);    
        for i=1:Fold
            [traindex,testindex,valindex]=Divide_kfold(T,Fold,Dim);
            for j=1:Fold
                 Tr.P=P(:,traindex{j});    
                 Tr.T=T(:,traindex{j});
                 Ts.P=P(:,testindex{j});
                 Ts.T=T(:,testindex{j}); 
                 Val.P=P(:,valindex{j});
                 Val.T=T(:,valindex{j}); 
                 [Tr,Ts,Val]=PCA_Func(Tr,Ts,Val);
                 [bm,cm,acc,Y]=Apply_CL(Tr,Val,T,Options,'SVM',[]);
                 data.Val.bm{i,j}=bm;
                 data.Val.cm{i,j}=cm;
                 data.Val.acc{i,j}=acc;
                 data.Val.Y{i,j}=Y;  
                 [bm,cm,acc,Y]=Apply_CL(Tr,Ts,T,Options,'SVM',[]);
                 data.bm{i,j}=bm;
                 data.cm{i,j}=cm;
                 data.acc{i,j}=acc;
                 data.Y{i,j}=Y;
            end
        end
    data.caption='LinTstPCA10FoldCVSVM';
    t=cat(2,[],' ',data.caption,' \n');
    fprintf(1,t);
    save(cat(2,[],' ',data.caption),'data');
    data2=data.Val;
    data=data2;
    data.caption='LinValPCA10FoldCVSVM';
    t=cat(2,[],' ',data.caption,' \n');
    fprintf(1,t);
    save(cat(2,[],' ',data.caption),'data');
