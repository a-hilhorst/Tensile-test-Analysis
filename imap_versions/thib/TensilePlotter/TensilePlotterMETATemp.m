% ----- TensilePlotterMetaTemp-----
% Purpose : - Plot toutes les courbes de tractions representatives, pour
%             essais en temperature
% Author : Thibaut Heremans
% Date : 01/07/24
% Comments : Load tous les output de TensilePlotter dans des sous structures

%% GENERAL
set(0,'DefaultFigureWindowStyle','normal')
set(0, 'DefaultAxesFontSize', 14);
clc; clear; close all;

%% Loading my data
load export_Tensile_GL-Temp.mat;
eelimMeta = 55;
Trange = [25 50 100 150 200 250];
Tlabels = ["25" "50" "100" "150" "200" "250"];
test_tags = [];
%% Figures
figure(1)
set(gcf, 'Position', [50, 50, 800, 400]);       % ENGINEERING CURVES
figure(2)
set(gcf, 'Position', [700, 300, 800, 400]);     % TRUE CURVES
figure(3)
set(gcf, 'Position', [700, 150, 800, 400]);     % PROPR MECA
%figure(4)
%set(gcf, 'Position', [50, 150, 800, 400]);
%figure(5)
%set(gcf, 'Position', [100, 200, 800, 400]);
colors = [9 101 170;...
          8 145 145;...
          109 177 20;...
          242 172 13;...
          194 10 10;...
          145 8 115]/250;
      
 selectT = [1 2 3 4 5 6 8 9 10 11 12 13];     

%% Plotting eng et true
for i = selectT
    idxT = find(data{i}.T == Trange);
    % Engineering
    figure(1)
    plot(data{i}.ee*100, data{i}.se, 'color', colors(idxT,:)); hold on
    [~, idx_max] = max(data{i}.se);
    plot(data{i}.ee(idx_max)*100, data{i}.se(idx_max), 'ok', 'markersize', 4, 'markerFaceColor', colors(idxT,:))
    plot(data{i}.xYS, data{i}.YS, 'sk', 'markersize', 5, 'markerFaceColor', colors(idxT,:))
    curLabel = char(labels(i));
    text(data{i}.ee(end)*100, data{i}.se(end)-25, curLabel(1:end), 'HorizontalAlignment', 'center')
    title('Engineering curves')
    ylabel('Eng. stress \sigma_e [MPa]');
    xlabel('Eng. strain \epsilon_e [%]');
    xlim([0 eelimMeta])
    ylim([0 slim])
    
    
    
    figure(2)
    plot(data{i}.e, data{i}.s, 'color', colors(idxT,:)); hold on
    plot([data{i}.e(end) data{i}.TFS], [data{i}.s(end) data{i}.sf], '--', 'color', colors(idxT,:))
    plot(data{i}.e(end) , data{i}.s(end) , '.', 'markersize', 15, 'color', colors(idxT,:))
    plot(data{i}.TFS, data{i}.sf, 'x', 'markersize', 5, 'linewidth', 1.5, 'color', colors(idxT,:))
    curLabel = char(labels(i));
    text(data{i}.TFS+0.05, data{i}.sf, curLabel(1:end), 'HorizontalAlignment', 'center')
    
    title('True curves')
    ylabel('True stress \sigma [MPa]');
    xlabel('True strain \epsilon');
    xlim([0 1])
    ylim([0 2500])
end



%% Stats mechanical properties
% decomposition en temperature de n'importe quel propriete
[meanYS, stdYS] = TempProp(data(selectT), 'YS');
[meanUTS, stdUTS] = TempProp(data(selectT), 'UTS');
[meansf, stdsf] = TempProp(data(selectT), 'sf');
[meanUE, stdUE] = TempProp(data(selectT), 'UE');
[meanTFS, stdTFS] = TempProp(data(selectT), 'TFS');

% plotting
figure(3)
subplot(1,2,1)
plot(meanYS, 'k-'); hold on;
plot(meanUTS, 'k-')
plot(meansf, 'k-')
for i = 1:length(Trange)
    errorbar(i, meanYS(i), stdYS(i), 'k', 'linestyle', 'none');hold on;
    plot(i, meanYS(i), 's', 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'none', 'MarkerSize', 8); hold on%, 'filled', 'MarkerFaceColor', colors(i,:)); hold on
    errorbar(i, meanUTS(i), stdUTS(i), 'k', 'linestyle', 'none');
    plot(i, meanUTS(i), 'o', 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'none', 'MarkerSize', 8); hold on%, 'filled', 'MarkerFaceColor', colors(i,:)); hold on
    errorbar(i, meansf(i), stdsf(i), 'k', 'linestyle', 'none');
    plot(i, meansf(i), 'x', 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', colors(i,:), 'MarkerSize', 12, 'linewidth', 3); hold on%, 'filled', 'MarkerFaceColor', colors(i,:)); hold on

end
xticks([1:7]);
xticklabels(Tlabels)
xlim([0 7])
ylim([500 2500])
ylabel('\sigma [MPa]')
xlabel('T [°C]')
pbaspect([1 1 1]);

subplot(1,2,2)
plot(meanUE, 'k-'); hold on;
plot(meanTFS, 'k-')
for i = 1:length(Trange)
    errorbar(i, meanUE(i), stdUE(i), 'k', 'linestyle', 'none');
    plot(i, meanUE(i), 'o', 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'none', 'MarkerSize', 8); hold on%, 'filled', 'MarkerFaceColor', colors(i,:)); hold on
    errorbar(i, meanTFS(i), stdTFS(i), 'k', 'linestyle', 'none');
    plot(i, meanTFS(i), 'x', 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', colors(i,:), 'MarkerSize', 12, 'linewidth', 3); hold on%, 'filled', 'MarkerFaceColor', colors(i,:)); hold on
end
xticks([1:7]);
xticklabels(Tlabels)
xlim([0 7])
ylim([0 1])
ylabel('\epsilon [-]')
xlabel('T [°C]')
pbaspect([1 1 1]);

%
% figure(4)
% subplot(1,2,1)
% for i = 1:N
%     plot(meanUE, meanTFS, '.'); hold on
%     for j = 1:2
%         if j == 1
%             curLabel = char([meta{i}.tag 'L']);
%             text(meanUE(i,j), meanTFS(i,j)+0.05, curLabel, 'HorizontalAlignment', 'center')
%         elseif j == 2
%             curLabel = char([meta{i}.tag 'T']);
%             text(meanUE(i,j), meanTFS(i,j)+0.05, curLabel, 'HorizontalAlignment', 'center')
%         end
%     end
% end
% xlim([0 0.5])
% ylim([0 1])
% ylabel('TFS')
% xlabel('UE')
% pbaspect([1 1 1]);



% %% ECROUISSAGE
% figure(5)
%
% for i = 1:N
%     subplot(2,3,i)
%     for j = selectMeta(i,2)
%         %fitdsde = smooth(meta{i}.data{j}.dsde, 50);
%         plot(meta{i}.data{j}.s(1:end-1), meta{i}.data{j}.dsde(1:end), '-', 'color', colors(i,:), 'linewidth', 1.5); hold on
%         %plot(meta{i}.data{j}.s(1:end-1)-meta{i}.data{j}.YS, fitdsde, 'k-')
%     end
%     xx = linspace(0, 2*meta{1}.slim, 100);
% plot(xx, xx, 'k--')
% %yticks([]);
% %xticks([]);
% xlim([500 meta{1}.slim*1.2])
% ylim([0 12000])
% ylabel('d\sigma/d\epsilon')
% xlabel('\sigma ')
% %pbaspect([1 1 1]);
% end
%







