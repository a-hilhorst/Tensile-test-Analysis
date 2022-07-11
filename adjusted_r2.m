function rsq_adj = adjustedR2(y,yfit_linear)
% ADJUSTEDR2(y,yfit_linear) returns the adjusted R-squared of the linear 
% regression of y

    yresid = y - yfit_linear;
    SSresid = sum(yresid.^2);
    SStotal = (length(y)-1) * var(y);
    
    rsq_adj = 1 - SSresid/SStotal * (length(y)-1)/(length(y)-2);
end