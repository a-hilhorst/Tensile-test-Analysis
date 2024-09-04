%%% essais de traction %%%
close all
%%
OFF = OFF+1000;
% engineering curve %
zeroID = 1;
color = COLOR;
Force = Standardforce;
Course = Standardtravel;
figure(10)
hold on
plot(Course,Force,'Color',COLOR);

% A0 = 0.0015*0.004; %% section eprouvette
sigma = Force/A0 * 1/10^6;

% % % l0 = xx; %% longueur jauge!!!
Dl = Course;
epsilon = Dl/l0;
final = length(Force);
DX = 0;
stop=0;
for i=1:(length(Force)-1)
    DX = Force(i+1)-Force(i);
    if abs(DX)>150 && stop==0 && i>length(Force)-1000
        final = i;
        stop=1;
    end
end

hold on

figure(1);
plot(epsilon(1:final), sigma(1:final),'Color',color, 'LineWidth',3);
%%% marqueur epsilonF sigmaF
hold on
% plot(epsilon(final), sigma(final),'*','Color',color);
%%%
% title('Engineering stress-strain curve AS RECEIVED');
xlabel('Strain [-]');
ylabel('Stress [MPa]');

[val, id] = max(Standardforce);

hold on

figure(2);
plot(epsilon(1:id), sigma(1:id),'Color',color);
title('engineering stress-strain curve UNTIL UTS');
xlabel('strain [-]');
ylabel('stress [MPa]');

%%
% true curve %

st = sigma.*(1+epsilon);
et = log(1+epsilon);

hold on

figure(3);
plot(et(1:id), st(1:id),'Color',color);
title('true stress-strain curve');
xlabel('strain [-]');
ylabel('stress [MPa]');

%%
% Young modulus

% BML1 = 7000;
% BML2 = 6500;
% BMT1 = 3800;
% FSP11 = 3500;
% FSP12 = 2500;
Eid = ARG; %last id in points for regression 

Y = sigma(zeroID:Eid);

X = [ones(Eid-(zeroID-1),1), epsilon(zeroID:Eid)];
Sol = X\Y;

E = Sol(2);
Y0 = Sol(1);

hold on

figure(4);
plot(epsilon(1:final), sigma(1:final),'Color',color);
title('engineering stress-strain');
xlabel('strain [-]');
ylabel('stress [MPa]');

x = 0:0.00001:epsilon(Eid);
y = E*x + Y0*ones(1,length(x));

hold on
plot(x,y,'r');
hold on
scatter(epsilon(Eid),sigma(Eid),'rx');
hold on 
scatter(epsilon(id),sigma(id),'bx');

%%
% yield stress

figure(5);
plot(epsilon(1:final), sigma(1:final),'Color',color);
title('engineering stress-strain');
xlabel('strain [-]');
ylabel('stress [MPa]');

% % x = 0:0.00001:epsilon(Eid+OFF);
% x = epsilon(1:Eid+OFF)';
% y = E*x + Y0*ones(1,length(x));
% offset = ones(1,length(x))*0.002;
% 
% hold on
% plot(x+offset,y,'r');

x = epsilon(1:Eid+OFF)';
y = E*(x-0.002) + Y0*ones(1,length(x));

hold on
plot(x,y,'r');

