%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  A collection of MATLAB codes used for drawing the results        %
%  Version 1.0 - Aug. 2015                                          %
%                                                                   %
%  According to:                                                    %
%  H.R. Tavakoli, A. Atyabi, Antti Rantanen, Seppo J. Laukka,       %
%  Samia Nefti-Meziani, & Janne Heikkilä,                          %
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
function [d,acc,cm]=Calc_FE_CL_Subject2(TFE,TCL,TSub,x,xacc,xcm)
for j=1:size(TSub,2)%
for i=1:size(TCL,2)%
for k=1:size(TFE,2)
    t=x{j,i,k}.tx;
    if(isnan(t)) t=zeros(size(x{j,i,k}.tx));
    end
    d{j}.dd(i,k)=mean(t);    
    d{j}.std_err(i,k)=[std(t(:))/sqrt(size(t,1)*size(t,2))];
end
end
d{j}.dd=d{j}.dd';
d{j}.std_err=d{j}.std_err';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:size(TSub,2)%
for i=1:size(TCL,2)%
for k=1:size(TFE,2)
    t=xacc{j,i,k}.tx;
    if(isnan(t)) t=zeros(size(xacc{j,i,k}.tx));
    end
    acc{j}.dd(i,k)=mean(t);    
    acc{j}.std_err(i,k)=[std(t(:))/sqrt(size(t,1)*size(t,2))];
end
end
acc{j}.dd=acc{j}.dd';
acc{j}.std_err=acc{j}.std_err';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cm=cell(size(TSub,2));
for j=1:size(TSub,2)%
%     cm{j}.dd=zeros(size(TCL,2),size(TFE,2));
for i=1:size(TCL,2)%
for k=1:size(TFE,2)
    t=xcm{j,i,k}.tx;
    if(isnan(t)) t=zeros(size(xcm{j,i,k}.tx));
    end
    cm{j}.dd{i,k}=t;    
end
end
end
end