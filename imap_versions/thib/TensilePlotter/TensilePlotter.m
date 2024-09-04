% ----- TensilePlotter -----
% Purpose : - Plot les courbes de traction ingénieur et vrai
%           - et le strain hardening rate? et fit les courbes avec un
%           modele?
%           - Sort les propriétés : E, s0, UTS, UE, TFS
%           -
%           -
% Version : META 1.0
% Author : Thibaut HEREMANS
% Date : 23/11/2023

%% GENERAL
set(0,'DefaultFigureWindowStyle','normal')
set(0, 'DefaultAxesFontSize', 14);
clc; clear; close all;

%% LOADING data
tag = 'QP';                                                 % >>> MODIFY
load_tag = ['import_Tensile_' tag '.mat'];
load(load_tag);
L0 = data{1}.L0;

selectQP = [2 4];                   %QPLB et QPTB
selectDP = [2 4];                   %DPLB et DPTB
selectGL = [3 5];                   %GLL  et GLTB
selectFB = [1 4];                   %FBLA et FBTB
selectMoGL = [2 4];                 %MoGLLB et MoGLTB
selectMoFB = [2 4];                 %MoFBLB et MoFBTC
select = 1:length(data);                                     % >>> MODIFY

fprintf(['Tensile plotter for ' tag ' with L0 = ' num2str(L0) '\n \n'])

%% DISPLAY PARAM
slim = 1400;       % MPa
eelim = 50;        % (40) pct de defo ingénieur
%labels = [];

%% ENG ET TRUE CURVES
figure(1)
set(gcf, 'Position', [100, 100, 1200, 400]);
%figure(2)
%set(gcf, 'Position', [400, 100, 800, 400]);

