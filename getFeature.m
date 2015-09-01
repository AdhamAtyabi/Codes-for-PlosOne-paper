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
function [data2, fname] = getFeature(features, fType)
% function [feature, fname] = getFeature(features, type)
% recieves a big feature vector and extract the feature needed
% type varies from 1~10

switch fType
    case 1
        data2 = features(:, 1:50); %velocity %%%%%%
        fname = 'velocity';
    case 2
        data2 = features(:, 51:86); % saccade orientation
        fname = 'saccade_orientation';
    case 3
        data2 = features(:, 87:136); % saccade length
        fname = 'saccade_lngth';
    case 4
        data2 = features(:, 137:166); % slope
        fname = 'slope';
    case 5
        data2 = features(:, 167:226); % saccade duration
        fname = 'saccade_duration';
    case 6
        data2 = features(:, 227:286); % fixation duration
        fname = 'fixation_duration';
    case 7
        data2 = features(:, 287:542); % fixation histogram   %%%%%%
        fname = 'fixation_histogram';
    case 8
        data2 = features(:, 543:552); % saliency histogram   %%%%%%
        fname = 'saliency_histogram';
    case 9
        data2 = features(:, 553:852); % saliency map
        fname = 'saliency_map';
    case 10
        data2 = features(:, 853:872); % coordinates [1-10 ---> x  11-20 ---> y] %%%%%%
        fname = 'top_10_coordinates';
end
