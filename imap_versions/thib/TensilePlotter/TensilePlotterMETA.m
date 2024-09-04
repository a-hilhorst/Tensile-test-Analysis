% ----- TensilePlotterMeta -----
% Purpose : - Plot toutes les courbes de tractions representatives
% Version : 1.0
% Author : Thibaut Heremans
% Date : 01/07/24
% Comments : Load tous les output de TensilePlotter dans des sous structures

%% GENERAL
set(0,'DefaultFigureWindowStyle','normal')
set(0, 'DefaultAxesFontSize', 14);
clc; clear; close all;

%% Loading my data
test_tags = ["GL" "FB" "MoGL" "MoFB" "QP" "DP"];                   % >>>>> TO MODIFY <<<<<<

selectQP = [2 4];                   %QPLB et QPTB
selectDP = [2 4];                   %DPLB et DPTB
selectGL = [3 5];                   %GLL  et GLTB
selectFB = [1 4];                   %FBLA et FBTB
selectMoGL = [2 4];                 %MoGLLB et MoGLTB
selectMoFB = [2 4];                 %MoFBLB et MoFBTC

selectMeta = [selectGL; selectFB; selectMoGL; selectMoFB; selectQP; selectDP];
selectMetaAll = [];

N = length(test_tags);
meta = cell(N,1);
for i = 1:N
    meta{i} = load (['export_Tensile_' + test_tags(i) + '.mat']);
    selectMetaAll = [selectMetaAll; length(meta{i}.data)];
end
eelimMeta = 35;

%% Figures
figure(1)
set(gcf, 'Position', [50, 50, 800, 400]);       % ENGINEERING CURVES
figure(2)
set(gcf, 'Position', [700, 300, 800, 400]);     % TRUE CURVES
figure(3)
set(gcf, 'Position', [700, 150, 800, 400]);     % PROPR MECA
figure(4)
set(gcf, 'Position', [50, 150, 800, 400]);
figure(5)
set(gcf, 'Position', [100, 200, 800, 400]);
colors = lines(6);

%% Plotting eng et true
for i = 1:N
    for j = selectMeta(i,:) %selectMetaAll(i)%
        j
        % Engineering
        figure(1)
        plot(meta{i}.data{j}.ee*100, meta{i}.data{j}.se, 'color', colors(i,:)); hold on
        [~, idx_max] = max(meta{i}.data{j}.se);
        plot(meta{i}.data{j}.ee(idx_max)*100, meta{i}.data{j}.se(idx_max), 'ok', 'markersize', 4, 'markerFaceColor', colors(i,:))
        plot(meta{i}.data{j}.xYS, meta{i}.data{j}.YS, 'sk', 'markersize', 5, 'markerFaceColor', colors(i,:))
        %plot(meta{i}.data{j}.UE*100, meta{i}.data{j}.UTS, 'k.', 'markersize', 15)
        curLabel = char(meta{i}.labels(j));
        text(meta{i}.data{j}.ee(end)*100, meta{i}.data{j}.se(end)-25, curLabel(1:end-1), 'HorizontalAlignment', 'center')
        
    end
    title('Engineering curves')
    ylabel('Eng. stress \sigma_e [MPa]');
    xlabel('Eng. strain \epsilon_e [%]');
    xlim([0 eelimMeta])
    ylim([0 meta{1}.slim])
    
    
    for j = selectMeta(i,:)
        figure(2)
        plot(meta{i}.data{j}.e, meta{i}.data{j}.s, 'color', colors(i,:)); hold on
        plot([meta{i}.data{j}.e(end) meta{i}.data{j}.TFS], [meta{i}.data{j}.s(end) meta{i}.data{j}.sf], '--', 'color', colors(i,:))
        plot(meta{i}.data{j}.e(end) , meta{i}.data{j}.s(end) , '.', 'markersize', 15, 'color', colors(i,:))
        plot(meta{i}.data{j}.TFS, meta{i}.data{j}.sf, 'x', 'markersize', 5, 'linewidth', 1.5, 'color', colors(i,:))
        curLabel = char(meta{i}.labels(j));
        text(meta{i}.data{j}.TFS+0.05, meta{i}.data{j}.sf, curLabel(1:end-1), 'HorizontalAlignment', 'center')
    end
    title('True curves')
    ylabel('True stress \sigma [MPa]');
    xlabel('True strain \epsilon');
    xlim([0 1])
    ylim([0 2500])
end



