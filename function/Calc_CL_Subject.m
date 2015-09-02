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
function [d,acc,cm]=Calc_CL_Subject(TFE,TCL,TSub,x,xacc,xcm)
for j=1:size(TSub,2)%
for i=1:size(TCL,2)%
    t=[];
    for k=1:size(TFE,2)
        tx=x{j,i,k}.tx;
        if(isnan(tx)) tx=zeros(size(tx));
        end;
    t=cat(2,t,tx);
    end
    dcl(i)=mean(t);    
    std_err_cl(i)=[std(t(:))/sqrt(size(t,1)*size(t,2))];
end
d{j}.dd=dcl';
d{j}.std_err=std_err_cl';
end
for j=1:size(TSub,2)%
for i=1:size(TCL,2)%
    t=[];
    for k=1:size(TFE,2)
        tx=xacc{j,i,k}.tx;
        if(isnan(tx)) tx=zeros(size(tx));
        end;
    t=cat(2,t,tx);
    end
    dcl(i)=mean(t);    
    std_err_cl(i)=[std(t(:))/sqrt(size(t,1)*size(t,2))];
end
acc{j}.dd=dcl';
acc{j}.std_err=std_err_cl';
end
dcl=[];
for j=1:size(TSub,2)%
for i=1:size(TCL,2)%
    t=[];
    for k=1:size(TFE,2)
        tx=xcm{j,i,k}.tx;
        if(isnan(tx)) tx=zeros(size(tx));
        end;
        t=productsum(t,tx);
    end
    dcl{i}=t;    
end
cm{j}.dd=dcl;
end
end
function t=productsum(t,tx)
if(isempty(t)), t=tx;
else
    for i=1:size(tx,1)
    for j=1:size(tx,2)
        t(i,j)=t(i,j)+tx(i,j);
    end
    end
end
end
