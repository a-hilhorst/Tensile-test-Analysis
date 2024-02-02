function default_figure_style(ax)
% DEFAULT_FIGURE_STYLE
%

    set(ax.Parent,...
        'Color','w',...
        'units','normalized','outerposition',[0 0 0.5 1])
    set(ax,'FontSize',20,...
        'Linewidth',2,...
        'TickDir','out',...
        'TickLength',[.02 .02],...
        'XMinorTick','on',...
        'YMinorTick','on',...
        'Xgrid','on',...
        'Ygrid','on')
    set(ax.Children,...
        'Linewidth',3)
end