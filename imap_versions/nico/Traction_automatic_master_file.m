%% 
close all; clc; 
set(0,'defaulttextInterpreter','latex','DefaultAxesFontSize',18);
set(0, 'DefaultTextFontSize', 18);
set(0,'defaultLineLineWidth',2.0);
%%
%Traction automatic master file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%SS horizontal%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%AB
[stress_0_2_AB, strain_0_2_AB, prop_0_2_AB] = read_traction_data_file('Results\Horizontal SS\0_2_AB.XLSX',20,3.96);
%1H470
[stress_0_1_1H470, strain_0_1_1H470, prop_0_1_1H470] = read_traction_data_file('Results\Horizontal SS\0_1_1H470.XLSX',20,3.96);
%1H470 + 24H120
[stress_0_3_1H470aged, strain_0_3_1H470aged, prop_0_3_1H470aged] = read_traction_data_file('Results\Horizontal SS\0_3_1H470aged.XLSX',20,3.97);

%%%%%%%%%%%%%%%%%%%%%%%%%%SS vertical%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%AB
[stress_G_1_AB, strain_G_1_AB, prop_G_1_AB] = read_traction_data_file('Results\Vertical SS\G_1_AB_SS.XLSX',20,4);
[stress_G_2_AB, strain_G_2_AB, prop_G_2_AB] = read_traction_data_file('Results\Vertical SS\G_2_AB_SS_problem.XLSX',20,3.993);
[stress_G_3_AB, strain_G_3_AB, prop_G_3_AB] = read_traction_data_file('Results\Vertical SS\G_3_AB_SS.XLSX',20,4);

