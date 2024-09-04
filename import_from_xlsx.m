function data = import_from_xlsx(xls_file, varargin)
% IMPORT_FROM_XLSX
% u - the displacement
% F - the force
% A0 - the initial cross-section
% L0 - the initial gauge length
% Af - the final cross section (at rupture)

    %% Input parsing
    defaultAf = NaN;

    p = inputParser;

    addRequired(p,'xls_file')
    addOptional(p,'Af',defaultAf)

    parse(p,xls_file,varargin{:});
    xls_file = p.Results.xls_file;
    Af = p.Results.Af;

    %% Import data
    data = struct();

    sheets = sheetnames(xls_file);
    ind_results = find(contains(sheets, {'Résultats'; 'Results'}),1,'first');
    ind_values = find(contains(sheets, {'Valeurs'; 'Values'}),1,'first');
    
    % sheet Results
    tmp = readtable(xls_file, 'Sheet', ind_results, 'VariableNamingRule', 'modify', 'Format', 'auto');
    data = add_to_data_struct(data, tmp, 'name', {'Specimen designation', 'Désignation éprouvette'});
    data = add_to_data_struct(data, tmp, 'A0', {'S0', 'Section', 'Cross-section'});
    data = add_to_data_struct(data, tmp, 'L0', {'L0', 'L0 - course standard', 'Gage length, standard travel', 'L0 SW'});

    % sheet Values
    tmp = readtable(xls_file, 'Sheet', ind_values, 'VariableNamingRule', 'modify', 'Format', 'auto');
    data = add_to_data_struct(data, tmp, 'u', {'Strain', 'Nominal strain', 'Allongement', 'Standard travel', 'Course standard'});
    data = add_to_data_struct(data, tmp, 'utr', {'Crosshead absolute', 'Traverse absolue', 'Course traverse absolue'});
    data = add_to_data_struct(data, tmp, 'ug2g', {'Grip to grip separation', 'Ecartement entre outils', 'Capteur de course', 'LVDT30mm'});
    data = add_to_data_struct(data, tmp, 'F', {'Standard force', 'Force Standard'});
    data = add_to_data_struct(data, tmp, 'temp', {'T°'});
    
    data.Af = Af;

    if ~isfield(data, 'L0')
        if isfield(data, 'ug2g')
            data.('L0') = data.ug2g(1);
        end
    end
end

function data = add_to_data_struct(data, tab, new_field, pattern)
    pattern = [cellfun(@matlab.lang.makeValidName, pattern, 'UniformOutput', false), pattern];

    fn = fieldnames(tab) ;
    ind = matches(fn, pattern, 'IgnoreCase', true);
    if any(ind) && (nnz(ind)==1)
        if ~isempty(tab.(fn{ind}){2})
            data.(new_field) = tab.(fn{ind}){2};
        end
        return
    end

    header_length = 3;
    ind = matches(table2cell(tab(1,:)), pattern, 'IgnoreCase', true);
    if any(ind) && (nnz(ind)==1)
        data.(new_field) = str2double(tab.(fn{ind})(header_length:end));
    end
end