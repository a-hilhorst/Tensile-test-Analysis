function [sigma,epsilon] = SigEpsEng(F,u,A0,L0)
% SIGEPSENG(F,u,A0,L0) returns the engineering stress sigma in [MPa] and
% strain epsilon in [%] from the force F in [kN], the displacement u in 
% [mm], the initial section A0 in [mm^2], and the gauge length L0 in [mm].
%
% see also SigEpsTru, youngModulus, yieldStrength.

    sigma = F/A0;
    epsilon = u/L0;
end