%% Stats mechanical properties
% decomposition L/T de n'importe quel propriete
[meanYS, stdYS] = LTprop(meta, N, 'YS');
[meanUTS, stdUTS] = LTprop(meta, N, 'UTS');
[meanUE, stdUE] = LTprop(meta, N, 'UE');
[meanTE, stdTE] = LTprop(meta, N, 'TE');
[meanTFS, stdTFS] = LTprop(meta, N, 'TFS');
[meansf, stdsf] = LTprop(meta, N, 'sf');
meanUTSTE = meanUTS.*meanTE;
meanUTSUE = meanUTS.*meanUE;
meanSRatio = meanYS./meanUTS;

% plotting
figure(3)
subplot(1,2,1)
for i = 1:N
    %errorbar(1:N, meanYS(:,1), stdYS(:,1), 'k', 'linestyle', 'none');
    plot(i, meanYS(i,1), 's', 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'none', 'MarkerSize', 8); hold on%, 'filled', 'MarkerFaceColor', colors(i,:)); hold on
    plot(i, meanYS(i,2), 'd', 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'none', 'MarkerSize', 8);
    plot(i, meanUTS(i,1), '+', 'Color', colors(i,:),  'MarkerSize', 10, 'linewidth', 3);
    plot(i, meanUTS(i,2), 'x', 'Color', colors(i,:),  'MarkerSize', 10, 'linewidth', 3);
end
set(gca, 'XTickLabel', ['' ,test_tags]);
xlim([0 7])
ylim([0 1400])
ylabel('Stress')
pbaspect([1 1 1]);

subplot(1,2,2)
for i = 1:N
    %errorbar(1:N, meanYS(:,1), stdYS(:,1), 'k', 'linestyle', 'none');
    plot(i, meanUE(i,1), 's', 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'none', 'MarkerSize', 8); hold on%, 'filled', 'MarkerFaceColor', colors(i,:)); hold on
    plot(i, meanUE(i,2), 'd', 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'none', 'MarkerSize', 8);
    plot(i, meanTFS(i,1), '+', 'Color', colors(i,:),  'MarkerSize', 10, 'linewidth', 3);
    plot(i, meanTFS(i,2), 'x', 'Color', colors(i,:),  'MarkerSize', 10, 'linewidth', 3);
end
set(gca, 'XTickLabel', ['' ,test_tags]);
xlim([0 7])
ylim([0 1])
ylabel('Strain')
pbaspect([1 1 1]);


figure(4)
subplot(1,2,1)
for i = 1:N
    plot(meanUE, meanTFS, '.'); hold on
    for j = 1:2
        if j == 1
            curLabel = char([meta{i}.tag 'L']);
            text(meanUE(i,j), meanTFS(i,j)+0.05, curLabel, 'HorizontalAlignment', 'center')
        elseif j == 2
            curLabel = char([meta{i}.tag 'T']);
            text(meanUE(i,j), meanTFS(i,j)+0.05, curLabel, 'HorizontalAlignment', 'center')
        end
    end
end
xlim([0 0.5])
ylim([0 1])
ylabel('TFS')
xlabel('UE')
pbaspect([1 1 1]);

% UTSxTU et sfxTFS
subplot(1,2,2)
for i = 1:N
    plot(meanUTSTU, meanTFS, '.'); hold on
    for j = 1:2
        if j == 1
            curLabel = char([meta{i}.tag 'L']);
            text(meanUE(i,j), meanTFS(i,j)+0.05, curLabel, 'HorizontalAlignment', 'center')
        elseif j == 2
            curLabel = char([meta{i}.tag 'T']);
            text(meanUE(i,j), meanTFS(i,j)+0.05, curLabel, 'HorizontalAlignment', 'center')
        end
    end
end


%% ECROUISSAGE
figure(5)

for i = 1:N
    subplot(2,3,i)
    for j = selectMeta(i,1)
        %fitdsde = smooth(meta{i}.data{j}.dsde, 50);
        plot(meta{i}.data{j}.s(1:end-1), meta{i}.data{j}.dsde(1:end), '-', 'color', colors(i,:), 'linewidth', 1.5); hold on
        %plot(meta{i}.data{j}.s(1:end-1)-meta{i}.data{j}.YS, fitdsde, 'k-')
    end
    xx = linspace(0, 2*meta{1}.slim, 100);
plot(xx, xx, 'k--')
%yticks([]);
%xticks([]);
xlim([500 meta{1}.slim*1.2])
ylim([0 12000])
ylabel('d\sigma/d\epsilon')
xlabel('\sigma ')
%pbaspect([1 1 1]);
end








