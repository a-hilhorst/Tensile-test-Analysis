function indTable = group_data(data,keywords,outputNames)
% GROUP_DATA(data,keywords,outputNames) returns a table with variable names
% given as outputNames for each list of keywords that contains a logical 
% vector of length data where it is true if data contains all keywords.

    indices = zeros(length(data),length(keywords));
    for i=1:1:length(keywords)
        s = zeros(length(data),length(keywords{i}));
        for j=1:1:length(keywords{i})
            s(:,j) = contains(data,keywords{i}{j});
        end
        indices(:,i) = all(s,2);
    end
    
    indTable = array2table(indices,'variableNames',outputNames);
end