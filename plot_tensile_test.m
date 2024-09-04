function [values,ax] = plot_tensile_test(data,varargin)
% PLOT_TENSILE_TEST
%
% WIP
% to do
% - implement stress strain law fit
% - implement mean curve

    %% Input parsing
    p = inputParser;

    % default
    defaultGroups = table;
    defaultpltOptions = {'eng', 'true'};
    defaultfigStyle = {};
    
    % required and optional variables
    addRequired(p,'data')
    addOptional(p,'groups',defaultGroups,@istable)
    addOptional(p,'pltoptions',defaultpltOptions,@iscell)
    addOptional(p,'figStyle',defaultfigStyle)
    
    parse(p,data,varargin{:});
    data = p.Results.data;
    groups = p.Results.groups;
    pltOptions = p.Results.pltoptions;
    figStyle = p.Results.figStyle;
    
    groupNames = groups.Properties.VariableNames;

    for i=1:1:length(pltOptions)
        if isempty(pltOptions{i})
            pltOptions{i} = defaultpltOptions;
        end
    end

    % pltOptions based on groups
    numGroups = width(groups);
    if numGroups < length(pltOptions)
        pltOptions = unique([pltOptions{:}]);
    elseif numGroups > length(pltOptions)
        uniqueOptions = unique([pltOptions{:}]);
        pltOptions = repmat({uniqueOptions}, 1, numGroups);
    end

    % plot settings
    plotTypes = {'eng', 'true', 'shr'};
    plotTitles = {'Engineering stress-strain', 'True stress-strain', 'Strain hardening rate'};
    plotFunctions = {@plotEngineering, @plotTrue, @plotStrainHardening};

    ax = cell(1, 3);
    E = zeros(1, max(1, numGroups));
    sigma_y = zeros(1, max(1, numGroups));
    
    %
    for i = 1:length(plotTypes)
        if isempty(groups) && any(contains([pltOptions{:}], plotTypes{i}))
            [ax{i}, E, sigma_y] = plotFunctions{i}(data, figStyle, plotTitles{i});
        else
            ax{i} = gobjects(1, numGroups);
            emptyAx = false(1, numGroups);

            for ng = 1:numGroups
                if any(contains(pltOptions{ng}, plotTypes{i}))
                    [ax{i}(ng), E(ng), sigma_y(ng)] = ...
                        plotFunctions{i}(data(logical(groups.(groupNames{ng}))), figStyle, ...
                        sprintf('%s, %s', plotTitles{i}, groupNames{ng}));
                else
                    emptyAx(ng) = true;
                end
            end
            ax{i}(emptyAx) = [];
            setAxisLimits(ax{i});
        end
    end
    
    % Output values
    values.groups = groupNames;
    values.young_modulus = E;
    values.yield_strength = sigma_y;
end

function [ax, E, sigma_y] = plotEngineering(data, figStyle, titleStr)
    figure; 
    hold on;
    ax = gca; 
    title(titleStr);

    E = zeros(1, length(data));
    sigma_y = zeros(1, length(data));
    for i = 1:length(data)
        [sigma, epsilon] = sig_eps_eng(data{i}.F, data{i}.u, data{i}.A0, data{i}.L0);
        if isempty(figStyle)
            plot(epsilon, sigma);
        else
            plot(epsilon, sigma, figStyle{:});
        end
        E(i) = young_modulus(sigma, epsilon, 0);
        sigma_y(i) = yield_strength(sigma, epsilon * 100, E(i));
    end
    E = mean(E);
    sigma_y = mean(sigma_y);
    default_figure_style(ax);
end

function [ax, E, sigma_y] = plotTrue(data, figStyle, titleStr)
    figure; 
    hold on;
    ax = gca; 
    title(titleStr);

    E = zeros(1, length(data));
    sigma_y = zeros(1, length(data));
    for i = 1:length(data)
        [sigma, epsilon] = sig_eps_eng(data{i}.F, data{i}.u, data{i}.A0, data{i}.L0);
        E(i) = young_modulus(sigma, epsilon, 0);
        sigma_y(i) = yield_strength(sigma, epsilon * 100, E(i));
        [sigma, epsilon] = sig_eps_tru(sigma, epsilon);
        if isempty(figStyle)
            plot(epsilon, sigma);
        else
            plot(epsilon, sigma, figStyle{:});
        end
    end
    E = mean(E);
    sigma_y = mean(sigma_y);
    default_figure_style(ax);
end

function [ax, E, sigma_y] = plotStrainHardening(data, figStyle, titleStr)
    figure; 
    hold on;
    ax = gca; 
    title(titleStr);

    E = zeros(1, length(data));
    sigma_y = zeros(1, length(data));
    for i = 1:length(data)
        [sigma, epsilon] = sig_eps_eng(data{i}.F, data{i}.u, data{i}.A0, data{i}.L0);
        E(i) = young_modulus(sigma, epsilon, 0);
        sigma_y(i) = yield_strength(sigma, epsilon * 100, E(i));
        [sigma, epsilon] = sig_eps_tru(sigma, epsilon);
        [shr, ~, epsilon] = strain_hardening(sigma, epsilon, sigma_y(i));
        if isempty(figStyle)
            plot(epsilon, shr, '-');
        else
            plot(epsilon, shr, '-', figStyle{:});
        end
    end
    E = mean(E);
    sigma_y = mean(sigma_y);
    default_figure_style(ax);
end

function setAxisLimits(ax)
    xlimMax = 0;
    ylimMax = 0;
    for nax = 1:length(ax)
        xlimMax = max(xlimMax,max(ax(nax).XLim));
        ylimMax = max(ylimMax,max(ax(nax).YLim));
    end
    for nax = 1:length(ax)
        ax(nax).XLim = [0, xlimMax];
        ax(nax).YLim = [0, ylimMax];
    end
end
