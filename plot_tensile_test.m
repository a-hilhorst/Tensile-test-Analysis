function [values,ax] = plot_tensile_test(groups,figType,figStyle,varargin)
% PLOT_TENSILE_TEST
%
%

    p = inputParser;

    defaultgroups = {};
    defaultfigType = {};
    defaultfigStyle = defaultStyle;
    defaultsaveFigures = true;
    defaultsaveValues = false;
    defaultdisplayValues = true;
    
    addOptional(p,'groups',defaultgroups,@iscellstr)
    addOptional(p,'figType',defaultfigType,@iscellstr)
    addOptional(p,'figStyle',defaultfigStyle)
    addParameter(p,'saveFigures',defaultsaveFigures,@isnumeric)
    addParameter(p,'saveValues',defaultsaveValues,@isnumeric)
    addParameter(p,'displayValues',defaultdisplayValues,@isnumeric)
    
    parse(p,groups,figType,figStyle,varargin);
    groups = p.Results.groups;
    figType = p.Results.figType;
    figStyle = p.Results.figStyle;
    saveFigures = p.Results.saveFigures;
    saveValues = p.Results.saveValues;
    displayValues = p.Results.displayValues;
    
    fn = groups.Properties.VariableNames;    
    
    %% engineering stress-strain
    
    
end

