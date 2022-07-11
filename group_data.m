function indTable = groupData(data,keywords,outputNames)
% GROUPDATA(data,keywords)

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