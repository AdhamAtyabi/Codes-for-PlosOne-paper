%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  PCA Decomposition experiments                                    %
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
function [Tr,Ts,Val]=PCA_Func(Tr,Ts,Val)
[pc,score,latent] = princomp(Tr.P');
s2=cumsum(var(score))/sum(var(score));
dr1 = find(s2 > 0.99);
pc2=pc(:,1:dr1);
Tr.P=pc2'*Tr.P;
% s22=(cumsum(diag(score.^2))./sum(diag(score.^2)));
% dr12 = find(s22 > 0.99);
% pc3=pc(:,1:dr1);
Ts.P=pc2'*Ts.P;
Val.P=pc2'*Val.P;
end
