% ----- ModelingLaw -----
% Purpose : - Fit les courbes de traction avec Hollomon s = A*e^B
%           - Sort les param K et n_global
% Version : META 1.0
% Author : Thibaut HEREMANS
% Date : 11/07/2024

clc; clear; close all;
figure(1)
set(gcf, 'Position', [250, 100, 1200, 400]);

%% LOADING data
load export_Tensile_DP.mat

dYS = 50;      % MPa au dessus duquel je commence l'approx

% GL OK
% MoGL bof
% FB OK
% MoFB bof
% QP OK
% DP Ok

labels = {};
for i = 1:length(data)
% Notations
F = data{i}.F(12:end);
dL = data{i}.dL(12:end);
L0 = data{i}.L0;
t0 = data{i}.t0;
w0 = data{i}.w0;
A0 = data{i}.A0;
YS = data{i}.YS;
labels{i} = data{i}.tag;

% Engineering curves
se = F/A0;           % N/mm2 = MPa
ee = dL/L0;          % no units (pas des pcts!)

% Uniform elongation et swift elongation
[se_max, idx_max] = max(se);
ee_max = ee(idx_max);
setrim = se(1:idx_max);
eetrim = ee(1:idx_max);

% True curves
s = setrim.*(1+eetrim);
e = log(1+eetrim);


%% Swift
powerLaw = @(params, x) params(1)*x.^params(2);
initialGuess = [2000, 0.2];
lb = [100, 0.05];
ub = [5000, 0.50];

options = optimoptions('lsqcurvefit', 'Display', 'iter');

ermv = e(s >= YS + dYS);
srmv = s(s >= YS + dYS);

bestParams = lsqcurvefit(powerLaw, initialGuess, ermv, srmv, lb, ub, options);
K(i) = bestParams(1);
n(i) = bestParams(2);
data{i}.n = n(i);

fprintf('Fitted parameters for the classical power law:\n');
fprintf('K = %.1f\n', K(i));
fprintf('n = %.3f\n', n(i));

fittedSigma = powerLaw(bestParams, ermv);

SS_res = sum((srmv - fittedSigma).^2);
SS_tot = sum((srmv - mean(s)).^2);
R2(i) = 1 - (SS_res / SS_tot);
fprintf('R^2 = %.4f\n', R2(i));

% Plot the original data and the fitted curve
figure(1)
subplot(1,2,1)
plot(e,s+250*(i-1), 'b'); hold on;
plot(ermv,srmv+250*(i-1), 'r.'); hold on;
plot(ermv, fittedSigma+250*(i-1), 'k-', 'DisplayName', 'Fitted Power Law');
xlabel('Strain (\epsilon)');
ylabel('Stress (\sigma)');
xlim([0 0.25])
ylim([0 2600])

end

%% Plot output param
figure(1)
labelsCat = categorical(labels);
for i = 1:length(data)
    
    subplot(1,4,3)
    bar(labelsCat(i),n(i)); hold on
    text(i, n(i)+0.02, num2str(n(i), '%.3f'), 'horizontalalignment', 'center')
    ylim([0 0.5])
    ylabel('n')
    
    subplot(1,4,4)
    bar(labelsCat(i),K(i)); hold on
    text(i, K(i)+100, num2str(K(i), '%.0f'), 'horizontalalignment', 'center')
    ylim([0 5000])
    ylabel('K')
end


%% mean n and others
[meann, stdn] = LTpropVariante(data, 'n')







