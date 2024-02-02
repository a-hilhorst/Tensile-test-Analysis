function [shr, sigma_shr, epsilon_shr] = strain_hardening(sigma_true, epsilon_true, yield_strength)
% STRAIN_HARDENING(sigma_true, epsilon_true) returns the strain hardening
% rate from the true stress (sigma_true) and the true strain (epsilon_true)

    sigma_shr = sigma_true(sigma_true>yield_strength);
    epsilon_shr = epsilon_true(sigma_true>yield_strength);

    ds = diff(sigma_shr);
    de = diff(epsilon_shr);
    
    shr = ds./de;
    span_opt = 25;
    span_tmp = 1;
    poly_order = 3;
    niter = 0;
    while (span_tmp ~= span_opt) && (niter<10000)
        span_tmp = span_opt;
        y = filloutliers(shr,'linear');
        y = smooth(y, span_tmp,'sgolay', poly_order);
        dy = smooth(diff(y),span_tmp,'sgolay',poly_order);
        ddy = diff(dy,3);
        ddy(isinf(ddy))=[];
        c = mean(ddy.^2,'omitnan');

        y(isinf(y))=[];
        var(y,'omitnan');
        span_opt = (2*(poly_order+2)*(factorial(2*poly_order+3))^2*(var(y,'omitnan')^2)/(c*(factorial(poly_order+1))^2))^(1/(2*poly_order+5));
        span_opt = 2*floor(span_opt/2)+1;
        
        niter = niter + 1;
        if isnan(span_opt)
            niter = 10000;
        end
        if (niter>10) && abs(span_opt-span_tmp)<3
            break
        end
    end
    if niter == 10000
        span_opt = 101;
    end
%     shr = smooth(ds./de,span_opt,'sgolay', poly_order);
    shr = smoothdata(ds./de,"sgolay",span_opt);

    sigma_shr = sigma_shr(1:end-1)+ds./2 - sigma_shr(1);
    epsilon_shr = epsilon_shr(1:end-1)+de./2;
end