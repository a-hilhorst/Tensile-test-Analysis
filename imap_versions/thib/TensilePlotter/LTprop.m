% ----- LTprop -----
% Purpose : - Prend une propriété méca en entrée
%           - Fait la moyenne et std en ayant diviser par ech L et L
% Version : META 1.0
% Author : Thibaut HEREMANS
% Date : 09/07/2024

function [meanProp, stdProp, meta] = LTprop(meta, N, propName)
prop_L = NaN(N,10);
prop_T = NaN(N,10);

for i = 1:N                                                % Parcours les grades d'aciers
    for j = 1:length(meta{i}.data)                         % Parcours les echantillons d'une grade
        if meta{i}.data{j}.LD == 'L'
            prop_L(i,j) = meta{i}.data{j}.(propName);
        elseif meta{i}.data{j}.LD == 'T'
            prop_T(i,j) = meta{i}.data{j}.(propName);
        end
    end
    meanProp_L(i) = nanmean(prop_L(i,:));
    meanProp_T(i) = nanmean(prop_T(i,:));
    meanProp = [meanProp_L; meanProp_T]';
    stdProp_L(i) = nanstd(prop_L(i,:));
    stdProp_T(i) = nanstd(prop_T(i,:));
    stdProp = [stdProp_L; stdProp_T]';
end
end