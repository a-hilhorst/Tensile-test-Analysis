% ----- ModelingLaw -----
% Purpose : - Fit les courbes de traction avec Hollomon s = A*e^B
%           - Sort les param K et n_global
% Version : META 1.0
% Author : Thibaut HEREMANS
% Date : 11/07/2024

clc; clear; close all;
figure(1)

%% LOADING data
load export_Tensile_GL.mat

% GL OK
% MoGL bof
% FB OK
% MoFB bof
% QP OK
% DP Ok


for i = 1:length(data)
% Notations
F = data{i}.F(12:end);
dL = data{i}.dL(12:end);
L0 = data{i}.L0;
t0 = data{i}.t0;
w0 = data{i}.w0;
A0 = data{i}.A0;
YS = data{i}.YS;

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

ermv = e(s >= YS + 150);
srmv = s(s >= YS + 150);

bestParams = lsqcurvefit(powerLaw, initialGuess, ermv, srmv, lb, ub, options);
K(i) = bestParams(1);
n(i) = bestParams(2);
%k(i) = bestParams(3);

fprintf('Fitted parameters for the classical power law:\n');
fprintf('K = %.1f\n', K(i));
fprintf('n = %.3f\n', n(i));
%fprintf('k = %.4f\n', k(i));

fittedSigma = powerLaw(bestParams, ermv);

SS_res = sum((srmv - fittedSigma).^2);
SS_tot = sum((srmv - mean(s)).^2);
R2(i) = 1 - (SS_res / SS_tot);
fprintf('R^2 = %.4f\n', R2(i));

% Plot the original data and the fitted curve
figure(1)

plot(e,s+250*(i-1), 'b'); hold on;
plot(ermv,srmv+250*(i-1), 'r.'); hold on;
plot(ermv, fittedSigma+250*(i-1), 'k-', 'DisplayName', 'Fitted Power Law');
xlabel('Strain (\epsilon)');
ylabel('Stress (\sigma)');
xlim([0 0.25])
ylim([0 2600])

end

%% Plot output param
figure(2)
for i = 1:length(data)
    subplot(1,2,1)
    bar(n); hold on
    
    subplot(1,2,2)
    bar(K); hold on
end




