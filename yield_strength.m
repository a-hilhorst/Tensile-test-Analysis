function sigma_y = yield_strength(sigma,epsilon,E)
% YIELDSTRENGTH(sigma,epsilon,E) returns the yield strength sigma_y in 
% [MPa] from the stress sigma in [MPa], the strain epsilon in [%], and the 
% Young's modulus is [GPa]
%
% See also sig_eps_eng, sig_eps_tru, young_modulus.

    sigma_y = sigma(find(((E*1e3).*(epsilon./100)-(E*1e3)*0.002)<sigma,1,'last'));
end