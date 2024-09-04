function [stress,strain,prop,stress_true,strain_true,prop_true] = read_traction_data_file_true(file,Gauge_L,D,D_f)
%
% prop(1) = 'Sigma_y_0.2%';
% prop(2) = 'Sigma_UTS';
% prop(3) = 'Epsilon_max';
% prop(4) = 'E';
%
%prop_true(1) = 'Sigma_UTS_true';
%prop_true(2) = 'Sigma_epsilon_f';
%prop_true(3) = 'Sigma_fracture';
%prop_true(4) = 'sigma_Y_0.2\%, t';
%prop_true(5) = 'E, t';


prop = zeros(4,1);
%Extract stress and strain vector
full_data = readmatrix(file,'Sheet',2);
Force = full_data(:,2);
displacement = full_data(:,3);
Area = pi*(D/2).^2;

stress = Force./Area;
strain = 100*displacement./Gauge_L;

%replace negative value by 0 for strains
j = 1;
while j <= size(strain,1)
    if strain(j) < 0
        strain(j) = 0;
    end
    j = j+1;
end

[prop(2),i_UTS] = max(stress);
prop(3)= max(strain);

%Extract E
[Strain_short,Stress_short] = extract_rangeY(strain,stress,[100 200]);
p = polyfit(Strain_short,Stress_short,1);
prop(4)=p(1)*0.1; %pourcentage + MPa to go to GPa

%extract sigma y 0.2\%
i = 1;
current_best_error = 100;
prop(1)= 0;
while i <= size(stress,1)
    stress_exp = stress(i);
    stress_lin = p(1)*(strain(i)-0.2)+p(2);
    
    if abs(stress_exp - stress_lin) < current_best_error
        current_best_error = abs(stress_exp - stress_lin);
        prop(1) = stress_exp;
    end
    
    i = i+1;
end

%true stress true strain
stress_true = stress(1:i_UTS).*((strain(1:i_UTS)./100)+1);
strain_true = log(1+(strain(1:i_UTS)./100));
prop_true = zeros(5,1);
prop_true(1) = stress_true(end);

A_f = pi*(D_f/2).^2;
prop_true(2) = log(Area/A_f);
prop_true(3) = Force(end)/A_f;


%Extract E true
[Strain_short_t,Stress_short_t] = extract_rangeY(strain_true,stress_true,[100 200]);
p_t = polyfit(Strain_short_t,Stress_short_t,1);
prop_true(5)=p_t(1)*0.001; %MPa to go to GPa

%extract sigma y 0.2\%
i = 1;
current_best_error = 100;
prop_true(4)= 0;
while i <= size(stress_true,1)
    stress_exp = stress_true(i);
    stress_lin = p_t(1)*(strain_true(i)-0.002)+p_t(2);
    
    if abs(stress_exp - stress_lin) < current_best_error
        current_best_error = abs(stress_exp - stress_lin);
        prop_true(4) = stress_exp;
    end
    
    i = i+1;
end

% prop(4)
% figure;
% hold on;
% plot(strain,stress,[0.2 1],[p(1)*(0)+p(2) p(1)*(0.8)+p(2)]);
% xlabel('Strain $[\%]$');
% ylabel('Stress [MPa]');
% title(file);
% set(gca,'FontSize',12);
% hold off;



end