%%
% % hardening parameters:
% 
% % dsigF/depsP = theta - beta*(sigF-sigY)
% % Ypl = -beta*Xpl + theta
% 
% %determine plastic zone
% optimizationFun = abs(y-(sigma(1:Eid+OFF))');
% [val1 yieldInit] = min(optimizationFun);
% sigma0 = y(yieldInit);
% 
% hold on
% scatter (x(yieldInit), y(yieldInit));
% 
% % true curve: %
% % st = sigma.*(1+epsilon);
% % et = log(1+epsilon);
%  %%
%  % Chose plasticity zone //// either yield init, either defined by user
 %%
%  
% %  yieldInit = plasticityZoneInit;
%  
% epsP = et(yieldInit:id);
% [epsP index] = unique(epsP);
% 
% sigF = st(yieldInit:id);
% sigF = sigF(index);
% 
% % for PLC effect : 
% % % %
% if (exist('PLC'))
%     if PLC == 1
%     Yinterpolated = polyval(polyfit(epsP,sigF,4), epsP);
%     figure(3) 
%     hold on
%     plot(epsP,Yinterpolated);
%     sigF = Yinterpolated;
%     end
% end
% % % %
% 
% Yinterp = (sigF(2:end)-sigF(1:(end-1)))./(epsP(2:end)-epsP(1:(end-1))); % = dsigF/depsP
% Yinterp = smoothdata(Yinterp); %% smooth function
% Xpl = sigF(2:end)-(sigma(yieldInit)); % = sigF-sigY
% 
% Xpl_zonePL = Xpl(plasticityZoneInit:end);
% Yinterp_zonePL = Yinterp(plasticityZoneInit:end);
% 
% Xinterp = [ones(length(Xpl_zonePL),1) Xpl_zonePL];
% 
% Sol_pl = Xinterp\Yinterp_zonePL;
% 
% theta = Sol_pl(1)
% beta = -Sol_pl(2)
% 
% figure(6)
% hold on
% plot(Xpl,Yinterp);
% hold on
% scatter(Xpl_zonePL(1),Yinterp_zonePL(1),'rd');
% hold on
% scatter(Xpl_zonePL(end),Yinterp_zonePL(end),'rd');
% hold on
% plot(Xpl_zonePL, (-beta*Xpl_zonePL+theta));
% 
% % figure(7)
% % hold on
% % scatter(theta,beta,75,'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',COLOR);
% % hold on
% % set(gca,'FontSize',24)
% % box on
% % xlabel('\theta');
% % ylabel('\beta');
% % title('Strain-hardening coefficients - Voce law');
%%
% % log plots
% 
% hold on
% figure(6);
% 
% loglog(epsilon(1:final), sigma(1:final),'Color',color);
% title('engineering stress-strain data');
% xlabel('strain [-]');
% ylabel('stress [MPa]');
% 
% %%
% % Kocks - Mecking curves
% 
% hold on
% figure(7);
% 
% SyIng = (E*(et-0.002) + Y0*ones(length(et),1));
% ToSolve = abs(st - SyIng);
% 
% obj = st - SyIng;
% 
% [c, ind] = min(ToSolve);
% 
% sy = st(ind); % yield stress
% 
% if sy<320
%     % st = true stress 
%     offsetInterp = 7000;
%     stSOFT = polyval(polyfit(et(offsetInterp:id),st(offsetInterp:id),2),et(offsetInterp:id));
%     hold on
%     figure(8)
%     plot(et(1:id),st(1:id))
% %     st(offsetInterp:id) = stSOFT;
%     hold on
%     f2 = fit(et(offsetInterp:id),st(offsetInterp:id),'exp2');
%     plot(f2,'r');
%     st(offsetInterp:id) = f2(et(offsetInterp:id));
%     hold on
%     figure(7)
% end
% 
% ds = st(2:id) - st(1:id-1);
% de = et(2:id) - et(1:id-1);
% 
% validPoints = (de~=0);
% ds = ds(validPoints);
% de = de(validPoints);
% 
% dsde = ds ./ de;
% 
% Ds = st(1:id-1) - sy;
% Ds = Ds(validPoints);
% 
% newSampling = 50;
% filterCoeff = ones(1, newSampling)/newSampling;
% avg_dsde = filter(filterCoeff, 1, dsde);
% 
% plot(Ds,avg_dsde,'Color',color);
% title('Kocks - Mecking');
% xlabel('\sigma-\sigma_y');
% ylabel('d\sigma / d\epsilon');
% xlim([0 150]);

%% search for expJ2isotropicHardening parameters
% figure(8);
% % R = s0 + h*(1-exp(-hexp*p))
% exlusionID = 1; %if 1, not excluding early plastic flow
% p = epsP(exlusionID:end); % epsilon true
% R = sigF(exlusionID:end); % sigma true

%%
% s0 = sigma0;
% 
% 
% 
% x=p;
% y=(R-s0);
% g = fittype('a*(1-exp(-b*x))');
% f0 = fit(x,y,g,'StartPoint',[500, 1.5])
% xx = 0.01:0.001:0.25;
% plot(x,y,'o',xx,f0(xx),'r-');


%% search for PFZ - Grains influence 
% goal: tune the PFZ and grain material laws in order to reach the bulk law
% when combined. f is the % volume of PFZ inside the bulk material.

% % dataBulk:
% eps_bulk = xx;
% sigma_bulk = f0(xx)+s0;
% 
% f = 0.01;
% 
% % lets consider that PFZ has similar properties as Al 1050
% 
% % ==> h = 68.4, hexp = 8.58 for hardening law, s0 = 50 MPa
% sigma_PFZ = sigma_bulk;
% h_PFZ = 68.4;
% hexp_PFZ = 8.58;
% R_PFZ = sigma_PFZ-50;
% 
% eps_PFZ = -1/hexp_PFZ * log(1-R_PFZ/h_PFZ);
% 
% plot(eps_PFZ,sigma_PFZ);








