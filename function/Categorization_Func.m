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
function [d]=Categorization_Func(d)
for i=1:size(d.fe,2)
    cn=1;
   for j=1:size(d.p1,2)
      if(isequal(d.Description{j}.FE,d.fe{i}))
          d.FE{i,cn}.p1=d.p1{j};
          cn=cn+1;
      end
   end
end

for i=1:size(d.cl,2)
    cn=1;
   for j=1:size(d.p1,2)
      if(isequal(d.Description{j}.CL,d.cl{i}))
          d.CL{i,cn}.p1=d.p1{j};
          cn=cn+1;
      end
   end
end

for k=1:size(d.subject,2)
   for i=1:size(d.fe,2)
       cn=1;
       for j=1:size(d.p1,2)
           if(isequal(d.Description{j}.Subject,d.subject{k}))
             if(isequal(d.Description{j}.FE,d.fe{i}))
                  d.Subject{k}.FE{i,cn}.p1=d.p1{j}; 
                  cn=cn+1;
             end
           end
       end
   end   
   for i=1:size(d.cl,2)
       cn=1;
       for j=1:size(d.p1,2)
          if(isequal(d.Description{j}.Subject,d.subject{k}))
            if(isequal(d.Description{j}.CL,d.cl{i}))
                  d.Subject{k}.CL{i,cn}.p1=d.p1{j};
                  cn=cn+1;
            end
          end
       end
   end  
   for i=1:size(d.cl,2)
       for l=1:size(d.fe,2)
       cn=1;
       for j=1:size(d.p1,2)
          if(isequal(d.Description{j}.Subject,d.subject{k}))
            if(isequal(d.Description{j}.CL,d.cl{i}))
                 if(isequal(d.Description{j}.FE,d.fe{l}))
                  d.Subject{k}.Mix{i,l,cn}.p1=d.p1{j};
                  cn=cn+1;
                 end
            end
          end
       end
       end
   end  
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:size(d.fe,2)
    cn=1;
   for j=1:size(d.acc,2)
      if(isequal(d.Description{j}.FE,d.fe{i}))
          d.FE{i,cn}.acc=d.acc{j};
          cn=cn+1;
      end
   end
end

for i=1:size(d.cl,2)
    cn=1;
   for j=1:size(d.acc,2)
      if(isequal(d.Description{j}.CL,d.cl{i}))
          d.CL{i,cn}.acc=d.acc{j};
          cn=cn+1;
      end
   end
end

for k=1:size(d.subject,2)
   for i=1:size(d.fe,2)
       cn=1;
       for j=1:size(d.acc,2)
           if(isequal(d.Description{j}.Subject,d.subject{k}))
             if(isequal(d.Description{j}.FE,d.fe{i}))
                  d.Subject{k}.FE{i,cn}.acc=d.acc{j}; 
                  cn=cn+1;
             end
           end
       end
   end   
   for i=1:size(d.cl,2)
       cn=1;
       for j=1:size(d.acc,2)
          if(isequal(d.Description{j}.Subject,d.subject{k}))
            if(isequal(d.Description{j}.CL,d.cl{i}))
                  d.Subject{k}.CL{i,cn}.acc=d.acc{j};
                  cn=cn+1;
            end
          end
       end
   end  
   for i=1:size(d.cl,2)
       for l=1:size(d.fe,2)
           cn=1;
           for j=1:size(d.acc,2)
              if(isequal(d.Description{j}.Subject,d.subject{k}))
                if(isequal(d.Description{j}.CL,d.cl{i}))
                     if(isequal(d.Description{j}.FE,d.fe{l}))
                      d.Subject{k}.Mix{i,l,cn}.acc=d.acc{j};
                      cn=cn+1;
                     end
                end
              end
           end
       end
   end  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:size(d.fe,2)
    cn=1;
   for j=1:size(d.cm,2)
      if(isequal(d.Description{j}.FE,d.fe{i}))
          d.FE{i,cn}.cm=d.cm{j};
          cn=cn+1;
      end
   end
end

for i=1:size(d.cl,2)
    cn=1;
   for j=1:size(d.cm,2)
      if(isequal(d.Description{j}.CL,d.cl{i}))
          d.CL{i,cn}.cm=d.cm{j};
          cn=cn+1;
      end
   end
end

for k=1:size(d.subject,2)
   for i=1:size(d.fe,2)
       cn=1;
       for j=1:size(d.cm,2)
           if(isequal(d.Description{j}.Subject,d.subject{k}))
             if(isequal(d.Description{j}.FE,d.fe{i}))
                  d.Subject{k}.FE{i,cn}.cm=d.cm{j}; 
                  cn=cn+1;
             end
           end
       end
   end   
   for i=1:size(d.cl,2)
       cn=1;
       for j=1:size(d.cm,2)
          if(isequal(d.Description{j}.Subject,d.subject{k}))
            if(isequal(d.Description{j}.CL,d.cl{i}))
                  d.Subject{k}.CL{i,cn}.cm=d.cm{j};
                  cn=cn+1;
            end
          end
       end
   end  
   for i=1:size(d.cl,2)
       for l=1:size(d.fe,2)
           cn=1;
           for j=1:size(d.cm,2)
              if(isequal(d.Description{j}.Subject,d.subject{k}))
                if(isequal(d.Description{j}.CL,d.cl{i}))
                     if(isequal(d.Description{j}.FE,d.fe{l}))
                      d.Subject{k}.Mix{i,l,cn}.cm=d.cm{j};
                      cn=cn+1;
                     end
                end
              end
           end
       end
   end  
end


end