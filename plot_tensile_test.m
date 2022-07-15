function [values,ax] = plot_tensile_test(data,varargin)
% PLOT_TENSILE_TEST
%
% WIP
% to do
% - implement kocks and mecking plot
% - implement strain hardening plots
% - implement stress strain law fit
% - implement mean curve

    p = inputParser;

    defaultGroups = table;
    defaultpltoptions = {'eng', 'true'};
    defaultfigStyle = {};
    
    addRequired(p,'data')
    addOptional(p,'groups',defaultGroups,@istable)
    addOptional(p,'pltoptions',defaultpltoptions,@iscell)
    addOptional(p,'figStyle',defaultfigStyle)
    
    parse(p,data,varargin{:});
    data = p.Results.data;
    groups = p.Results.groups;
    pltoptions = p.Results.pltoptions;
    figStyle = p.Results.figStyle;
    
    fn = groups.Properties.VariableNames;

    for i=1:1:length(pltoptions)
        if isempty(pltoptions{i})
            pltoptions{i} = defaultpltoptions;
        end
    end

    if width(groups)<length(pltoptions)
        pltoptions = unique([pltoptions{:}]);
    elseif width(groups)>length(pltoptions)
        pltoptions_u = unique([pltoptions{:}]);
        pltoptions = cell(1,width(groups));
        for i=1:1:width(groups)
            pltoptions{i} = pltoptions_u;
        end
    end
    
    %% engineering stress-strain
    if isempty(groups) && any(contains([pltoptions{:}],'eng'))
        figure
        hold on
        ax_eng = gca;
        title('Engineering stress-strain')

        E = zeros(1, length(data));
        sigma_y = zeros(1, length(data));
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

            E(i) = young_modulus(sigma,epsilon,0);
            sigma_y(i) = yield_strength(sigma,epsilon*100,E(i));
        end

        if isempty(figStyle)
            default_figure_style(ax_eng)
        end
    else 
        ax_eng = gobjects(1, width(groups));
        xlim_max = 0;
        ylim_max = 0;

        E = zeros(1, width(groups));
        sigma_y = zeros(1, width(groups));
        for ng=1:1:width(groups)
            if any(contains(pltoptions{ng},'eng'))
                figure
                hold on
                ax_eng(ng) = gca;
                title(sprintf('Engineering stress-strain, %s', fn{ng}))

                ind_data = 1:1:length(data);
                ind_data = ind_data(logical(groups.(fn{ng})));
                for i=ind_data
                    [sigma,epsilon] = sig_eps_eng(...
                        data{i}.F,...
                        data{i}.u,...
                        data{i}.A0,...
                        data{i}.L0);
                    
                    if isempty(figStyle)
                        plot(ax_eng(ng), epsilon, sigma)
                    else
                        plot(ax_eng(ng), epsilon, sigma, figStyle{:})
                    end
                    
                    Etmp = young_modulus(sigma,epsilon,0);
                    E(ng) = E(ng) + Etmp;
                    sigma_y(ng) = sigma_y(ng) + yield_strength(sigma,epsilon*100,Etmp);
                end
                E(ng) = E(ng) / length(ind_data);
                sigma_y(ng) = sigma_y(ng) / length(ind_data);

                if isempty(figStyle)
                    default_figure_style(ax_eng(ng))
                    xlim_max = max(xlim_max,max(ax_eng(ng).XLim));
                    ylim_max = max(ylim_max,max(ax_eng(ng).YLim));
                end
            else
                ax_eng(ng) = [];
            end
        end

        for nax=1:1:length(ax_eng)
            ax_eng(nax).XLim = [0 xlim_max];
            ax_eng(nax).YLim = [0 ylim_max];
        end
    end

    %% true stress-strain
    if isempty(groups) && any(contains([pltoptions{:}],'true'))
        figure
        hold on
        ax_true = gca;
        title('True stress-strain')
        for i=1:1:length(data)
            [sigma,epsilon] = sig_eps_eng(...
                data{i}.F,...
                data{i}.u,...
                data{i}.A0,...
                data{i}.L0);
            [sigma,epsilon] = sig_eps_tru(...
                sigma,...
                epsilon);
            
            if isempty(figStyle)
                plot(ax_true, epsilon, sigma)
            else
                plot(ax_true, epsilon, sigma, figStyle{:})
            end
        end

        if isempty(figStyle)
            default_figure_style(ax_true)
        end
    else 
        ax_true = gobjects(1, width(groups));
        xlim_max = 0;
        ylim_max = 0;
        for ng=1:1:width(groups)
            if any(contains(pltoptions{ng},'true'))
                figure
                hold on
                ax_true(ng) = gca;
                title(sprintf('True stress-strain, %s', fn{ng}))

                ind_data = 1:1:length(data);
                ind_data = ind_data(logical(groups.(fn{ng})));
                for i=ind_data
                    [sigma,epsilon] = sig_eps_eng(...
                        data{i}.F,...
                        data{i}.u,...
                        data{i}.A0,...
                        data{i}.L0);
                    [sigma,epsilon] = sig_eps_tru(...
                        sigma,...
                        epsilon);
                    
                    if isempty(figStyle)
                        plot(ax_true(ng), epsilon, sigma)
                    else
                        plot(ax_true(ng), epsilon, sigma, figStyle{:})
                    end
                end
                if isempty(figStyle)
                    default_figure_style(ax_true(ng))
                    xlim_max = max(xlim_max,max(ax_true(ng).XLim));
                    ylim_max = max(ylim_max,max(ax_true(ng).YLim));
                end
            else
                ax_true(ng) = [];
            end
        end
        for nax=1:1:length(ax_true)
            ax_true(nax).XLim = [0 xlim_max];
            ax_true(nax).YLim = [0 ylim_max];
        end
    end

    %% strain hardening

    %% Kocks-Mecking plots
    
    %%
    values.groups = fn;
    values.young_modulus = E;
    values.yield_strength = sigma_y;

    ax = [];
end

