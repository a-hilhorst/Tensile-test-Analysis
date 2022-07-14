function E = young_modulus(sigma,epsilon,varargin)
% YOUNG_MODULUS(sigma,epsilon) returns the Young's modulus E in [GPa] from 
% the stress sigma in [MPa] and the strain epsilon in [%]. E is computed by
% linear regression of the first 1e3 points of the stress-strain vectors. 
%
% YOUNG_MODULUS(sigma,epsilon,nE) returns the Young's modulus E in [GPa] 
% from the stress sigma in [MPa] and the strain epsilon in [%]. E is 
% computed by linear regression of the first nE points of the stress-strain
% vectors.
%
% YOUNG_MODULUS(sigma,epsilon,0) returns the Young's modulus E in [GPa] 
% from the stress sigma in [MPa] and the strain epsilon in [%]. E is 
% computed by linear regression of the first points with the lowest R^2.
%
% see also sig_eps_eng, sig_eps_tru, yield_strength.
    
    p = inputParser;

    defaultnE = 1e3;
    
    addOptional(p,'nE',defaultnE,@isnumeric)
    
    parse(p,varargin{:});
    nE = p.Results.nE;
    
    if ~nE
        n = 10;
        step = round(length(epsilon)/3/n);
        
        error = zeros(1,n);
        for i=1:1:n
            y1 = sigma(1:n*step);
            p = polyfit(epsilon(1:i*step),sigma(1:i*step),1);
            y2 = polyval(p,epsilon(1:n*step));
            error(i) = adjusted_r2(y1,y2);
        end
        [~,ind] = min(error);
        
        nE = ind*step;
    end
    
    pE = polyfit(epsilon(1:nE),sigma(1:nE),1);
    
    E = pE(1)/1e3;
end
