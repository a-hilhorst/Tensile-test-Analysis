function E = youngModulus(sigma,epsilon,nE)
% YOUNGMODULUS(sigma,epsilon) returns the Young's modulus E in [GPa] from 
% the stress sigma in [MPa] and the strain epsilon in [%]. E is computed by
% linear regression of the first 1e3 points of the stress-strain vectors. 
%
% YOUNGMODULUS(sigma,epsilon,nE) returns the Young's modulus E in [GPa] 
% from the stress sigma in [MPa] and the strain epsilon in [%]. E is 
% computed by linear regression of the first nE points of the stress-strain
% vectors.
%
% YOUNGMODULUS(sigma,epsilon,0) returns the Young's modulus E in [GPa] 
% from the stress sigma in [MPa] and the strain epsilon in [%]. E is 
% computed by linear regression of the first points with the lowest R^2.
%
% see also SigEpsEng, SigEpsTru, yieldStrength.
    
    p = inputParser;

    defaultnE = 1e3;
    
    addOptional(p,'nE',defaultnE,@isnumeric)
    
    parse(p,nE);
    nE = p.Results.nE;
    
    if ~nE
        n = 10;
        step = round(length(epsilon)/3/n);
        
        error = zeros(1,n);
        for i=1:1:n
            error(i) = adjustedR2(sigma,polyfit(epsilon(1:i*step),sigma(1:i*step),1));
        end
        [~,ind] = min(error);
        
        nE = ind*step;
    end
    
    pE = polyfit(epsilon(1:nE),sigma(1:nE),1);
    
    E = pE(1)/1e3;
end