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
function Draw_FE_Subject(TFE,TSub,X,cap,cap2,angle)
TCL=X{1}.d.cl;
for i=1:size(X,2)
   [D{i}.x,D{i}.acc,D{i}.cm]=Calc_FE_CL_Subject1(TFE,TCL,TSub,X{i}.d); 
   [D{i}.dx1,D{i}.dacc1,D{i}.dcm1]=Calc_FE_CL_Subject2(TFE,TCL,TSub,D{i}.x,D{i}.acc,D{i}.cm); 
   [D{i}.dx2,D{i}.dacc2,D{i}.dcm2]=Calc_CL_Subject(TFE,TCL,TSub,D{i}.x,D{i}.acc,D{i}.cm);
   [D{i}.dx3,D{i}.dacc3,D{i}.dcm3]=Calc_FE_Subject(TFE,TCL,TSub,D{i}.x,D{i}.acc,D{i}.cm);
   [D{i}.ddx,D{i}.std_errx,D{i}.ddacc,D{i}.accstd_errx,D{i}.ddcm]=Calc_Subject_General(TSub,X{i}.d);
end

figure
dd=nan;
std_err=nan;
acc=nan;
accstd_err=nan;
cm=nan;
for i=1:size(D,2)
    if (isnan(dd)) dd=D{i}.ddx; 
    else  
        dd=[dd,D{i}.ddx];
    end
    if (isnan(acc)) acc=D{i}.ddacc;
    else  
        acc=[acc,D{i}.ddacc];
    end
    if(iscell(cm)), cm{i}=D{i}.ddcm;
    else cm={D{i}.ddcm};
    end
    if (isnan(std_err)) std_err=D{i}.std_errx;
    else
        std_err=[std_err,D{i}.std_errx];
    end    
    if (isnan(accstd_err)) accstd_err=D{i}.accstd_errx;
    else
        accstd_err=[accstd_err,D{i}.accstd_errx];
    end
end
Draw_Bar_Plotxx('','Bookmaker',cap2,dd,std_err,acc,accstd_err,TSub,cap,angle);
disp(cap);
for i=1:size(D,2)
    disp(cap2(i));
    pp=cell2mat(cm{i});
%     for j=1:size(pp,2)
%         pp(j,:)=pp(j,:)/sum(pp(j,:))*100;
%     end
    disp(pp);
end
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

cn=1;
figure
for j=1:size(TSub,2)%
for i=1:size(D,2)
    D{i}.dd=D{i}.dx1{j}.dd; 
    D{i}.std_err=D{i}.dx1{j}.std_err;    
    D{i}.Naccdd=D{i}.dacc1{j}.dd; 
    D{i}.Naccstd_err=D{i}.dacc1{j}.std_err;    
    D{i}.Ncmdd=D{i}.dcm1{j}.dd; 
    if(cn>round(size(TSub,2)/2)*2) 
        figure;
        cn=1;
    end
    subplot((round(size(TSub,2)/2)),2,cn);
    Draw_Bar_Plotxx(TSub{j},'Bookmaker',TCL,D{i}.dd,D{i}.std_err,D{i}.Naccdd,D{i}.Naccstd_err,TFE,cap2{i},angle);
    cn=cn+1;
    disp(cap2{i});
    for ii=1:size(TCL,2)
        for jj=1:size(TFE,2)
            disp(cat(2,TCL{ii},'  ',TFE{jj}));
            %disp(D{i}.Ncmdd{ii,jj})           
            pp=D{i}.Ncmdd{ii,jj};
%             for jx=1:size(pp,2)
%                 pp(jx,:)=pp(jx,:)/sum(pp(jx,:))*100;
%             end
            disp(pp);
        end
    end
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
end  
end
    
