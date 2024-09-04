%% 
close all; clc; 
set(0,'defaulttextInterpreter','latex','DefaultAxesFontSize',18);
set(0, 'DefaultTextFontSize', 18);
set(0,'defaultLineLineWidth',2.0);
set(gcf,'PaperType','A4');
%% Sample 6
[Stress_eng_6,Strain_eng_6,Stress_true_6,Strain_true_6,E6,sigma6] = read_document('Traction-Ech6.xlsx','Results Ech6','Values Ech6',20);
I_6 = find(Stress_true_6 == max(Stress_true_6));
A0_6 = 7.9696; %mm²
Af_6 = 6.94; %mm2
ef_6 = log(A0_6/Af_6);
F_6 = 3903.2771; %N
sf_6 = F_6/Af_6; %MPa

%% Sample 7
[Stress_eng_7,Strain_eng_7,Stress_true_7,Strain_true_7,E7,sigma7] = read_document('Traction-Ech7.xlsx','Results Ech7','Values Ech7',20);
I_7 = find(Stress_true_7 == max(Stress_true_7));
A0_7 = 7.6635; %mm²
Af_7 = 6.59; %mm2
ef_7 = log(A0_7/Af_7);
F_7 = 3978.328125; %N
sf_7 = F_7/Af_7; %MPa

%% Sample 10
[Stress_eng_10,Strain_eng_10,Stress_true_10,Strain_true_10,E10,sigma10] = read_document('Traction-Ech10.xlsx','Results Ech10','Values Ech10',20);
I_10 = find(Stress_true_10 == max(Stress_true_10));
A0_10 = 7.9424; %mm²
Af_10 = 6.6; %mm2
ef_10 = log(A0_10/Af_10);
F_10 = 4024.260986; %N
sf_10 = F_10/Af_10; %MPa

%% Sample 11
[Stress_eng_11,Strain_eng_11,Stress_true_11,Strain_true_11,E11,sigma11] = read_document('Traction-Ech11.xlsx','Results Ech11','Values Ech11',20);
I_11 = find(Stress_true_11 == max(Stress_true_11));
A0_11 = 7.7805; %mm²
Af_11 = 6.76; %mm2
ef_11 = log(A0_11/Af_11);
F_11 = 3691.884033; %N
sf_11 = F_11/Af_11; %MPa

%% Figure Engineering
figure;
hold on;
plot(Strain_eng_6,Stress_eng_6);
plot(Strain_eng_7,Stress_eng_7);
plot(Strain_eng_10,Stress_eng_10);
plot(Strain_eng_11,Stress_eng_11);
xlabel('Engineering strain [-]');
ylabel('Engineering stress [MPa]');
legend('Ech 6','Ech 7','Ech 10','Ech 11')
xlim([0 0.2]);
ylim([0 600]);
hold off;

%% Figure True
figure;
hold on;
plot(Strain_true_6(1:I_6),Stress_true_6(1:I_6),'Color','#0072BD');
plot([Strain_true_6(I_6) ef_6],[Stress_true_6(I_6) sf_6],'--','Color','#0072BD');
plot(ef_6,sf_6,'x','MarkerSize',20,'Color','#0072BD');
plot(Strain_true_7(1:I_7),Stress_true_7(1:I_7),'Color','#D95319');
plot([Strain_true_7(I_7) ef_7],[Stress_true_7(I_7) sf_7],'--','Color','#D95319');
plot(ef_7,sf_7,'x','MarkerSize',20,'Color','#D95319');
plot(Strain_true_10(1:I_10),Stress_true_10(1:I_10),'Color','#EDB120');
plot([Strain_true_10(I_10) ef_10],[Stress_true_10(I_10) sf_10],'--','Color','#EDB120');
plot(ef_10,sf_10,'x','MarkerSize',20,'Color','#EDB120');
plot(Strain_true_11(1:I_11),Stress_true_11(1:I_11),'Color','#7E2F8E');
plot([Strain_true_11(I_11) ef_11],[Stress_true_11(I_11) sf_11],'--','Color','#7E2F8E');
plot(ef_11,sf_11,'x','MarkerSize',20,'Color','#7E2F8E');
xlabel('True strain [-]');
ylabel('True stress [MPa]');
legend('Ech 6','','','Ech 7','','','Ech 10','','','Ech 11','','')
xlim([0 0.4]);
ylim([0 650]);
hold off;
