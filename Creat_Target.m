function [T]=Creat_Target(d)
% The function is designed to creat the target matrix T
classes = unique(d.period);
T = nan(size(d.period)); % target indices
for i = 1:length(classes)
    T(strcmp(d.period,classes{i})) = i;
end
T = full(ind2vec(T));
end