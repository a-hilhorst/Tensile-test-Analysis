function [values,ax] = plot_tensile_test(data,varargin)
% PLOT_TENSILE_TEST
%
% WIP
% to do
% - implement plotting of eng stress strain
% - implement kocks and mecking plot
% - implement strain hardening plots
% - implement stress strain law fit
% - implement mean curve

    p = inputParser;

    defaultGroups = table;
    defaultpltoptions = {};
    defaultfigType = {};
    defaultfigStyle = {};
    defaultSaveFigures = true;
    defaultSaveValues = false;
    defaultDisplayValues = true;
    
    addRequired(p,'data')
    addOptional(p,'groups',defaultGroups,@iscellstr)
    addOptional(p,'pltoptions',defaultpltoptions,@iscellstr)
    addOptional(p,'figType',defaultfigType,@iscellstr)
    addOptional(p,'figStyle',defaultfigStyle)
    addParameter(p,'saveFigures',defaultSaveFigures,@isnumeric)
    addParameter(p,'saveValues',defaultSaveValues,@isnumeric)
    addParameter(p,'displayValues',defaultDisplayValues,@isnumeric)
    
    parse(p,data,varargin{:});
    data = p.Results.data;
    groups = p.Results.groups;
    pltoptions = p.Results.pltoptions;
    figType = p.Results.figType;
    figStyle = p.Results.figStyle;
    saveFigures = p.Results.saveFigures;
    saveValues = p.Results.saveValues;
    displayValues = p.Results.displayValues;
    
    fn = groups.Properties.VariableNames;    
    
    %% engineering stress-strain
    figure
    hold on
    ax_eng = gca;

    if isempty(groups)
        for i=1:1:length(data)
            [sigma,epsilon] = sig_eps_eng(...
                data{i}.F,...
                data{i}.u,...
                data{i}.A0,...
                data{i}.L0);
            
            if isempty(figStyle)
                plot(ax_eng, epsilon, sigma)
            else
                plot(ax_eng, epsilon, sigma, figStyle{:})
            end
        end
    end

    if isempty(figStyle)
        default_figure_style(ax_eng)
    end
    
    %%
    values = [];
    ax = [];
end