cn=1;
figure
for j=1:size(TSub,2)%
    dd=nan;
    std_err=nan;
    accdd=nan;
    accstd_err=nan;
    cm=nan;
    for i=1:size(D,2)
        if (isnan(dd)) dd=D{i}.dx2{j}.dd; 
        else  
            dd=[dd,D{i}.dx2{j}.dd];
        end
        if (isnan(accdd)) accdd=D{i}.dacc2{j}.dd; 
        else  
            accdd=[accdd,D{i}.dacc2{j}.dd];
        end
        if (isnan(std_err)) std_err=D{i}.dx2{j}.std_err;
        else
            std_err=[std_err,D{i}.dx2{j}.std_err];
        end
        if (isnan(accstd_err)) accstd_err=D{i}.dacc2{j}.std_err;
        else
            accstd_err=[accstd_err,D{i}.dacc2{j}.std_err];
        end
        if(iscell(cm)), cm=[cm;D{i}.dcm2{j}.dd];
        else cm=D{i}.dcm2{j}.dd;
        end
    end
    if(cn>round(size(TSub,2)/2)*2) 
        figure;
        cn=1;
    end
    subplot((round(size(TSub,2)/2)),2,cn);
    if(isequal(cn,2)==1)
    Draw_Bar_Plotxx(TSub{j},'Bookmaker',cap2,dd,std_err,accdd,accstd_err,TCL,cap,angle);    
    disp(cap);
    else
        Draw_Bar_Plotxx(TSub{j},'Bookmaker',cap2,dd,std_err,accdd,accstd_err,TCL,{' '},angle);
    end    
    for ii=1:size(cap2,2)
        for jj=1:size(TCL,2)
            disp(cat(2,cap2{ii},'  ',TCL{jj}));
            pp=cm{ii,jj};
%             for jx=1:size(pp,2)
%                 pp(jx,:)=pp(jx,:)/sum(pp(jx,:))*100;
%             end
            disp(pp);
           % disp(cm{ii,jj})
        end
    end
    cn=cn+1;
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

end

cn=1;
figure
for j=1:size(TSub,2)%
    dd=nan;
    std_err=nan;
    accdd=nan;
    accstd_err=nan;
    cm=nan;
for i=1:size(D,2)
    if (isnan(dd)) dd=D{i}.dx3{j}.dd; 
    else  
        dd=[dd,D{i}.dx3{j}.dd];
    end
    if (isnan(std_err)) std_err=D{i}.dx3{j}.std_err;
    else
        std_err=[std_err,D{i}.dx3{j}.std_err];
    end
    if (isnan(accdd)) accdd=D{i}.dacc3{j}.dd; 
    else  
        accdd=[accdd,D{i}.dacc3{j}.dd];
    end
    if (isnan(accstd_err)) accstd_err=D{i}.dacc3{j}.std_err;
    else
        accstd_err=[accstd_err,D{i}.dacc3{j}.std_err];
    end
    if(iscell(cm)), cm=[cm;D{i}.dcm3{j}.dd];
    else cm=D{i}.dcm3{j}.dd;
    end
end
if(cn>round(size(TSub,2)/2)*2) 
        figure;
        cn=1;
end
   subplot((round(size(TSub,2)/2)),2,cn);
    if(isequal(cn,2)==1)
    Draw_Bar_Plotxx(TSub{j},'Bookmaker',cap2,dd,std_err,accdd,accstd_err,TFE,cap,angle);    
    disp(cap);
    else
        Draw_Bar_Plotxx(TSub{j},'Bookmaker',cap2,dd,std_err,accdd,accstd_err,TFE,{' '},angle);
    end
     for ii=1:size(cap2,2)
        for jj=1:size(TFE,2)
            disp(cat(2,cap2{ii},'  ',TFE{jj}));
            pp=cm{ii,jj};
%             for jx=1:size(pp,2)
%                 pp(jx,:)=pp(jx,:)/sum(pp(jx,:))*100;
%             end
            disp(pp);
%             disp(cm{ii,jj})
        end
     end
      disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

%     Draw_Bar_Plotxx(TSub{j},'Bookmaker',cap2,dd,std_err,TFE,cap);
    cn=cn+1;
end
% cn=1;
% figure
% for j=1:size(TSub,2)%
% for i=1:size(D,2)
%     D{i}.dd=D{i}.dx3{j}.dd; 
%     D{i}.std_err=D{i}.dx3{j}.std_err;
%     subplot(size(TSub,2),size(X,2),cn);
%     Draw_Bar_Plotxx(TSub{j},'Bookmaker',{},D{i}.dd,D{i}.std_err,TFE,cap);
%     cn=cn+1;
% end  
% end

end