for i = select
    figure(1)
    disp(['i = ' num2str(i) ' --> ' data{i}.tag])
    % Notations
    if isfield(data{i}, 'F0') && data{i}.F0 ~= 0
        F = data{i}.F(4:end) + data{i}.F0;
        dL = data{i}.dL(4:end) - 0.05;
    else
        F = data{i}.F(4:end);
        dL = data{i}.dL(4:end);
    end
    
    t0 = data{i}.t0;
    w0 = data{i}.w0;
    A0 = data{i}.A0;
    labels(i) = {data{i}.tag};
    %plot(dL,F); hold on
    
    % Engineering curves
    data{i}.se = F/A0;           % N/mm2 = MPa
    data{i}.ee = dL/L0;          % no units (pas des pcts!)
    se = data{i}.se(4:end);
    ee = data{i}.ee(4:end);
    
    % Plot engineer
    subplot(1,3,1)
    plot(ee*100, se, 'k'); hold on
    %plot(ee*100, se, 'color', myCol(i,:)); hold on
    title(['Engineering curves - ' tag])
    ylabel('Eng. stress \sigma_e [MPa]');
    xlabel('Eng. strain \epsilon_e [%]');
    curLabel = char(labels(i));
    text(ee(end)*100, se(end)-25, curLabel, 'HorizontalAlignment', 'center')
    xlim([0 eelim])
    ylim([0 slim])
    data{i}.TE = ee(end)*100;
    pbaspect([1 1 1]);
    
    % Module de Young
    subplot(1,3,2)
    plot(ee*100, se, 'k'); hold on
    %plot(ee*100, se, 'color', myCol(i,:)); hold on
    title(['Engineering curves - ' tag])
    ylabel('Eng. stress \sigma_e [MPa]');
    xlabel('Eng. strain \epsilon_e [%]');
    curLabel = char(labels(i));
    text(ee(end)*100, se(end)-25, curLabel, 'HorizontalAlignment', 'center')
    xlim([0 1])
    ylim([0 slim])
    pbaspect([1 1 1]);
    
    sTarget = 300;
    [~, idxTarget] = min(abs(se - sTarget));
    s400 = se(idxTarget);
    e400 = ee(idxTarget);
    E = s400/e400;
    data{i}.E = E;
    E = E/100;                      % Probleme d'unité avec les pct qql part mais yolo
    xx = linspace(0,3,100)';
    yy = xx*E;
    plot(xx, yy,'r.-')
    yy02 = yy-0.2*E;
    plot(xx, yy02, 'g.-')
    
    
    % limite elasticité 0.2pct et plot 02
    if data{i}.tag == "GLL150_B"
        se02 = 668.2;
        data{i}.YS = se02;
        data{i}.xYS = 0.5;
    else
        eeDS = downsample(ee, 100);                 % augementer le sampling si y'a des doublons
        seDS = downsample(se, 100);
        seInterp = interp1(eeDS*100, seDS, xx);
        plot(xx, seInterp, 'b.-')
        difference = abs(seInterp - yy02);
        [~,idx02] = min(difference);
        se02 = seInterp(idx02);
        plot(xx(idx02), se02, 'r.', 'MarkerSize', 15)
        data{i}.YS = se02;
        data{i}.xYS = xx(idx02);
        data{i}.idx02 = idx02;
    end
    % Identification du max
    [se_max, idx_max] = max(se);
    ee_max = ee(idx_max);
    se_max = se(idx_max);
    se = se(1:idx_max);
    ee = ee(1:idx_max);
    subplot(1,3,1)
    plot(ee(end)*100, se(end), 'k.', 'markersize', 15)
    
    % True curves
    s = se.*(1+ee);
    e = log(1+ee);
    
    % Values of interest
    data{i}.e = e;
    data{i}.s = s;
    data{i}.UE = ee(idx_max);
    data{i}.UTS = se(idx_max);
    UTS = data{i}.UTS;
    UE = data{i}.UE;
    TE = data{i}.TE;
    ef = data{i}.TFS;
    sf = data{i}.F(end)/data{i}.Af;
    data{i}.sf = sf;
    
    
    display(['E = ' num2str(data{i}.E/1000, '%.0f') ' GPa'])
    display(['YS = ' num2str(se02, '%.0f') ' MPa'])
    display(['UE = ' num2str(UE*100, '%.2f') '%'])
    display(['TE = ' num2str(TE, '%.2f') '%'])
    display(['TFS = ' num2str(ef, '%.3f')])
    display(['UTS = ' num2str(UTS, '%.0f') ' MPa'])
    fprintf('\n')
    
    % Plot true
    subplot(1,3,3)
    plot(e, s, 'k'); hold on
    plot([e(end) ef], [s(end) sf], 'k.--', 'markersize', 15)
    text(ef+0.05, sf, curLabel, 'HorizontalAlignment', 'center')
    title('True curves')
    ylabel('True stress \sigma [MPa]');
    xlabel('True strain \epsilon');
    %legend(labels,'location','ne')
    xlim([0 1])
    ylim([0 2500])
    pbaspect([1 1 1]);
    
    % Plot strain hardening de base
        figure(2)
        smoothe = smooth(e,150);
        smooths = smooth(s,150);
        dsde = diff(smooths)./diff(smoothe);
        dsde(isinf(dsde)) = NaN;
        plot(s(1:end-1),dsde(1:end), '.', 'color', [0.5 0.5 0.5]); hold on
        xx = linspace(0, 2*slim, 100);
        plot(xx, xx, 'k--')
        xlim([0 slim])
        ylim([0 10000])
        data{i}.dsde = dsde;
    
end

save_tag = ['export_Tensile_', tag, '.mat'];
save(save_tag)
savefig_tag = [tag '_tensile.png'];
saveas(gcf, savefig_tag);


figure(10)
t1 = 80/2;
t2 = t1 + 45;
s1 = 5000;
set(gcf, 'Position', [100, 200, 400, 180]);
%subplot(1,2,1)
plot(data{1}.t, data{1}.F, 'k')
xline(t1-12.5)
xline(t2-12.5)
xlim([t1-40-12.5 t2+40-12.5])
ylim([s1 s1+2000])



