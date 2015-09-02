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
function [d1bm,d1acc,d1cm]=Open_Data(x)
d_100=open(x);
%%
if(exist('d_100.data.cm'))
    t=d_100.data.cm;
    [k1,k2]=size(t);
    for j1=1:k1
    v=zeros(size(t{1}));
        for j2=1:k2
            xx=t{j1,j2};
             if(iscell(xx))
                xx=cell2mat(xx(1,1));
             end
            if(~isequal(size(xx),size(v)))
                dd=zeros(size(v));
                [t1,t2]=size(xx);
                dd(1:t1,1:t2)=xx(1:t1,1:t2);
                xx=dd;
            end;
          v=v+xx;
        end        
        bm{j1}=bookmaker(v);
    end  
d1bm=nan(1);
for i=1:10
    d1bm(i)=bm{i}.bookmaker;    
end
else
    if(iscell(d_100.data.bm)&& isa(d_100.data.bm{1,1},'struct'))
        for i=1:10
        for j=1:10
            bm(i,j)=d_100.data.bm{i,j}.bookmaker;    
        end     
        end
         [s1,s2]=size(bm);
        if(s1>1&&s2>1) d1bm=mean(bm);
        else d1bm=bm; end
    else
        [s1,s2]=size(d_100.data.bm);
        if(s1>1&&s2>1) d1bm=mean(cell2mat(d_100.data.bm));
        else d1bm=cell2mat(d_100.data.bm); end
    end
end
[s1,s2]=size(d_100.data.acc);
if(s1>1&&s2>1) d1acc=mean(cell2mat(d_100.data.acc));
else d1acc=cell2mat(d_100.data.acc); end
% d1acc=mean(cell2mat(d_100.data.acc));
t=d_100.data.cm;
d1cm=zeros(size(t{1}));
[k1,k2]=size(t);
for j1=1:k1
    v=zeros(size(t{1}));
    for j2=1:k2
        xx=t{j1,j2};
        if(iscell(xx))
          xx=cell2mat(xx(1,1));
        end
        if(~isequal(size(xx),size(v)))
                dd=zeros(size(v));
                [t1,t2]=size(xx);
                dd(1:t1,1:t2)=xx(1:t1,1:t2);
                xx=dd;
        end;
        [k11,k22]=size(xx);
        for x1=1:k11
            for x2=1:k22
                d1cm(x1,x2)=d1cm(x1,x2)+xx(x1,x2);
            end
        end
    end            
end  
end