%% WIP
% to do
% - print figure example using export_fig
% - plotoptions
%    - truf = true stress strain with Af
%    - shr = strain hardening
%    - mean = mean curve
%    - knm = kocks and mecking plots
%%

%%% example %%%
close all

%% load data
% get file handles
% assumes that the data has been saved as a structure with mandatory fields
% utr - the tensile machine miving beam displacement
% u - the displacement
% F - the force
% A0 - the initial cross-section
% L0 - the initial gauge length
% and optional field
% Af - the final cross section (at rupture)
files = dir('example_data/*.mat');

data = cell(size(files));
name = cell(size(files));
for i1=1:1:length(data)
    data{i1} = load([files(i1).folder '/' files(i1).name]);
    name{i1} = files(i1).name;
end

%% grouping data
% let's define 3 groups, one containing tensile data corresponding to all
% stainless steels, one only for 316L, and one for the second test (02) of
% 304L stainless steel.
% let's name those groups 'SS', '316L', and '304L 02' respectively
keywords = {{'stainless_steel'},{'316L'},{'304L','02'}};
group_names = {'SS', '316L', '304L 02'};

% get indices
groups = group_data(name,keywords,group_names);

%% plot figure of interest
% let's define what to plot for each group
pltoptions = {
    {'eng','true'}, ... for group 'stainless_steel'
    {'eng','true'}, ... for group '316L'
    {}         ... for group '304L','02'
};

values = plot_tensile_test(...
    data, ...
    'groups', groups, ...
    'pltoptions', pltoptions);





