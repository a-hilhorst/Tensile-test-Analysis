% ----- xls2cellTensile -----
% Purpose : - Lit les fichiers excel d'essai de traction copiés dans le dossier 
%             Data_treatment > Matlab > TensilePlotter > input > Tensile_XX
%           - Fichiers renommés pour que l'ordre soit déjà bien foutu selon
%             le fichier Tensile_carac_overview
%           - Fichiers édités avec rajout de leur caractéristiques (tag, LD, LS, Af, ...)
% Version : META 1.0
% Author : Thibaut HEREMANS
% Date : 23/11/2023


clc, clear all, close all;

%% Nom de la campagne et chemin d'accès
test_tag = 'Tensile_QP';                  % >>>>> TO MODIFY <<<<<<
files = dir(['input\' test_tag '\*.xlsx']);


%% Structure d'enregistrement
sheetID = 3;
data = cell(size(files));

for i = 1:length(files)
    filename = [files(1).folder '\Tensile-renamed-' int2str(i) '.xlsx'];
    disp(['Reading Tensile-renamed-' num2str(i) '.xlsx'])
    % Open and extract data
    [sheet, txt] = xlsread(filename,sheetID);
    
    % Data storage
    data{i}.t = sheet(:,1);
    data{i}.F = sheet(:,4);         % CHANGE POUR HT (2) PAR RAPPORT A ROOM T (4)
    data{i}.dL = sheet(:,3);                             
    data{i}.tag = cell2mat(txt(1,1));
    data{i}.LD = cell2mat(txt(1,7));
    data{i}.LS = sheet(1,8);
    data{i}.t0 = sheet(1,9);
    data{i}.w0 = sheet(1,10);
    data{i}.A0 = sheet(1,11);
    data{i}.Af = sheet(1,12);
    data{i}.TFS = sheet(1,13);
    data{i}.L0 = sheet(1,14);                
    %data{i}.T = sheet(1,15);
    %data{i}.F0 = sheet(1,16);
end

disp(['Excel files from '  test_tag  ' imported'])

save_tag = ['import_' test_tag '.mat'];
save(save_tag)













