function [values,ax] = plot_tensile_test(data,groups,pltoptions,figType,figStyle,varargin)
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

    defaultgroups = {};
    defaultpltoptions = {};
    defaultfigType = {};
    defaultfigStyle = defaultStyle;
    defaultsaveFigures = true;
    defaultsaveValues = false;
    defaultdisplayValues = true;
    
    addOptional(p,'groups',defaultgroups,@iscellstr)
    addOptional(p,'pltoptions',defaultpltoptions,@iscellstr)
    addOptional(p,'figType',defaultfigType,@iscellstr)
    addOptional(p,'figStyle',defaultfigStyle)
    addParameter(p,'saveFigures',defaultsaveFigures,@isnumeric)
    addParameter(p,'saveValues',defaultsaveValues,@isnumeric)
    addParameter(p,'displayValues',defaultdisplayValues,@isnumeric)
    
    parse(p,pltoptions,groups,figType,figStyle,varargin);
    groups = p.Results.groups;
    pltoptions = p.Results.pltoptions;
    figType = p.Results.figType;
    figStyle = p.Results.figStyle;
    saveFigures = p.Results.saveFigures;
    saveValues = p.Results.saveValues;
    displayValues = p.Results.displayValues;
    
    fn = groups.Properties.VariableNames;    
    
    %% engineering stress-strain
    
    
end

