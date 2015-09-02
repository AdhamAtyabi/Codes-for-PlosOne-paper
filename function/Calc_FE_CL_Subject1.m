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
function [x,acc,cm]=Calc_FE_CL_Subject1(TFE,TCL,TSub,d)
% tft=d.Subject;
for j=1:size(TSub,2)% 
for i=1:size(TCL,2)%
for k=1:size(TFE,2)       
    x{j,i,k}.tx=nan;
%     if(isa(d.Subject,'cell')==0) 
%         d.Subject=tft;
%     end
    tx=d.Subject{j}.Mix{i,k}.p1;
    if(isnan(x{j,i,k}.tx)) x{j,i,k}.tx=tx;
    else
        x{j,i,k}.tx=[x{j,i,k}.tx,tx];    
    end 
    if(isnan(x{j,i,k}.tx)) x{j,i,k}.tx=zeros(size(tx));
    end;
end
end
end

for j=1:size(TSub,2)% 
for i=1:size(TCL,2)%
for k=1:size(TFE,2)       
    acc{j,i,k}.tx=nan;
%     if(isa(d.Subject,'cell')==0) 
%         d.Subject=tft;
%     end
    tx=d.Subject{j}.Mix{i,k}.acc;
    if(isnan(acc{j,i,k}.tx)) acc{j,i,k}.tx=tx;
    else
        acc{j,i,k}.tx=[acc{j,i,k}.tx,tx];    
    end 
    if(isnan(acc{j,i,k}.tx)) acc{j,i,k}.tx=zeros(size(tx));
    end;
end
end
end

for j=1:size(TSub,2)%
for i=1:size(TCL,2)%
for k=1:size(TFE,2)
    cm{j,i,k}.tx=nan;
end
end
end
for j=1:size(TSub,2)%
for i=1:size(TCL,2)%
for k=1:size(TFE,2)
    tx=d.Subject{j}.Mix{i,k}.cm;
    if(isnan(cm{j,i,k}.tx)) cm{j,i,k}.tx=tx;
    else
        cm{j,i,k}.tx=[cm{j,i,k}.tx,tx];    
    end 
    if(isnan(cm{j,i,k}.tx)) cm{j,i,k}.tx=zeros(size(tx));
    end;
end
end
end
end