%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  Individual Feature experiments using LIBSVM implementation       %
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
data2=data;
for k=1:10
    data_feature=[];
    [data_feature, name] = getFeature(data2, k);
%     Options=' -s 0 -t 2 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%RBF
%     Options=' -s 0 -t 0 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%Linear
    Options=' -s 0 -t 1 -d 3 -r 0 -n 0.5 -m 100 -e 0.001 -h 1 -wi 1 -b 1';%Polynomial
    P=data_feature';
    T=num2cell(imageLabel');
    for i=1:size(T,2)
    d.period{i}=num2str(T{i});
    end
    Fold=10;
    [T]=Creat_Target(d);
    Dim=size(P,2);    
            for i=1:Fold
                [traindex,testindex]=Divide_kfold(T,Fold,Dim);
                for j=1:Fold
                     Tr.P=P(:,traindex{j});    
                     Tr.T=T(:,traindex{j});
                     Ts.P=P(:,testindex{j});
                     Ts.T=T(:,testindex{j}); 
                     [bm,cm,acc,Y]=Apply_CL(Tr,Ts,T,Options,'SVM',[]);
                     data.bm{i,j}=bm;
                     data.cm{i,j}=cm;
                     data.acc{i,j}=acc;
                     data.Y{i,j}=Y;  
                     data.traindex{i,j}=traindex{j}; % for individual
                     data.testindex{i,j}=testindex{j};                        
                end
            end
        data.caption=cat(2,'PolySVM10FoldCVF',int2str(k));
        t=cat(2,name,data.caption,' \n');
        fprintf(1,t);
        save(cat(2,name,data.caption),'data');
