function [e,S,e_ing,S_ing] = Traction(Section,L0,Dl,F)
% function [yield] = Traction(Section,L0,Dl,F)
% function [e,S] = Traction(e_ing,S_ing)
% %Traction: Section is the section of the sample [mm²]; L0 is the initial distance
% %between the extensometers; Dl is the increment of length recorded by the extensometers;
% % F is the force [N]
e_ing = Dl./L0; % [/]
S_ing = F./Section; % [MPa]
size(S_ing);
size(e_ing);
e = log(1+e_ing); % [/]
S = S_ing.*(1+e_ing); % [MPa]
%%% Détermination de la localisation par necking
S_n = max(S_ing); %[MPa]
label_n = find(S_ing==S_n);
% label_n=length(S_ing);
S_uvraie = S_n*(1+e_ing(label_n(1)));
e_u = e_ing(label_n); %[/]
S = S(1:label_n);
e = e(1:label_n);
figure(1);
plot(e_ing.*100,S_ing); hold on;
% plot(e_u.*100,S_n,'ro');
xlabel('Déformation ingénieure [%]');
ylabel('Contrainte ingénieure [MPa]');
e = smooth(e,10);
S = smooth(S,10);
% E2 = (S(2)-S(1))/(e(2)-e(1));
%%% Calcul du module de Young entre a1 et b1 de déformation
a1 = 0.0005;
b1 = 0.001;
a=1;
b=1;
while e(a)<a1
    a=a+1;
end
while e(b)<b1
    b=b+1;
end
y = polyfit(e(a:b),S(a:b),1);
E2 = (S(b)*10^6-S(a)*10^6)/(e(b)-e(a))/10^9
% y(1) = (S(2)-S(1))/(e(2)-e(1))
% y(2)=0;
% a=1;
% b=2;
%% Plot des points bruts, puis de la fonction approximée et enfin 
%% de la partie élastique à 0.2% de déformation
figure(2);
plot(e,S,'b'); hold on;
plot(e(a:b),y(2)+y(1).*e(a:b),'g'); hold on;
ylabel('Contrainte vraie [MPa]');
xlabel('Déformation vraie [/]');

% ENGINEERING YIELD STRENGTH A 2pourcents
droite = y(1).*e-0.002.*e;
droite = y(1).*(e-0.002);
n = length(S);
j=b;
rep=droite-S;
while rep(j)<=0.1
        j = j+1;
end
yield = S(j)
plot(e(j),S(j),'ro');
Su = S(end)
eu = e(end)
% A = Dl(end)/L0;
%% Plot de traction + rupture

% plot(e_500C60m,S_500C60m,'r',e_450C15m,S_450C15m,'b',e_500C15m,S_500C15m,'m',e_650C30m,S_650C30m,'g',e_ReX,S_ReX,'k',ef(5),Sf(5),'k*',ef(3),Sf(3),'r*',ef(1),Sf(1),'b*',ef(2),Sf(2),'m*',ef(4),Sf(4),'g*');
% legend('ReX+500°C 60''','ReX+450°C 15''','ReX+500°C 15''','ReX+650°C 30''','ReX');
% xlabel('True deformation [/]');
% ylabel('True stress [MPa]');
% hold on; plot([e_500C15m(end),ef(2)],[S_500C15m(end),Sf(2)],'Color',pink,'LineStyle','--');
% hold on; plot([e_500C60m(end),ef(3)],[S_500C60m(end),Sf(3)],'Color',red,'LineStyle','--');
% hold on; plot([e_650C30m(end),ef(4)],[S_650C30m(end),Sf(4)],'Color',green,'LineStyle','--');
% hold on; plot([e_ReX(end),ef(5)],[S_ReX(end),Sf(5)],'Color',grey,'LineStyle','--');
% hold on; plot([e_450C15m(end),ef(1)],[S_450C15m(end),Sf(1)],'Color',blue,'LineStyle','--');

