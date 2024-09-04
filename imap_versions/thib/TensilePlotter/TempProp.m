% ----- TempProp -----
% Purpose : - Prend une propriété méca en entrée
%           - Fait la moyenne et std en ayant diviser par ech L et L
%           - variante pour les essais en temperature qui ont pas la meme
%           structure meta
% Version : META 1.0
% Author : Thibaut HEREMANS
% Date : 09/07/2024

function [meanProp, stdProp, data] = TempProp(data, propName)
Trange = [25 50 100 150 200 250];
Tprop = NaN(4,6);


% Parcours les echantillons
for i = 1:length(data)                         % Parcours les echantillons d'une grade
    data{i}.T;
    TmatchIdx = find(data{i}.T == Trange);
    row = Tprop(:,TmatchIdx);
    EmptyIdx = find(isnan(row), 1);
    Tprop(EmptyIdx,TmatchIdx) = data{i}.(propName);
    
    meanProp = nanmean(Tprop);
    stdProp = nanstd(Tprop);
end
end