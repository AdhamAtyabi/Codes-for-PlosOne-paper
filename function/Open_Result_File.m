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
function [d]=Open_Result_File(Input_File,Discription,FE_List,CL_List,Subject_List,k,f,sub)
for i=1:size(Input_File,2)
    if (exist(Input_File{i}))
        fprintf(cat(2,'Being Processed :      ',Input_File{i}));
        fprintf('\n');
        [d.p1{i},d.acc{i},d.cm{i}]=Open_Data(Input_File{i});
    else
        fprintf(Input_File{i});
        fprintf('\n');
        [d.p1{i},d.acc{i},d.cm{i}]=Open_Data('Temp.mat');
    end
d.Description{i}=Discription{i};
end
d.FE_List=FE_List;
d.CL_List=CL_List;
d.Subject_List=Subject_List;
d.cl=k;
d.fe=f;
d.subject=sub;
end