% ----- LTprop -----
% Purpose : - Prend une propriété méca en entrée
%           - Fait la moyenne et std en ayant diviser par ech L et L
% Version : META 1.0
% Author : Thibaut HEREMANS
% Date : 09/07/2024

function [meanProp, stdProp, data] = LTpropVariante(data, propName)
prop_L = NaN(1,10);
prop_T = NaN(1,10);

                                               % Parcours les grades d'aciers
    for j = 1:length(data)                         % Parcours les echantillons d'une grade
        if data{j}.LD == 'L'
            prop_L(j) = data{j}.(propName);
        elseif data{j}.LD == 'T'
            prop_T(j) = data{j}.(propName);
        end
    end
    meanProp_L = nanmean(prop_L);
    meanProp_T = nanmean(prop_T);
    meanProp = [meanProp_L; meanProp_T]';
    stdProp_L = nanstd(prop_L);
    stdProp_T = nanstd(prop_T);
    stdProp = [stdProp_L; stdProp_T]';

end