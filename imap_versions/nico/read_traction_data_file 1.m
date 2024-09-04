function [stress,strain,prop] = read_traction_data_file(file,Gauge_L,D)
%
% prop(1) = 'Sigma_y_0.2%';
% prop(2) = 'Sigma_UTS';
% prop(3) = 'Epsilon_max';
% prop(4) = 'E';

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

prop(2)= max(stress);
prop(3)= max(strain);

%Extract E
[Strain_short,Stress_short] = extract_rangeY(strain,stress,[100 200]);
p = polyfit(Strain_short,Stress_short,1);
prop(4)=p(1)*0.1; %pourcentage + MPa to go to GPa

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

