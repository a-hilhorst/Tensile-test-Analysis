function [sigma,epsilon] = sig_eps_tru(sigma_eng,epsilon_eng,maxInd,fRange)
% SIG_EPS_TRU(F,u,A0,L0) returns the true stress sigma in [MPa] and
% true epsilon in [-] from the engineering stress sigma_eng in [MPa] and 
% the engineering strain espilon_eng in [%].
%
% see also sig_eps_eng, young_modulus, yield_strength.

    p = inputParser;

    defaultmaxInd = 0;
    defaultfRange = 1;
    
    addOptional(p,'maxInd',defaultmaxInd,@isnumeric)
    addOptional(p,'fRange',defaultfRange,@isnumeric)

    parse(p,maxInd,fRange);
    maxInd = p.Results.maxInd;
    fRange = p.Results.fRange;

    if ~maxInd
        vRange = round(fRange*length(sigma_eng));
        [~,maxInd] = max(sigma_eng(end-vRange:end));
        maxInd = min(maxInd+length(sigma_eng)-vRange,length(epsilon_eng));
    end
    
    epsilon = log(1+epsilon_eng(1:maxInd)/100);
    sigma = sigma_eng(1:maxInd).*(1+epsilon_eng(1:maxInd)/100);
end