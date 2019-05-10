%% initialization
clear all; clc;
% goes to the folder the current script is in
% and add this path into searching path for future use
cd(fileparts(matlab.desktop.editor.getActiveFilename))
addpath(fullfile(pwd));
disp('loading data files for plotting FIG. S3...')
load('./input/supp_fig/all_data_ns.mat')
disp('data loaded!')
%% Figure S3(a)
clf; 
set(gcf,'visible','off');
disp('Generating the figure: demographic noise changes the amplitudes of oscillations')
gcf_print_format(gcf, 'w', [10 4]);

ax3 = axes('Units', 'normalized','position',[0.67 0.15 .41 .41]);
maxX = 5; maxY = 5;
% create lines
line([0 0],[-maxX maxX]); hold on;
line([-maxY maxY],[0 0]); hold on;
line([-maxX maxX],[maxX -maxX]);  hold on;
text(0.3, 5.5,'$\Big[\matrix{2 & 1.5 \cr 1 & 1}\Big]$','FontSize',12,...
    'FontWeight','bold','Interpreter','latex')

gca_format(ax3, 2, 30, [-maxX maxX -maxY maxY], '', '', '', '');
samplePlot = all_data_ns.A0_R2S1d5T1P1.IBM{10};
box on
objs = get(ax3,'Children');
ax = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Line'),objs);
set(objs(ax),'LineWidth', 1);
set(objs(ax),'Color', [.5 .5 .5]);
set(objs(ax),'LineStyle',':');
line([0 maxX],[0 maxY],'Color',[0 0 0],'LineWidth',1.5); hold on;
box off
axis square
set(ax3,'XColor','none','YColor','none')

ax1 = axes('Units', 'normalized','position',[0.08 0.15 .65 .75]);
ODEPlot = all_data_ns.A0_R2S1d5T1P1.ODE{1,2};
ODE(1) = plot(ODEPlot(:,1),ODEPlot(:,2),'-.','Color',[0.8, 0.8, 0.8]); hold on;
ODE(2) = plot(ODEPlot(:,1),ODEPlot(:,3),'-','Color',[0.8, 0.8, 0.8]);
lgd1 = legend([ODE(1) ODE(2)],{'x, ODE','n, ODE'},...
    'Location','northeastoutside','Orientation','horizontal',...
    'Box','off','Interpreter','latex');
gca_format(ax1, 2, 16, [0 max(samplePlot(:,1)) 0 1], [0:50:max(samplePlot(:,1))], [0:0.5:1],...
    'time t', 'dynamics');
lgd1_pos = lgd1.Position;
set(lgd1, 'Position', lgd1_pos + [0.3 -0.03 0 0])

ax2 = axes('Units', 'normalized','position',[0.08 0.15 .65 .75]);
IBM(1)=plot(samplePlot(:,1),samplePlot(:,2),'-.','Color','k'); hold on;
IBM(2)=plot(samplePlot(:,1),samplePlot(:,3),'-','Color','k');
lgd2 = legend(IBM,{'x, IBM','n, IBM'},...
    'Location','northeastoutside','Orientation','horizontal',...
    'Box','off','Interpreter','latex');
set(lgd2, 'Position', lgd1_pos + [0.3 -0.10 0 0])
gca_format(ax2, 2, 16, [0 max(samplePlot(:,1)) 0 1], [0:50:max(samplePlot(:,1))], [0:0.5:1],...
    'time t', 'dynamics');
annotation('rectangle',[0.75 0.73 0.245 0.16])
% make the second axes invisible
set(ax2,'Color','none','Box','off')

set(gcf,'renderer','Painters');
print(gcf,['./output/supp_fig3a'],'-dpdf','-r600')
disp('FIG. S3a was generated!')

%% Figure S3(b)

clf;
set(gcf,'visible','off');
disp('Generating the figure: demographic noise changes the amplitudes of oscillations and leads to a TOC')
gcf_print_format(gcf, 'w', [10 4]);

ax3 = axes('Units', 'normalized','position',[0.67 0.15 .41 .41]);
maxX = 5; maxY = 5;
% create lines
line([0 0],[-maxX maxX]); hold on;
line([-maxY maxY],[0 0]); hold on;
line([-maxX maxX],[maxX -maxX]);  hold on;
text(0.3, 5.5,'$\Big[\matrix{2 & 1.5 \cr 1 & 1}\Big]$','FontSize',12,...
    'FontWeight','bold','Interpreter','latex')

gca_format(ax3, 2, 30, [-maxX maxX -maxY maxY], '', '', '', '');
samplePlot = all_data_ns.A0_R2S1d5T1P1.IBM{15};
box on
objs = get(ax3,'Children');
ax = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Line'),objs);
set(objs(ax),'LineWidth', 1);
set(objs(ax),'Color', [.5 .5 .5]);
set(objs(ax),'LineStyle',':');
line([0 maxX],[0 maxY],'Color',[0 0 0],'LineWidth',1.5); hold on;
box off
axis square
set(ax3,'XColor','none','YColor','none')

% first axes for legend1
ax1 = axes('Units', 'normalized','position',[0.08 0.15 .65 .75]);
ODEPlot = all_data_ns.A0_R2S1d5T1P1.ODE{1,2};
ODE(1) = plot(ODEPlot(:,1),ODEPlot(:,2),'-.','Color',[0.8, 0.8, 0.8]); hold on;
ODE(2) = plot(ODEPlot(:,1),ODEPlot(:,3),'-','Color',[0.8, 0.8, 0.8]);
lgd1 = legend([ODE(1) ODE(2)],{'x, ODE','n, ODE'},...
    'Location','northeastoutside','Orientation','horizontal',...
    'Box','off','Interpreter','latex');
gca_format(ax1, 2, 16, [0 max(samplePlot(:,1)) 0 1], [0:50:max(samplePlot(:,1))], [0:0.5:1],...
    'time t', 'dynamics');

% obtain position of legend 1 as a reference
lgd1_pos = lgd1.Position;
% set position of legend 1
set(lgd1, 'Position', lgd1_pos + [0.3 -0.03 0 0])

% second axes for legend2
ax2 = axes('Units', 'normalized','position',[0.08 0.15 .65 .75]);
IBM(1)=plot(samplePlot(:,1),samplePlot(:,2),'-.','Color','k'); hold on;
IBM(2)=plot(samplePlot(:,1),samplePlot(:,3),'-','Color','k');
lgd2 = legend(IBM,{'x, IBM','n, IBM'},...
    'Location','northeastoutside','Orientation','horizontal',...
    'Box','off','Interpreter','latex');
% set position of legend 2
set(lgd2, 'Position', lgd1_pos + [0.3 -0.10 0 0])
gca_format(ax2, 2, 16, [0 max(samplePlot(:,1)) 0 1], [0:50:max(samplePlot(:,1))], [0:0.5:1],...
    'time t', 'dynamics');
annotation('rectangle',[0.75 0.73 0.245 0.16])
% make the second axes invisible
set(ax2,'Color','none','Box','off')

set(gcf,'renderer','Painters');
print(gcf,['./output/supp_fig3b'],'-dpdf','-r600')
disp('FIG. S3b was generated!')