% plot(e_LCB,S_LCB,'g',e_TA6V,S_TA6V,'k',e_Ti5553b,S_Ti5553b,'b',e_TiMo,S_TiMo,'r');
% legend('Ti-LCB','Ti-6Al-4V','Ti-5553','Ti-12Mo');
% hold on; plot(ef_LCB,Sf_LCB,'g.',ef_TA6V,Sf_TA6V,'k.',ef_5553,Sf_5553,'b.',ef_TiMo,Sf_TiMo,'r.','MarkerSize',10);
% xlabel('True deformation [/]');
% ylabel('True stress [MPa]');

% plot(Dl_Ti6246,Wf_Ti6246,'k*',Dl_TA6V,Wf_TA6V,'k+',Dl_Ti,Wf_Ti,'kx',Dl_TiMo,Wf_Ti12Mo,'ro');
% hold on;
% plot(Dl_5553,Wf_5553,'k+',Dl_5553bimodal,Wf_5553bimodal,'k+',Dl_LCB,Wf_LCB,'k+',Dl_TiCrSn,Wf_TiCrSn,'ko');
% hold on; plot(Dl_CEZ,Wf_CEZ,'k.',Dl_CEZbimodal,Wf_CEZbimodal,'k.','MarkerSize',10);
% xlabel('Elongation at fracture [%]');
% ylabel('Toughness - 1/2.(\sigma_f+\sigma_y).\epsilon_f [MPa]');

%% Déterminer les limites du fit
% 
% fit0 = 1;
% while e(fit0)<0.5
%     fit0 = fit0+1;
% end
% fit1 = fit0;
% while e(fit1)<1.1
%     fit1 = fit1+1;
% end
% fit2 = fit1;
% while e(fit2)<2.5
%     fit2 = fit2+1;
% end
% 
% %% Degré 10 pour un fit entre une défo de 0.5% et une défo de 1.5%
% %% (fit)
% p0 = polyfit(e(fit0:fit1),S(fit0:fit1),9);
% y0 = polyval(p0,e(fit0:fit1));
% %% Degré 6 pour un fit entre une défo de 1.5 et 2%
% p1 = polyfit(e(fit1:fit2),S(fit1:fit2),6);
% y1 = polyval(p1,e(fit1:fit2));
% %% Degré 6 pour un fit après une défo de 2.5%
% p2 = polyfit(e(fit2:end),S(fit2:end),5);
% y2 = polyval(p2,e(fit2:end));
% figure(4);
% plot(e(1:end),S(1:end),'b',e(fit0:fit1),y0,'r',e(fit1:fit2),y1,'y',e(fit2:end),y2,'g');
% ylabel('Contrainte vraie [MPa]');
% xlabel('Déformation vraie [%]');
% 
% % Déterminer la dérivée du fit = Work Hardening Rate
% 
% w0 = polyval(polyder(p0),e(fit0:fit1)).*e(fit0:fit1)./S(fit0:fit1);
% w1 = polyval(polyder(p1),e(fit1:fit2)).*e(fit1:fit2)./S(fit1:fit2);
% w2 = polyval(polyder(p2),e(fit2:end)).*e(fit2:end)./S(fit2:end);
% 
% figure(5);
% plot(e(fit0:fit1)./100,w0,'r',e(fit1:fit2)./100,w1,'y',e(fit2:end)./100,w2,'g');
% xlabel('Strain [/]');
% ylabel('Normalized Work Hardening Rate [/]');
% 
% 
% 
% 
% % Déterminer le Work hardening rate point par point : n = dS/de * e/S
% v = 100;
% Whr = (S(v:end)-S(v-1:end-1))./(e(v:end)-e(v-1:end-1)).*e(v:end)./S(v:end);
% figure(6);
% plot(e(v:end)./100,Whr,'b.');
% xlabel('Strain [/]');
% ylabel('Normalized Work Hardening Rate [/]');



%% Contrainte max et déformation correspondante
% 
% for i = 1:n
%     if ContrainteBleu1(i)>sigma
%         sigma=ContrainteBleu1(i);
%         k=i;
%     end
% end
% 
%  sigmaOk = sigma
%  EpsilonBleu1(k)
% % j
% 






end

