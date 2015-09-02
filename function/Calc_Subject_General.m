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
function [dd,std_err,acc,accstd_err,cm]=Calc_Subject_General(TSub,d)
for j=1:size(TSub,2)%    
    x{j}.tx=nan;
for i=1:size(d.Subject{j}.Mix,1)%
for k=1:size(d.Subject{j}.Mix,2)
    tx=d.Subject{j}.Mix{i,k}.p1;
    if(isnan(tx))
        tx=zeros(size(tx));
    end;
    if(isnan(x{j}.tx)==1) x{j}.tx=tx;
    else
       x{j}.tx=cat(2,x{j}.tx,tx);
%         x{j,i,k}.tx=[x{j,i,k}.tx,tx];    
    end  
end
end
end
for i=1:size(TSub,2)%
    t=x{i}.tx;
    dd(i)=mean(t);    
    std_err(i)=[std(t(:))/sqrt(size(t,1)*size(t,2))];
end
dd=dd';
std_err=std_err';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:size(TSub,2)%    
    x{j}.tx=nan;
for i=1:size(d.Subject{j}.Mix,1)%
for k=1:size(d.Subject{j}.Mix,2)
    tx=d.Subject{j}.Mix{i,k}.acc;
    if(isnan(tx))
        tx=zeros(size(tx));
    end;
    if(isnan(x{j}.tx)) x{j}.tx=tx;
    else
       x{j}.tx=cat(2,x{j}.tx,tx);
%         x{j,i,k}.tx=[x{j,i,k}.tx,tx];    
    end  
end
end
end
for i=1:size(TSub,2)%
    t=x{i}.tx;
    acc(i)=mean(t);    
    accstd_err(i)=[std(t(:))/sqrt(size(t,1)*size(t,2))];
end
acc=acc';
accstd_err=accstd_err';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:size(TSub,2)%    
    x{j}.tx=nan;
for i=1:size(d.Subject{j}.Mix,1)%
for k=1:size(d.Subject{j}.Mix,2)
    tx=d.Subject{j}.Mix{i,k}.cm;
    if(isnan(tx))
        tx=zeros(size(tx));
    end;
    if(isnan(x{j}.tx)) x{j}.tx=tx;
    else
       x{j}.tx=productsum(x{j}.tx,tx); 
%         x{j,i,k}.tx=[x{j,i,k}.tx,tx];    
    end  
end
end
end
for i=1:size(TSub,2)%
    t=x{i}.tx;
    cm{i}=t;    
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
