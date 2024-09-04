function data = import_from_txt(txt_file, varargin)
% IMPORT_FROM_XLSX
% u - the displacement
% F - the force
% A0 - the initial cross-section
% L0 - the initial gauge length
% Af - the final cross section (at rupture)

    %% Input parsing
    defaulttra2txt = false;
    defaultAf = NaN;
    defaultL0 = NaN;

    p = inputParser;

    addRequired(p, 'txt_file')
    addOptional(p, 'tra2txt', defaulttra2txt)
    addOptional(p, 'Af', defaultAf)
    addOptional(p, 'L0', defaultL0)

    parse(p, txt_file,varargin{:});
    txt_file = p.Results.txt_file;
    tra2txt = p.Results.tra2txt;
    Af = p.Results.Af;
    L0 = p.Results.L0;

    %% TRA to txt
    if tra2txt
        new_txt_file = txt_file(1:end-3) + "txt";
        copyfile(txt_file, new_txt_file)
        txt_file = new_txt_file;
    end

    %% Import data
    data = struct();
    
    fid = fopen(txt_file);

    tline = fgetl(fid);
    header_length = 0;
    p0_line = {};
    p1_line = {};
    p2_line = {};
    while tline ~= -1
        p2_line = p1_line;
        p1_line = p0_line;
        p0_line = split_wo_quotes(tline);
        p0_line = cellfun(@(x) strrep(x,'"',''), p0_line, 'UniformOutput', false);
        if any(matches(p0_line{1}, {'Specimen designation', 'Désignation éprouvette'}))
            data.name = p0_line{2};
        elseif any(matches(p0_line{1}, {'S0', 'Section', 'Cross-section'}))
            data.A0 = str2double(p0_line{2});
        elseif any(matches(p0_line{1}, {'L0', 'L0 - course standard', 'Gage length, standard travel', 'L0 SW'}))
            data.L0 = str2double(p0_line{2});
        end

        if all(~isnan(str2double(p0_line)))
            break
        end
        tline = fgetl(fid);

        header_length = header_length + 1;
    end
    fclose(fid);

    tmp = readmatrix(txt_file, 'NumHeaderLines', header_length);
    data = add_to_data_struct(data, tmp, p2_line, 'u', {'Strain', 'Nominal strain', 'Allongement', 'Standard travel', 'Course standard'});
    data = add_to_data_struct(data, tmp, p2_line, 'utr', {'Crosshead absolute', 'Traverse absolue', 'Course traverse absolue'});
    data = add_to_data_struct(data, tmp, p2_line, 'ug2g', {'Grip to grip separation', 'Ecartement entre outils', 'Capteur de course', 'LVDT30mm'});
    data = add_to_data_struct(data, tmp, p2_line, 'F', {'Standard force', 'Force Standard'});
    data = add_to_data_struct(data, tmp, p2_line, 'temp', {'T°'});
    
    data.Af = Af;

    % add L0 if missing from header OR
    % replaces L0 if ug2g exists
    if isfield(data, 'ug2g')
        data.L0 = data.ug2g(1);
    end

    % if manually inputting L0
    data.L0 = L0;
end

function data = add_to_data_struct(data, tab, fn, new_field, pattern)
    pattern = [cellfun(@matlab.lang.makeValidName, pattern, 'UniformOutput', false), pattern];

    ind = matches(fn, pattern, 'IgnoreCase', true);
    if any(ind) && (nnz(ind)==1)
        data.(new_field) = tab(:, find(fn{ind},1,'first'));
        return
    end
end

function splt_str = split_wo_quotes(str)
    % Regular expression to match quoted parts and unquoted parts
    expr = '("[^"]*"|''[^'']*''|[^,]+)';

    tokens = regexp(str, expr, 'match');
    splt_str = strtrim(tokens);
end