%ATTENTION PROBLEME DANS LES TESTS A MODIF
Mean_SS_V_AB = mean([prop_G_1_AB' ; prop_G_2_AB' ; prop_G_3_AB']);
Stdev_SS_V_AB = std([prop_G_1_AB' ; prop_G_2_AB' ; prop_G_3_AB']);

%1H425 + 24H120
[stress_I_1_1H425aged, strain_I_1_1H425aged, prop_I_1_1H425aged] = read_traction_data_file('Results\Vertical SS\I_1_425T6_SS.XLSX',20,3.987);
[stress_I_2_1H425aged, strain_I_2_1H425aged, prop_I_2_1H425aged] = read_traction_data_file('Results\Vertical SS\I_2_425T6_SS.XLSX',20,3.993);
[stress_I_3_1H425aged, strain_I_3_1H425aged, prop_I_3_1H425aged] = read_traction_data_file('Results\Vertical SS\I_3_425T6_SS.XLSX',20,3.99);

Mean_SS_V_1H425aged = mean([prop_I_1_1H425aged' ; prop_I_2_1H425aged' ; prop_I_3_1H425aged']);
Stdev_SS_V_1H425aged = std([prop_I_1_1H425aged' ; prop_I_2_1H425aged' ; prop_I_3_1H425aged']);

%1H470 + 24H120
[stress_K_1_1H470aged, strain_K_1_1H470aged, prop_K_1_1H470aged] = read_traction_data_file('Results\Vertical SS\K_1_470T6_SS.XLSX',20,3.99);
[stress_K_2_1H470aged, strain_K_2_1H470aged, prop_K_2_1H470aged] = read_traction_data_file('Results\Vertical SS\K_2_470T6_SS.XLSX',20,3.987);
[stress_K_3_1H470aged, strain_K_3_1H470aged, prop_K_3_1H470aged] = read_traction_data_file('Results\Vertical SS\K_3_470T6_SS.XLSX',20,3.987);

Mean_SS_V_1H470aged = mean([prop_K_1_1H470aged' ; prop_K_2_1H470aged' ; prop_K_3_1H470aged']);
Stdev_SS_V_1H470aged = std([prop_K_1_1H470aged' ; prop_K_2_1H470aged' ; prop_K_3_1H470aged']);


%%%%%%%%%%%%%%%%%%%%%%PS horizontal%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%AB 
[stress_5C3_AB, strain_5C3_AB, prop_5C3_AB,stress_5C3_AB_t, strain_5C3_AB_t, prop_5C3_AB_t] = read_traction_data_file_true('Results\Horizontal PS\5C3_AB.XLSX',20,3.96,3.66);
[stress_5C2_AB, strain_5C2_AB, prop_5C2_AB] = read_traction_data_file('Results\Horizontal PS\5C2_AB.XLSX',20,3.98);
[stress_5D1_AB, strain_5D1_AB, prop_5D1_AB,stress_5D1_AB_t, strain_5D1_AB_t, prop_5D1_AB_t] = read_traction_data_file_true('Results\Horizontal PS\5D1_AB.XLSX',20,3.99,3.611);

Mean_PS_H_AB = mean([prop_5C3_AB' ; prop_5C2_AB' ; prop_5D1_AB']);
Stdev_PS_H_AB = std([prop_5C3_AB' ; prop_5C2_AB' ; prop_5D1_AB']);

Mean_PS_H_AB_t = mean([prop_5C3_AB_t' ; prop_5D1_AB_t']);
Stdev_PS_H_AB_t = std([prop_5C3_AB_t' ; prop_5D1_AB_t']);

%HT
%1H425
[stress_5B1_1H425, strain_5B1_1H425, prop_5B1_1H425] = read_traction_data_file('Results\Horizontal PS\5B1_1H425.XLSX',20,3.95);
[stress_E2_1H425, strain_E2_1H425, prop_E2_1H425] = read_traction_data_file('Results\Horizontal PS\E2_1H425.XLSX',20,3.9570);
[stress_D2_1H425, strain_D2_1H425, prop_D2_1H425] = read_traction_data_file('Results\Horizontal PS\D2_1H425.XLSX',20,3.998);


Mean_PS_H_1H425 = mean([prop_5B1_1H425' ; prop_E2_1H425' ; prop_D2_1H425']);
Stdev_PS_H_1H425 = std([prop_5B1_1H425' ; prop_E2_1H425' ; prop_D2_1H425']);

%1H425 + 24H120
[stress_5B2_1H425aged, strain_5B2_1H425aged, prop_5B2_1H425aged] = read_traction_data_file('Results\Horizontal PS\5B2_1H425aged.XLSX',20,3.97);
[stress_E4_1H425aged, strain_E4_1H425aged, prop_E4_1H425aged,stress_E4_1H425aged_t, strain_E4_1H425aged_t, prop_E4_1H425aged_t] = read_traction_data_file_true('Results\Horizontal PS\E4_1H425aged.XLSX',20,3.95,3.515);
[stress_E5_1H425aged, strain_E5_1H425aged, prop_E5_1H425aged,stress_E5_1H425aged_t, strain_E5_1H425aged_t, prop_E5_1H425aged_t] = read_traction_data_file_true('Results\Horizontal PS\E5_1H425aged.XLSX',20,3.947,3.597);

Mean_PS_H_1H425aged = mean([prop_5B2_1H425aged' ; prop_E4_1H425aged' ; prop_E5_1H425aged']);
Stdev_PS_H_1H425aged = std([prop_5B2_1H425aged' ; prop_E4_1H425aged' ; prop_E5_1H425aged']);

Mean_PS_H_1H425aged_t = mean([prop_E4_1H425aged_t' ; prop_E5_1H425aged_t']);
Stdev_PS_H_1H425aged_t = std([prop_E4_1H425aged_t' ; prop_E5_1H425aged_t']);

%1H450
[stress_5A1_1H450, strain_5A1_1H450, prop_5A1_1H450] = read_traction_data_file('Results\Horizontal PS\5A1_1H450.XLSX',20,3.92);
%1H450 + 24H120
[stress_5A3_1H450aged, strain_5A3_1H450aged, prop_5A3_1H450aged] = read_traction_data_file('Results\Horizontal PS\5A3_1H450aged.XLSX',20,3.94);

%1H470
[stress_5A4_1H470, strain_5A4_1H470, prop_5A4_1H470] = read_traction_data_file('Results\Horizontal PS\5A4_1H470.XLSX',20,3.9);
[stress_E3_1H470, strain_E3_1H470, prop_E3_1H470] = read_traction_data_file('Results\Horizontal PS\E3_1H470.XLSX',20,3.9470);
[stress_D3_1H470, strain_D3_1H470, prop_D3_1H470] = read_traction_data_file('Results\Horizontal PS\D3_1H470.XLSX',20,3.97);

Mean_PS_H_1H470 = mean([prop_5A4_1H470' ; prop_E3_1H470' ; prop_D3_1H470']);
Stdev_PS_H_1H470 = std([prop_5A4_1H470' ; prop_E3_1H470' ; prop_D3_1H470']);

%1H470 + 24H120
[stress_5A2_1H470aged, strain_5A2_1H470aged, prop_5A2_1H470aged] = read_traction_data_file('Results\Horizontal PS\5A2_1H470aged.XLSX',20,3.93);
[stress_E6_1H470aged, strain_E6_1H470aged, prop_E6_1H470aged] = read_traction_data_file('Results\Horizontal PS\E6_1H470aged.XLSX',20,3.95);
[stress_E7_1H470aged, strain_E7_1H470aged, prop_E7_1H470aged] = read_traction_data_file('Results\Horizontal PS\E7_1H470aged.XLSX',20,3.9430);

Mean_PS_H_1H470aged = mean([prop_5A2_1H470aged' ; prop_E6_1H470aged' ; prop_E7_1H470aged']);
Stdev_PS_H_1H470aged = std([prop_5A2_1H470aged' ; prop_E6_1H470aged' ; prop_E7_1H470aged']);

%%%%%%%%%%%%%%%%%%%%%%%PS vertical%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%AB
[stress_F_1_AB, strain_F_1_AB, prop_F_1_AB] = read_traction_data_file('Results\Vertical PS\F_1_AB_PS.XLSX',20,3.997);
[stress_F_2_AB, strain_F_2_AB, prop_F_2_AB,stress_F_2_AB_t, strain_F_2_AB_t, prop_F_2_AB_t] = read_traction_data_file_true('Results\Vertical PS\F_2_AB_PS.XLSX',20,4,3.617);
[stress_F_3_AB, strain_F_3_AB, prop_F_3_AB,stress_F_3_AB_t, strain_F_3_AB_t, prop_F_3_AB_t] = read_traction_data_file_true('Results\Vertical PS\F_3_AB_PS.XLSX',20,4,3.602);

Mean_PS_V_AB = mean([prop_F_1_AB' ; prop_F_2_AB' ; prop_F_3_AB']);
Stdev_PS_V_AB = std([prop_F_1_AB' ; prop_F_2_AB' ; prop_F_3_AB']);

Mean_PS_V_AB_t = mean([prop_F_2_AB_t' ; prop_F_3_AB_t']);
Stdev_PS_V_AB_t = std([prop_F_2_AB_t' ; prop_F_3_AB_t']);

%1H425 + 24H120
[stress_H_1_1H425aged, strain_H_1_1H425aged, prop_H_1_1H425aged] = read_traction_data_file('Results\Vertical PS\H_1_425T6_PS.XLSX',20,3.997);
[stress_H_2_1H425aged, strain_H_2_1H425aged, prop_H_2_1H425aged,stress_H_2_1H425aged_t, strain_H_2_1H425aged_t, prop_H_2_1H425aged_t] = read_traction_data_file_true('Results\Vertical PS\H_2_425T6_PS.XLSX',20,3.997,3.788);
[stress_H_3_1H425aged, strain_H_3_1H425aged, prop_H_3_1H425aged,stress_H_3_1H425aged_t, strain_H_3_1H425aged_t, prop_H_3_1H425aged_t] = read_traction_data_file_true('Results\Vertical PS\H_3_425T6_PS.XLSX',20,3.997,3.716);

Mean_PS_V_1H425aged = mean([prop_H_1_1H425aged' ; prop_H_2_1H425aged' ; prop_H_3_1H425aged']);
Stdev_PS_V_1H425aged = std([prop_H_1_1H425aged' ; prop_H_2_1H425aged' ; prop_H_3_1H425aged']);

Mean_PS_V_1H425aged_t = mean([prop_H_2_1H425aged_t' ; prop_H_3_1H425aged_t']);
Stdev_PS_V_1H425aged_t = std([prop_H_2_1H425aged_t' ; prop_H_3_1H425aged_t']);

%1H470 + 24H120
[stress_J_1_1H470aged, strain_J_1_1H470aged, prop_J_1_1H470aged] = read_traction_data_file('Results\Vertical PS\J_1_470T6_PS.XLSX',20,3.99);
[stress_J_2_1H470aged, strain_J_2_1H470aged, prop_J_2_1H470aged] = read_traction_data_file('Results\Vertical PS\J_2_470T6_PS.XLSX',20,4);
[stress_J_3_1H470aged, strain_J_3_1H470aged, prop_J_3_1H470aged] = read_traction_data_file('Results\Vertical PS\J_3_470T6_PS.XLSX',20,3.99);

Mean_PS_V_1H470aged = mean([prop_J_1_1H470aged' ; prop_J_2_1H470aged' ; prop_J_3_1H470aged']);
Stdev_PS_V_1H470aged = std([prop_J_1_1H470aged' ; prop_J_2_1H470aged' ; prop_J_3_1H470aged']);


%%%%%%%%%%%%%%%%%%%%%%%%%%FSP Curves%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[stress_FSP_AB_1, strain_FSP_AB_1, prop_FSP_AB_1] = read_traction_data_file('Results\FSP\FSP_AB_1_Traction-11.XLSX',20,3.997);
[stress_FSP_T6_1, strain_FSP_T6_1, prop_FSP_T6_1,stress_FSP_T6_1_t, strain_FSP_T6_1_t, prop_FSP_T6_1_t] = read_traction_data_file_true('Results\FSP\FSP_T6_1_Traction-12.XLSX',20,4,3.255);
[stress_FSP_T6_2, strain_FSP_T6_2, prop_FSP_T6_2] = read_traction_data_file('Results\FSP\FSP_T6_2_Traction-13.XLSX',20,4);


%%%%%%%%%%%%%%%%%%%%%%%Micro-tensile Lv%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

micro_tensile = readmatrix('Results\Copie de Micro-DIC curve_Lv.xlsx');

strain_AB_V_1 = micro_tensile(:,1)*100;
stress_AB_V_1 = micro_tensile(:,2);

strain_AB_V_2 = micro_tensile(:,3)*100;
stress_AB_V_2 = micro_tensile(:,4);

strain_AB_V_inter = micro_tensile(:,5)*100;
stress_AB_V_inter = micro_tensile(:,6);

strain_AB_H_1 = micro_tensile(:,7)*100;
stress_AB_H_1 = micro_tensile(:,8);

strain_AB_H_2 = micro_tensile(:,9)*100;
stress_AB_H_2 = micro_tensile(:,10);

strain_AB_H_inter = micro_tensile(:,11)*100;
stress_AB_H_inter = micro_tensile(:,12);

strain_HT_V_1 = micro_tensile(:,13)*100;
stress_HT_V_1 = micro_tensile(:,14);

strain_HT_V_2 = micro_tensile(:,15)*100;
stress_HT_V_2 = micro_tensile(:,16);

strain_HT_V_3 = micro_tensile(:,17)*100;
stress_HT_V_3 = micro_tensile(:,18);

strain_HT_V_inter = micro_tensile(:,19)*100;
stress_HT_V_inter = micro_tensile(:,20);

strain_HT_H_1 = micro_tensile(:,21)*100;
stress_HT_H_1 = micro_tensile(:,22);

strain_HT_H_inter1 = micro_tensile(:,23)*100;
stress_HT_H_inter1 = micro_tensile(:,24);

strain_HT_H_inter2 = micro_tensile(:,25)*100;
stress_HT_H_inter2 = micro_tensile(:,26);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%true stress true strain graphs
fig_true = figure;
set(gcf,'PaperOrientation','landscape')
hold on;
%H PS
plot(strain_5C3_AB_t,stress_5C3_AB_t,'k')
plot(strain_5D1_AB_t,stress_5D1_AB_t,'k')

plot(strain_E4_1H425aged_t,stress_E4_1H425aged_t,'b')
plot(strain_E5_1H425aged_t,stress_E5_1H425aged_t,'b')

%V PS
plot(strain_F_2_AB_t,stress_F_2_AB_t,'Color','#7d7d7d')
plot(strain_F_3_AB_t,stress_F_3_AB_t,'Color','#7d7d7d')

plot(strain_H_2_1H425aged_t,stress_H_2_1H425aged_t,'Color','#7f7fff')
plot(strain_H_3_1H425aged_t,stress_H_3_1H425aged_t,'Color','#7f7fff')

%FSP
%plot(strain_FSP_T6_1_t,stress_FSP_T6_1_t,'Color','#27c631')

%to fracture
%H PS
plot([strain_5C3_AB_t(end),prop_5C3_AB_t(2)],[stress_5C3_AB_t(end),prop_5C3_AB_t(3)],'k','LineStyle',':')
plot([strain_5D1_AB_t(end),prop_5D1_AB_t(2)],[stress_5D1_AB_t(end),prop_5D1_AB_t(3)],'k','LineStyle',':')

plot([strain_E4_1H425aged_t(end),prop_E4_1H425aged_t(2)],[stress_E4_1H425aged_t(end),prop_E4_1H425aged_t(3)],'b','LineStyle',':')
plot([strain_E5_1H425aged_t(end),prop_E5_1H425aged_t(2)],[stress_E5_1H425aged_t(end),prop_E5_1H425aged_t(3)],'b','LineStyle',':')


%V PS
plot([strain_F_2_AB_t(end),prop_F_2_AB_t(2)],[stress_F_2_AB_t(end),prop_F_2_AB_t(3)],'Color','#7d7d7d','LineStyle',':')
plot([strain_F_3_AB_t(end),prop_F_3_AB_t(2)],[stress_F_3_AB_t(end),prop_F_3_AB_t(3)],'Color','#7d7d7d','LineStyle',':')

plot([strain_H_2_1H425aged_t(end),prop_H_2_1H425aged_t(2)],[stress_H_2_1H425aged_t(end),prop_H_2_1H425aged_t(3)],'Color','#7f7fff','LineStyle',':')
plot([strain_H_3_1H425aged_t(end),prop_H_3_1H425aged_t(2)],[stress_H_3_1H425aged_t(end),prop_H_3_1H425aged_t(3)],'Color','#7f7fff','LineStyle',':')

%FSP
%plot([strain_FSP_T6_1_t(end),prop_FSP_T6_1_t(2)],[stress_FSP_T6_1_t(end),prop_FSP_T6_1_t(3)],'Color','#27c631','LineStyle',':')


xlabel('True strain $[-]$');
ylabel('True stress [MPa]');
%xlim([0 14]);
%xlim([0 16]);
%ylim([0 600]);
title('Al7075+ZrH2 2$\%$ mix HT pre-sinter: true stress strain');
%set(gca,'FontSize',13);
legend('AB H','AB H','1H425T6 H','1H425T6 H','AB V','AB V','1H425T6 V','1H425T6 V','location','southeast');
%legend('AB H','AB H','1H425T6 H','1H425T6 H','AB V','AB V','1H425T6 V','1H425T6 V','FSP + 1H425T6','location','southeast');
%print(fig_true,'Tensile_true_06_24','-dpdf','-fillpage')
hold off;

%true stress true strain graphs
fig_true = figure;
set(gcf,'PaperOrientation','landscape')
hold on;
%H PS

plot(stress_5C3_AB_t(1000:end),(stress_5C3_AB_t(1000:end)-stress_5C3_AB_t(1:end-999))./(strain_5C3_AB_t(1000:end)-strain_5C3_AB_t(1:end-999)),'k')
% plot(strain_5D1_AB_t,stress_5D1_AB_t,'k')
% 
% plot(strain_E4_1H425aged_t,stress_E4_1H425aged_t,'b')
% plot(strain_E5_1H425aged_t,stress_E5_1H425aged_t,'b')
% 
% %V PS
plot(stress_F_2_AB_t(1000:end),(stress_F_2_AB_t(1000:end)-stress_F_2_AB_t(1:end-999))./(strain_F_2_AB_t(1000:end)-strain_F_2_AB_t(1:end-999)),'Color','#7d7d7d')

% plot(strain_F_2_AB_t,stress_F_2_AB_t,'Color','#7d7d7d')
% plot(strain_F_3_AB_t,stress_F_3_AB_t,'Color','#7d7d7d')
% 
plot(stress_H_2_1H425aged_t(1000:end),(stress_H_2_1H425aged_t(1000:end)-stress_H_2_1H425aged_t(1:end-999))./(strain_H_2_1H425aged_t(1000:end)-strain_H_2_1H425aged_t(1:end-999)),'Color','#7f7fff')

plot(stress_E4_1H425aged_t(1000:end),(stress_E4_1H425aged_t(1000:end)-stress_E4_1H425aged_t(1:end-999))./(strain_E4_1H425aged_t(1000:end)-strain_E4_1H425aged_t(1:end-999)),'b')

% plot(strain_H_2_1H425aged_t,stress_H_2_1H425aged_t,'Color','#7f7fff')
% plot(strain_H_3_1H425aged_t,stress_H_3_1H425aged_t,'Color','#7f7fff')
% 
% %FSP
% %plot(strain_FSP_T6_1_t,stress_FSP_T6_1_t,'Color','#27c631')
% 
% %to fracture
% %H PS
% plot([strain_5C3_AB_t(end),prop_5C3_AB_t(2)],[stress_5C3_AB_t(end),prop_5C3_AB_t(3)],'k','LineStyle',':')
% plot([strain_5D1_AB_t(end),prop_5D1_AB_t(2)],[stress_5D1_AB_t(end),prop_5D1_AB_t(3)],'k','LineStyle',':')
% 
% plot([strain_E4_1H425aged_t(end),prop_E4_1H425aged_t(2)],[stress_E4_1H425aged_t(end),prop_E4_1H425aged_t(3)],'b','LineStyle',':')
% plot([strain_E5_1H425aged_t(end),prop_E5_1H425aged_t(2)],[stress_E5_1H425aged_t(end),prop_E5_1H425aged_t(3)],'b','LineStyle',':')
% 
% 
% %V PS
% plot([strain_F_2_AB_t(end),prop_F_2_AB_t(2)],[stress_F_2_AB_t(end),prop_F_2_AB_t(3)],'Color','#7d7d7d','LineStyle',':')
% plot([strain_F_3_AB_t(end),prop_F_3_AB_t(2)],[stress_F_3_AB_t(end),prop_F_3_AB_t(3)],'Color','#7d7d7d','LineStyle',':')
% 
% plot([strain_H_2_1H425aged_t(end),prop_H_2_1H425aged_t(2)],[stress_H_2_1H425aged_t(end),prop_H_2_1H425aged_t(3)],'Color','#7f7fff','LineStyle',':')
% plot([strain_H_3_1H425aged_t(end),prop_H_3_1H425aged_t(2)],[stress_H_3_1H425aged_t(end),prop_H_3_1H425aged_t(3)],'Color','#7f7fff','LineStyle',':')
% 
% %FSP
% %plot([strain_FSP_T6_1_t(end),prop_FSP_T6_1_t(2)],[stress_FSP_T6_1_t(end),prop_FSP_T6_1_t(3)],'Color','#27c631','LineStyle',':')
% 

xlabel('True stress [MPa]');
ylabel('$\delta (\sigma_t)/\delta (\epsilon_t)$');
%xlim([0 14]);
%xlim([0 16]);
%ylim([0 600]);
title('Al7075+ZrH2 2$\%$ mix HT pre-sinter: d sigma d eps');
%set(gca,'FontSize',13);
legend('AB H','AB V','1H425T6 V','1H425T6 H','location','southeast');
%legend('AB H','AB H','1H425T6 H','1H425T6 H','AB V','AB V','1H425T6 V','1H425T6 V','FSP + 1H425T6','location','southeast');
%print(fig_true,'Tensile_true_06_24','-dpdf','-fillpage')
hold off;

%PS horizontal vs vertical TMS AB + T6
fig_eng = figure;
set(gcf,'PaperOrientation','landscape')
hold on;
%H PS
plot(strain_5C2_AB,stress_5C2_AB,'k')
plot(strain_5C3_AB,stress_5C3_AB,'k')%select
plot(strain_5D1_AB,stress_5D1_AB,'k')

plot(strain_5B2_1H425aged,stress_5B2_1H425aged,'b')
plot(strain_E4_1H425aged,stress_E4_1H425aged,'b')%select
plot(strain_E5_1H425aged,stress_E5_1H425aged,'b')
% 
% plot(strain_5A2_1H470aged,stress_5A2_1H470aged,'r')
% plot(strain_E6_1H470aged,stress_E6_1H470aged,'r')
% plot(strain_E7_1H470aged,stress_E7_1H470aged,'r')

%V PS
plot(strain_F_1_AB,stress_F_1_AB,'Color','#7d7d7d')
plot(strain_F_2_AB,stress_F_2_AB,'Color','#7d7d7d')%select
plot(strain_F_3_AB,stress_F_3_AB,'Color','#7d7d7d')

plot(strain_H_1_1H425aged,stress_H_1_1H425aged,'Color','#7f7fff')
plot(strain_H_2_1H425aged,stress_H_2_1H425aged,'Color','#7f7fff')
plot(strain_H_3_1H425aged,stress_H_3_1H425aged,'Color','#7f7fff') %select
% 
% plot(strain_J_1_1H470aged,stress_J_1_1H470aged,'r','LineStyle',':')
% plot(strain_J_2_1H470aged,stress_J_2_1H470aged,'r','LineStyle',':')
% plot(strain_J_3_1H470aged,stress_J_3_1H470aged,'r','LineStyle',':') %'LineStyle'


xlabel('Engineering strain $[\%]$');
ylabel('Engineering stress [MPa]');
%xlim([0 14]);
xlim([0 16]);
ylim([0 600]);
title('Al7075+ZrH2 2$\%$ mix HT pre-sinter: uniaxial tension orientation effect');
%set(gca,'FontSize',13);
%legend('AB H','AB H','AB H','T6 H','T6 H','T6 H','AB V','AB V','AB V','T6 V','T6 V','T6 V','location','southeast');
%print(fig_eng,'Tensile_eng_supp_07_24','-dpdf','-fillpage')
hold off;

%PS horizontal vs vertical
% figure;
% hold on;
% %H PS
% plot(strain_5C2_AB,stress_5C2_AB,'k')
% plot(strain_5C3_AB,stress_5C3_AB,'k')
% plot(strain_5D1_AB,stress_5D1_AB,'k')
% 
% plot(strain_5B2_1H425aged,stress_5B2_1H425aged,'w')
% plot(strain_E4_1H425aged,stress_E4_1H425aged,'w')
% plot(strain_E5_1H425aged,stress_E5_1H425aged,'w')
% 
% plot(strain_5A2_1H470aged,stress_5A2_1H470aged,'r')
% plot(strain_E6_1H470aged,stress_E6_1H470aged,'r')
% plot(strain_E7_1H470aged,stress_E7_1H470aged,'r')
% 
% %V PS
% plot(strain_F_1_AB,stress_F_1_AB,'k','LineStyle',':')
% plot(strain_F_2_AB,stress_F_2_AB,'k','LineStyle',':')
% plot(strain_F_3_AB,stress_F_3_AB,'k','LineStyle',':')
% 
% plot(strain_H_1_1H425aged,stress_H_1_1H425aged,'w','LineStyle',':')
% plot(strain_H_2_1H425aged,stress_H_2_1H425aged,'w','LineStyle',':')
% plot(strain_H_3_1H425aged,stress_H_3_1H425aged,'w','LineStyle',':')
% 
% plot(strain_J_1_1H470aged,stress_J_1_1H470aged,'r','LineStyle',':')
% plot(strain_J_2_1H470aged,stress_J_2_1H470aged,'r','LineStyle',':')
% plot(strain_J_3_1H470aged,stress_J_3_1H470aged,'r','LineStyle',':') %'LineStyle'
% 
% 
% xlabel('Engineering strain $[\%]$');
% ylabel('Engineering stress [MPa]');
% %xlim([0 14]);
% xlim([0 16]);
% ylim([0 600]);
% title('Al7075+ZrH2 2$\%$ mix HT pre-sinter: uniaxial tension orientation effect');
% %set(gca,'FontSize',13);
% legend('AB H','AB H','AB H','1H425T6 H','1H425T6 H','1H425T6 H','1H470T6 H','1H470T6 H','1H470T6 H','AB V','AB V','AB V','1H425T6 V','1H425T6 V','1H425T6 V','1H470T6 V','1H470T6 V','1H470T6 V','location','bestoutside');
% %legend('1H425','1H450','1H470','1H425aged','1H450aged','1H470aged','single 1H470 aged','location','southeast');
% %legend('1H425 aged','1H450 aged','1H470 aged','single 1H470 aged','1H425 aged L','1H450 aged L','1H470 aged L','single 1H470 aged L','location','southeast'); %Sigma 0.2
% hold off;
% 
% %PS vertical vs SS vertical
% figure;
% hold on;
% %V SS
% plot(strain_G_1_AB,stress_G_1_AB,'k','LineStyle',':')
% plot(strain_G_2_AB,stress_G_2_AB,'k','LineStyle',':')
% plot(strain_G_3_AB,stress_G_3_AB,'k','LineStyle',':')
% 
% plot(strain_I_1_1H425aged,stress_I_1_1H425aged,'b','LineStyle',':')
% plot(strain_I_2_1H425aged,stress_I_2_1H425aged,'b','LineStyle',':')
% plot(strain_I_3_1H425aged,stress_I_3_1H425aged,'b','LineStyle',':')
% 
% plot(strain_K_1_1H470aged,stress_K_1_1H470aged,'r','LineStyle',':')
% plot(strain_K_2_1H470aged,stress_K_2_1H470aged,'r','LineStyle',':')
% plot(strain_K_3_1H470aged,stress_K_3_1H470aged,'r','LineStyle',':')
% 
% %V PS
% plot(strain_F_1_AB,stress_F_1_AB,'k')
% plot(strain_F_2_AB,stress_F_2_AB,'k')
% plot(strain_F_3_AB,stress_F_3_AB,'k')
% 
% plot(strain_H_1_1H425aged,stress_H_1_1H425aged,'b')
% plot(strain_H_2_1H425aged,stress_H_2_1H425aged,'b')
% plot(strain_H_3_1H425aged,stress_H_3_1H425aged,'b')
% 
% plot(strain_J_1_1H470aged,stress_J_1_1H470aged,'r')
% plot(strain_J_2_1H470aged,stress_J_2_1H470aged,'r')
% plot(strain_J_3_1H470aged,stress_J_3_1H470aged,'r')
% 
% 
% xlabel('Engineering strain $[\%]$');
% ylabel('Engineering stress [MPa]');
% %xlim([0 14]);
% xlim([0 16]);
% ylim([0 600]);
% title('Al7075+ZrH2 2$\%$ mix HT pre-sinter: uniaxial tension orientation effect');
% %set(gca,'FontSize',13);
% legend('AB V SS','AB V SS','AB V SS','1H425T6 V SS','1H425T6 V SS','1H425T6 V SS','1H470T6 V SS','1H470T6 V SS','1H470T6 V SS','AB V PS','AB V PS','AB V PS','1H425T6 V PS','1H425T6 V PS','1H425T6 V PS','1H470T6 V PS','1H470T6 V PS','1H470T6 V PS','location','bestoutside');
% %legend('1H425','1H450','1H470','1H425aged','1H450aged','1H470aged','single 1H470 aged','location','southeast');
% %legend('1H425 aged','1H450 aged','1H470 aged','single 1H470 aged','1H425 aged L','1H450 aged L','1H470 aged L','single 1H470 aged L','location','southeast'); %Sigma 0.2
% hold off;
% 
% %PS horizontal vs vertical TMS AB
% figure;
% hold on;
% %H PS
% plot(strain_5C2_AB,stress_5C2_AB,'b')
% plot(strain_5C3_AB,stress_5C3_AB,'b')
% plot(strain_5D1_AB,stress_5D1_AB,'b')
% 
% % plot(strain_5B2_1H425aged,stress_5B2_1H425aged,'b')
% % plot(strain_E4_1H425aged,stress_E4_1H425aged,'b')
% % plot(strain_E5_1H425aged,stress_E5_1H425aged,'b')
% % 
% % plot(strain_5A2_1H470aged,stress_5A2_1H470aged,'r')
% % plot(strain_E6_1H470aged,stress_E6_1H470aged,'r')
% % plot(strain_E7_1H470aged,stress_E7_1H470aged,'r')
% 
% %V PS
% plot(strain_F_1_AB,stress_F_1_AB,'Color','#b5b5ff')
% plot(strain_F_2_AB,stress_F_2_AB,'Color','#b5b5ff')
% plot(strain_F_3_AB,stress_F_3_AB,'Color','#b5b5ff')
% 
% % plot(strain_H_1_1H425aged,stress_H_1_1H425aged,'b','LineStyle',':')
% % plot(strain_H_2_1H425aged,stress_H_2_1H425aged,'b','LineStyle',':')
% % plot(strain_H_3_1H425aged,stress_H_3_1H425aged,'b','LineStyle',':')
% % 
% % plot(strain_J_1_1H470aged,stress_J_1_1H470aged,'r','LineStyle',':')
% % plot(strain_J_2_1H470aged,stress_J_2_1H470aged,'r','LineStyle',':')
% % plot(strain_J_3_1H470aged,stress_J_3_1H470aged,'r','LineStyle',':') %'LineStyle'
% 
% 
% xlabel('Engineering strain $[\%]$');
% ylabel('Engineering stress [MPa]');
% %xlim([0 14]);
% xlim([0 16]);
% ylim([0 550]);
% title('Al7075+ZrH2 2$\%$ mix HT pre-sinter: uniaxial tension orientation effect');
% %set(gca,'FontSize',13);
% legend('AB H','AB H','AB H','AB V','AB V','AB V','location','bestoutside');
% hold off;
% 

% 
% 
% %PS horizontal vs vertical TMS AB + T6 micro tensile Lv
% figure;
% hold on;
% 
% plot(strain_AB_V_1,stress_AB_V_1,'Color','#b5b5ff')
% % plot(strain_AB_V_2,stress_AB_V_2,'Color','#b5b5ff')
% % plot(strain_AB_V_inter,stress_AB_V_inter,'Color','#b5b5ff')
% 
% % plot(strain_AB_H_1,stress_AB_H_1,'b')
% plot(strain_AB_H_2,stress_AB_H_2,'b')
% % plot(strain_AB_H_inter,stress_AB_H_inter,'b')
% 
% % plot(strain_HT_V_1,stress_HT_V_1,'Color','#ff9494')
% % plot(strain_HT_V_2,stress_HT_V_2,'Color','#ff9494')
% plot(strain_HT_V_3,stress_HT_V_3,'Color','#ff9494')
% % plot(strain_HT_V_inter,stress_HT_V_inter,'Color','#ff9494')
% 
% plot(strain_HT_H_1,stress_HT_H_1,'r')
% % plot(strain_HT_H_inter1,stress_HT_H_inter1,'r')
% % plot(strain_HT_H_inter2,stress_HT_H_inter2,'r')
% 
% 
% 
% xlabel('Engineering strain $[\%]$');
% ylabel('Engineering stress [MPa]');
% %xlim([0 14]);
% xlim([0 25]);
% ylim([0 600]);
% title('Al7075+ZrH2 2$\%$ mix HT pre-sinter: micro-uniaxial tension orientation effect');
% %set(gca,'FontSize',13);
% legend('AB V','AB H','HT V','HT H','location','bestoutside');
% %legend('AB V','AB V','AB V inter','AB H','AB H','AB H inter','HT V','HT V','HT V','HT V inter','HT H','HT H inter1','HT H inter2','location','bestoutside');
% hold off;
% 
% %graph article 2
% figure;
% hold on;
% 
% plot(strain_5C3_AB,stress_5C3_AB)
% plot(strain_5C2_AB,stress_5C2_AB)
% plot(strain_5D1_AB,stress_5D1_AB)
% 
% plot(strain_5B1_1H425,stress_5B1_1H425,'Color','r')
% plot(strain_E2_1H425,stress_E2_1H425,'Color','g')
% plot(strain_D2_1H425,stress_D2_1H425,'Color','b')
% 
% plot(strain_5B2_1H425aged,stress_5B2_1H425aged)
% plot(strain_E4_1H425aged,stress_E4_1H425aged)
% plot(strain_E5_1H425aged,stress_E5_1H425aged)
% 
% plot(strain_5A4_1H470,stress_5A4_1H470)
% plot(strain_E3_1H470,stress_E3_1H470)
% plot(strain_D3_1H470,stress_D3_1H470)
% 
% plot(strain_5A2_1H470aged,stress_5A2_1H470aged)
% plot(strain_E6_1H470aged,stress_E6_1H470aged)
% plot(strain_E7_1H470aged,stress_E7_1H470aged)
% 
% 
% 
% xlabel('Engineering strain $[\%]$');
% ylabel('Engineering stress [MPa]');
% %xlim([0 14]);
% xlim([0 13]);
% ylim([0 600]);
% title('Al7075+ZrH2 2$\%$ mix HT pre-sinter: article 2');
% %set(gca,'FontSize',13);
% legend('AB','AB','AB','1H425','1H425','1H425','1H425T6','1H425T6','1H425T6','1H470','1H470','1H470','1H470T6','1H470T6','1H470T6','location','bestoutside');
% %legend('AB V','AB V','AB V inter','AB H','AB H','AB H inter','HT V','HT V','HT V','HT V inter','HT H','HT H inter1','HT H inter2','location','bestoutside');
% hold off;
% 
% %graph article 2 graphical abstract
% figure;
% hold on;
% 
% %plot(strain_5C3_AB,stress_5C3_AB)
% plot(strain_5C2_AB,stress_5C2_AB,'k')
% %plot(strain_5D1_AB,stress_5D1_AB)
% 
% %plot(strain_5B1_1H425,stress_5B1_1H425,'Color','r')
% %plot(strain_E2_1H425,stress_E2_1H425,'Color','g')
% %plot(strain_D2_1H425,stress_D2_1H425,'Color','b')
% 
% %plot(strain_5B2_1H425aged,stress_5B2_1H425aged)
% plot(strain_E4_1H425aged,stress_E4_1H425aged,'b')
% %plot(strain_E5_1H425aged,stress_E5_1H425aged)
% 
% %plot(strain_5A4_1H470,stress_5A4_1H470)
% %plot(strain_E3_1H470,stress_E3_1H470)
% %plot(strain_D3_1H470,stress_D3_1H470)
% 
% %plot(strain_5A2_1H470aged,stress_5A2_1H470aged)
% plot(strain_E6_1H470aged,stress_E6_1H470aged,'r')
% %plot(strain_E7_1H470aged,stress_E7_1H470aged)
% 
% 
% 
% xlabel('Engineering strain $[\%]$');
% ylabel('Engineering stress [MPa]');
% %xlim([0 14]);
% xlim([0 13]);
% ylim([0 600]);
% title('Al7075+ZrH2 2$\%$ mix HT pre-sinter: graph abstract');
% %set(gca,'FontSize',13);
% legend('AB','1H425T6','1H470T6','location','bestoutside');
% %legend('AB V','AB V','AB V inter','AB H','AB H','AB H inter','HT V','HT V','HT V','HT V inter','HT H','HT H inter1','HT H inter2','location','bestoutside');
% hold off;
% 
% 
% % %graph article 2 smooth
% % figure;
% % hold on;
% % 
% % plot(strain_5C3_AB,smooth(stress_5C3_AB,500))
% % plot(strain_5C2_AB,smooth(stress_5C2_AB,500))
% % plot(strain_5D1_AB,smooth(stress_5D1_AB,500))
% % 
% % plot(strain_5B1_1H425,smooth(stress_5B1_1H425,500),'Color','r')
% % plot(strain_E2_1H425,smooth(stress_E2_1H425,500),'Color','g')
% % plot(strain_D2_1H425,smooth(stress_D2_1H425,500),'Color','b')
% % 
% % plot(strain_5B2_1H425aged,smooth(stress_5B2_1H425aged,500))
% % plot(strain_E4_1H425aged,smooth(stress_E4_1H425aged,500))
% % plot(strain_E5_1H425aged,smooth(stress_E5_1H425aged,500))
% % 
% % plot(strain_5A4_1H470,smooth(stress_5A4_1H470,500))
% % plot(strain_E3_1H470,smooth(stress_E3_1H470,500))
% % plot(strain_D3_1H470,smooth(stress_D3_1H470,500))
% % 
% % plot(strain_5A2_1H470aged,smooth(stress_5A2_1H470aged,500))
% % plot(strain_E6_1H470aged,smooth(stress_E6_1H470aged,500))
% % plot(strain_E7_1H470aged,smooth(stress_E7_1H470aged,500))
% % 
% % 
% % 
% % xlabel('Engineering strain $[\%]$');
% % ylabel('Engineering stress [MPa]');
% % %xlim([0 14]);
% % xlim([0 13]);
% % ylim([0 600]);
% % title('Al7075+ZrH2 2$\%$ mix HT pre-sinter: article 2 smooth plateau');
% % %set(gca,'FontSize',13);
% % legend('AB','AB','AB','1H425','1H425','1H425','1H425T6','1H425T6','1H425T6','1H470','1H470','1H470','1H470T6','1H470T6','1H470T6','location','bestoutside');
% % %legend('AB V','AB V','AB V inter','AB H','AB H','AB H inter','HT V','HT V','HT V','HT V inter','HT H','HT H inter1','HT H inter2','location','bestoutside');
% % hold off;
% 
% d_sigma_deps_5C3_AB = DoConsidere(stress_5C3_AB,strain_5C3_AB/100);
% d_sigma_deps_5C3_AB_smooth = smooth(d_sigma_deps_5C3_AB,1000);
% 
% d_sigma_deps_5C2_AB = DoConsidere(stress_5C2_AB,strain_5C2_AB/100);
% d_sigma_deps_5C2_AB_smooth = smooth(d_sigma_deps_5C2_AB,1000);
% 
% d_sigma_deps_5D1_AB = DoConsidere(stress_5D1_AB,strain_5D1_AB/100);
% d_sigma_deps_5D1_AB_smooth = smooth(d_sigma_deps_5D1_AB,1000);
% 
% d_sigma_deps_5B1_1H425 = DoConsidere(stress_5B1_1H425,strain_5B1_1H425/100);
% d_sigma_deps_5B1_1H425_smooth = smooth(d_sigma_deps_5B1_1H425,1000);
% 
% d_sigma_deps_E2_1H425 = DoConsidere(stress_E2_1H425,strain_E2_1H425/100);
% d_sigma_deps_E2_1H425_smooth = smooth(d_sigma_deps_E2_1H425,1000);
% 
% d_sigma_deps_D2_1H425 = DoConsidere(stress_D2_1H425,strain_D2_1H425/100);
% d_sigma_deps_D2_1H425_smooth = smooth(d_sigma_deps_D2_1H425,1000);
% 
% d_sigma_deps_5A4_1H470 = DoConsidere(stress_5A4_1H470,strain_5A4_1H470/100);
% d_sigma_deps_5A4_1H470_smooth = smooth(d_sigma_deps_5A4_1H470,1000);
% 
% d_sigma_deps_E3_1H470 = DoConsidere(stress_E3_1H470,strain_E3_1H470/100);
% d_sigma_deps_E3_1H470_smooth = smooth(d_sigma_deps_E3_1H470,1000);
% 
% d_sigma_deps_D3_1H470 = DoConsidere(stress_D3_1H470,strain_D3_1H470/100);
% d_sigma_deps_D3_1H470_smooth = smooth(d_sigma_deps_D3_1H470,1000);
% 
% d_sigma_deps_5B2_1H425aged = DoConsidere(stress_5B2_1H425aged,strain_5B2_1H425aged/100);
% d_sigma_deps_5B2_1H425aged_smooth = smooth(d_sigma_deps_5B2_1H425aged,1000);
% 
% d_sigma_deps_E4_1H425aged = DoConsidere(stress_E4_1H425aged,strain_E4_1H425aged/100);
% d_sigma_deps_E4_1H425aged_smooth = smooth(d_sigma_deps_E4_1H425aged,1000);
% 
% d_sigma_deps_E5_1H425aged = DoConsidere(stress_E5_1H425aged,strain_E5_1H425aged/100);
% d_sigma_deps_E5_1H425aged_smooth = smooth(d_sigma_deps_E5_1H425aged,1000);
% 
% d_sigma_deps_5A2_1H470aged = DoConsidere(stress_5A2_1H470aged,strain_5A2_1H470aged/100);
% d_sigma_deps_5A2_1H470aged_smooth = smooth(d_sigma_deps_5A2_1H470aged,1000);
% 
% d_sigma_deps_E6_1H470aged = DoConsidere(stress_E6_1H470aged,strain_E6_1H470aged/100);
% d_sigma_deps_E6_1H470aged_smooth = smooth(d_sigma_deps_E6_1H470aged,1000);
% 
% d_sigma_deps_E7_1H470aged = DoConsidere(stress_E7_1H470aged,strain_E7_1H470aged/100);
% d_sigma_deps_E7_1H470aged_smooth = smooth(d_sigma_deps_E7_1H470aged,1000);
% 
% 
% figure;
% hold on;
% plot (strain_5C3_AB(1:end-99),zeros(size(d_sigma_deps_5C3_AB_smooth)),'-k')
% plot (strain_5C3_AB(1:end-99),d_sigma_deps_5C3_AB_smooth)
% plot (strain_5C2_AB(1:end-99),d_sigma_deps_5C2_AB_smooth)
% plot (strain_5D1_AB(1:end-99),d_sigma_deps_5D1_AB_smooth)
% legend('','5B1','E2','D2')
% xlabel('$\epsilon [\%]$');
% ylabel('$d \sigma / d \epsilon [MPa]$');
% title('$d \sigma / d \epsilon [MPa]$ AB');
% hold off;
% 
% figure;
% hold on;
% plot (strain_5B1_1H425(1:end-99),zeros(size(d_sigma_deps_5B1_1H425_smooth)),'-k')
% plot (strain_5B1_1H425(1:end-99),d_sigma_deps_5B1_1H425_smooth)
% plot (strain_E2_1H425(1:end-99),d_sigma_deps_E2_1H425_smooth)
% plot (strain_D2_1H425(1:end-99),d_sigma_deps_D2_1H425_smooth)
% legend('','5B1','E2','D2')
% xlabel('$\epsilon [\%]$');
% ylabel('$d \sigma / d \epsilon [MPa]$');
% title('$d \sigma / d \epsilon [MPa]$ 1H425');
% hold off;
% 
% figure;
% hold on;
% plot (strain_5A4_1H470(1:end-99),zeros(size(d_sigma_deps_5A4_1H470_smooth)),'-k')
% plot (strain_5A4_1H470(1:end-99),d_sigma_deps_5A4_1H470_smooth)
% plot (strain_E3_1H470(1:end-99),d_sigma_deps_E3_1H470_smooth)
% plot (strain_D3_1H470(1:end-99),d_sigma_deps_D3_1H470_smooth)
% legend('','5A4','E3','D3')
% xlabel('$\epsilon [\%]$');
% ylabel('$d \sigma / d \epsilon [MPa]$');
% title('$d \sigma / d \epsilon [MPa]$ 1H470');
% hold off;
% 
% figure;
% hold on;
% plot (strain_5B2_1H425aged(1:end-99),zeros(size(d_sigma_deps_5B2_1H425aged_smooth)),'-k')
% plot (strain_5B2_1H425aged(1:end-99),d_sigma_deps_5B2_1H425aged_smooth)
% plot (strain_E4_1H425aged(1:end-99),d_sigma_deps_E4_1H425aged_smooth)
% plot (strain_E5_1H425aged(1:end-99),d_sigma_deps_E5_1H425aged_smooth)
% legend('','5B2','E4','E5')
% xlabel('$\epsilon [\%]$');
% ylabel('$d \sigma / d \epsilon [MPa]$');
% title('$d \sigma / d \epsilon [MPa]$ 1H425 aged');
% hold off;
% 
% figure;
% hold on;
% plot (strain_5A2_1H470aged(1:end-99),zeros(size(d_sigma_deps_5A2_1H470aged_smooth)),'-k')
% plot (strain_5A2_1H470aged(1:end-99),d_sigma_deps_5A2_1H470aged_smooth)
% plot (strain_E6_1H470aged(1:end-99),d_sigma_deps_E6_1H470aged_smooth)
% plot (strain_E7_1H470aged(1:end-99),d_sigma_deps_E7_1H470aged_smooth)
% legend('','5A2','E6','E7')
% xlabel('$\epsilon [\%]$');
% ylabel('$d \sigma / d \epsilon [MPa]$');
% title('$d \sigma / d \epsilon [MPa]$ 1H470 aged');
% hold off;
% 
% % figure;
% % plot (strain_5A4_1H470(1:end-49),d_sigma_deps_5A4_1H470,strain_5A4_1H470(1:end-49),d_sigma_deps_5A4_1H470_smooth);
% % xlabel('$\epsilon [\%]$');
% % ylabel('$d \sigma / d \epsilon [MPa]$');
% 
% 
% %AB - T6 - As-FSP - FSP T6
% fig_FSP = figure;
% set(gcf,'PaperOrientation','landscape')
% hold on;
% %H PS
% plot(strain_5C3_AB,stress_5C3_AB,'k','LineStyle',':')
% 
% plot(strain_E4_1H425aged,stress_E4_1H425aged,'k')
% 
% 
% plot(strain_FSP_AB_1,stress_FSP_AB_1,'LineStyle',':','Color','#27c631')
% plot(strain_FSP_T6_1,stress_FSP_T6_1,'Color','#27c631')
% plot(strain_FSP_T6_2,stress_FSP_T6_2,'Color','#27c631')
% 
% xlabel('Engineering strain $[\%]$');
% ylabel('Engineering stress [MPa]');
% %xlim([0 14]);
% %xlim([0 16]);
% ylim([0 600]);
% title('Al7075+ZrH2 2$\%$ mix + FSP');
% %set(gca,'FontSize',13);
% legend('AB H','1H425T6 H','As-FSP','FSP + 1H425T6 01','FSP + 1H425T6 02','location','southeast');
% %legend('1H425','1H450','1H470','1H425aged','1H450aged','1H470aged','single 1H470 aged','location','southeast');
% %legend('1H425 aged','1H450 aged','1H470 aged','single 1H470 aged','1H425 aged L','1H450 aged L','1H470 aged L','single 1H470 aged L','location','southeast'); %Sigma 0.2
% print(fig_FSP,'FSP_tensile_05_24','-dpdf','-fillpage')
% hold off;