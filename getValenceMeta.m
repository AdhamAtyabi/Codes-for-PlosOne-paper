%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  Feature Extraction Code                                          %
%  Version 1.0 - Aug. 2015                                          %
%                                                                   %
%  According to:                                                    %
%  H.R. Tavakoli, A. Atyabi, Antti Rantanen, Seppo J. Laukka,       %
%  Samia Nefti-Meziani, & Janne Heikkilä,                           %
%  "Predicting the valence of a scene from observers' eye movements"%
%  PLOS ONE, 2015.                                                  %
%                                                                   %
%                                                                   %
%  Programmed By: H.R. Tavakoli                                     %
%                                                                   %
%         e-Mail: Hamed.R-Tavakoli@aalto.fi                         %
%                                                                   %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [meanValence, stdValence] = getValenceMeta(fileName, metaName)

load(metaName);

data = metaData.data;
for i = 1:size(data, 1)
    if strcmp(data{i, 1}, fileName)
        meanValence = data{i, 3};
        stdValence = data{i, 4};
        break;
    end
end
