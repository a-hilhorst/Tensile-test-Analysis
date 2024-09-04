function [x_short,y_short] = extract_rangeY(x,y,range_y)
        %Removing exess data outside y range, restarting x at 0
        %
    lower_bound = 0;
    upper_bound = 0;
    inside = 0;

    for i = 1:length(y)
        if inside == 0 && y(i) > range_y(1)
            inside = 1;
            lower_bound = i;
        end
        if inside == 1 && y(i) > range_y(2)
            inside = 2;
            upper_bound = i-1;
        end
        if inside == 1 && y(i) == y(end)
            inside = 2;
            upper_bound = i;
        end
    end

    y_short = y(lower_bound:upper_bound);
    x_short = x(lower_bound:upper_bound);
end
