function [Stress_eng,Strain_eng,Stress_true,Strain_true,E_Young,sigma_y] = read_document(file_name,Sheet_name_1,Sheet_name_2,length_exten)

%Results_data,Values_data,Size_max,Force,Strain,Area
%length_exten = distance de l'extensomètre en mm
%Stress_eng,Strain_eng,Stress_true,Strain_true
%Initialisation des vecteurs utilisés
Results_data = readmatrix(file_name,'Sheet',Sheet_name_1);
Values_data = readmatrix(file_name,'Sheet',Sheet_name_2);
Size_max = size(Values_data,1);

Force = Values_data(1:Size_max,2); %[N]
Strain = Values_data(1:Size_max,3); %[mm]
Area = Results_data(2,6); %[mm²]

Stress_eng = Force./Area; %[MPa]
Strain_eng = (Strain./length_exten); %[%]


Strain_true = log(Strain_eng+1);
Stress_true = Stress_eng.*(1+Strain_eng); %[MPa]

%Calcul module de Young
Strain_short = Strain_true(100:200);
Stress_short = Stress_true(100:200);
p = polyfit(Strain_short,Stress_short,1);
E_Young = p(1)*0.001; %pourcentage + MPa to go to GPa

%Calcul sigma_y
i = 1;
current_best_error = 100;
sigma_y = 0;
while i <= size(Stress_true,1)
    stress_exp = Stress_true(i);
    stress_lin = p(1)*(Strain_true(i)-0.002)+p(2);
    
    if abs(stress_exp - stress_lin) < current_best_error
        current_best_error = abs(stress_exp - stress_lin);
        sigma_y = stress_exp;
    end
    
    i = i+1;
end