function out = mean_curve(curves,n)
% assumes 'curves' is a cell array of curves

% step 1: get min and max of domain range
xmin = NaN;
xmax = NaN;

for i=1:1:length(curves)
    data = curves{i};
    if size(data,1)>size(data,2)
        data = data';
    end
    xmin = min(xmin,min(data(1,:)));
    xmax = max(xmax,max(data(1,:)));
end

% step 2: interpolate all curves on new x, take average
new_x = linspace(xmin,xmax,n);
new_y = zeros(size(new_x));
nPts = zeros(size(new_x));
out = cell(1,length(curves)+1);

for i=1:1:length(curves)
    data = curves{i};
    if size(data,1)>size(data,2)
        data = data';
    end
    interp_out = interp1(data(1,:),data(2,:),new_x);
    ind = ~isnan(interp_out);
    new_y(ind) = new_y(ind) + interp_out(ind);
    nPts(ind) = nPts(ind) + 1;
    out{i+1} = interp_out;
end
new_y = new_y./nPts;

avg = [new_x; new_y];
out{1} = avg;
end