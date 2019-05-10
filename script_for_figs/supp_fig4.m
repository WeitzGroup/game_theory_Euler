%% initialization
clear; clc;
cd(fileparts(matlab.desktop.editor.getActiveFilename))
addpath(fullfile(pwd));
disp('loading data files for plotting FIG. S4...')
load('./input/fig2/all_data_s_scan.mat')
disp('data loaded!')
%% section 1
clf; 
set(gcf,'visible','off');
disp('Generating figures: oscillations are typical in spatial simulations with Dn=infinity')
gcf_print_format(gcf, 'w', [10 4]);

ax2 = axes('Units', 'normalized','position',[0.67 0.15 .41 .41]);
maxX = 5; maxY = 5;
% create lines
line([0 0],[-maxX maxX]); hold on;
line([-maxY maxY],[0 0]); hold on;
line([0 maxX],[0 maxY]); hold on;
line([-maxX maxX],[maxX -maxX]);  hold on;
text(-4, 7,'$A_0 = \Big[\matrix{2.5 & 5.5 \cr 1 & 6}\Big]$','FontSize',14,...
    'FontWeight','bold','Interpreter','latex')
patch = fill([-maxX 0 0],[maxY maxY 0],'w');
set(patch,'LineStyle','none','FaceColor',[0.6 0.6 0.6],'FaceAlpha',0.4);

gca_format(ax2, 2, 30, [-maxX maxX -maxY maxY], '', '', '', '');
objs = get(ax2,'Children');
ax = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Line'),objs);
set(objs(ax),'LineWidth', 1);
set(objs(ax),'Color', [0 0 0]);
box on
axis square

ax1 = axes('Units', 'normalized','position',[0.08 0.15 .7 .75]);
samplePlot = all_data_s_scan.A0_R2d5S5d5T1P6.DInf{10};

plot(samplePlot(:,1),samplePlot(:,2),'-.','Color','k'); hold on;
plot(samplePlot(:,1),samplePlot(:,3),'-','Color','k');
legend({'x','n'},'box','off',...
    'Location','northeast','Orientation','horizontal','Interpreter','latex')
title('$D_n = \infty$','Interpreter','latex')
gca_format(ax1, 2, 16, [0 max(samplePlot(:,1)) 0 1], [0:50:max(samplePlot(:,1))], [0:0.5:1],...
    'time t', 'dynamics');
set(gcf,'renderer','Painters');
print(gcf,['./output/supp_fig4a'],'-dpdf','-r600')
disp('FIG. S4a was generated!')

%% section 2
clf;
set(gcf,'visible','off');

gcf_print_format(gcf, 'w', [10 4]);

ax2 = axes('Units', 'normalized','position',[0.67 0.15 .41 .41]);
maxX = 5; maxY = 5;
% create lines
line([0 0],[-maxX maxX]); hold on;
line([-maxY maxY],[0 0]); hold on;
line([0 maxX],[0 maxY]); hold on;
line([-maxX maxX],[maxX -maxX]);  hold on;
text(-4, 7,'$A_0=\Big[\matrix{2.5 & 1.5 \cr 1 & 1}\Big]$','FontSize',14,...
    'FontWeight','bold','Interpreter','latex')
patch = fill([0 0 maxX],[0 maxY  maxY],'w');
set(patch,'LineStyle','none','FaceColor',[0.6 0.6 0.6],'FaceAlpha',0.4);

gca_format(ax2, 2, 30, [-maxX maxX -maxY maxY], '', '', '', '');
box on
objs = get(ax2,'Children');
ax = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Line'),objs);
set(objs(ax),'LineWidth', 1);
set(objs(ax),'Color', [0 0 0]);

axis square

ax1 = axes('Units', 'normalized','position',[0.08 0.15 .7 .75]);
samplePlot = all_data_s_scan.A0_R2d5S1d5T1P1.DInf{10};

plot(samplePlot(:,1),samplePlot(:,2),'-.','Color','k'); hold on;
plot(samplePlot(:,1),samplePlot(:,3),'-','Color','k');
legend({'x','n'},'box','off',...
    'Location','northeast','Orientation','horizontal','Interpreter','latex')
title('$D_n = \infty$','Interpreter','latex')
gca_format(ax1, 2, 16, [0 max(samplePlot(:,1)) 0 1], [0:50:max(samplePlot(:,1))], [0:0.5:1],...
    'time t', 'dynamics');
set(gcf,'renderer','Painters');
print(gcf,['./output/supp_fig4b'],'-dpdf','-r600')
disp('FIG. S4b was generated!')
%% section 3
clf;
set(gcf,'visible','off');

gcf_print_format(gcf, 'w', [10 4]);

ax2 = axes('Units', 'normalized','position',[0.67 0.15 .41 .41]);
maxX = 5; maxY = 5;
% create lines
line([0 0],[-maxX maxX]); hold on;
line([-maxY maxY],[0 0]); hold on;
line([0 maxX],[0 maxY]); hold on;
line([-maxX maxX],[maxX -maxX]);  hold on;
text(-4, 7,'$A_0=\Big[\matrix{1.5 & 1.5 \cr 1 & 1}\Big]$','FontSize',14,...
    'FontWeight','bold','Interpreter','latex')
patch = fill([0 maxX maxX],[0 0 maxY],'w');
set(patch,'LineStyle','none','FaceColor',[0.6 0.6 0.6],'FaceAlpha',0.4);

gca_format(ax2, 2, 30, [-maxX maxX -maxY maxY], '', '', '', '');
box on
objs = get(ax2,'Children');
ax = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Line'),objs);
set(objs(ax),'LineWidth', 1);
set(objs(ax),'Color', [0 0 0]);

axis square

ax1 = axes('Units', 'normalized','position',[0.08 0.15 .7 .75]);
samplePlot = all_data_s_scan.A0_R1d5S1d5T1P1.DInf{10};

plot(samplePlot(:,1),samplePlot(:,2),'-.','Color','k'); hold on;
plot(samplePlot(:,1),samplePlot(:,3),'-','Color','k');
legend({'x','n'},'box','off',...
    'Location','northeast','Orientation','horizontal','Interpreter','latex')
title('$D_n = \infty$','Interpreter','latex')
gca_format(ax1, 2, 16, [0 max(samplePlot(:,1)) 0 1], [0:50:max(samplePlot(:,1))], [0:0.5:1],...
    'time t', 'dynamics');
set(gcf,'renderer','Painters');
print(gcf,['./output/supp_fig4c'],'-dpdf','-r600')
disp('FIG. S4c was generated!')
%% section 4
clf;
set(gcf,'visible','off');

gcf_print_format(gcf, 'w', [10 4]);

ax2 = axes('Units', 'normalized','position',[0.67 0.15 .41 .41]);
maxX = 5; maxY = 5;
% create lines
line([0 0],[-maxX maxX]); hold on;
line([-maxY maxY],[0 0]); hold on;
line([0 maxX],[0 maxY]); hold on;
line([-maxX maxX],[maxX -maxX]);  hold on;
text(-4, 7,'$A_0=\Big[\matrix{5.5 & 2 \cr 6 & 1}\Big]$','FontSize',14,...
    'FontWeight','bold','Interpreter','latex')
patch = fill([0 maxX maxX],[0 0 -maxY],'w');
set(patch,'LineStyle','none','FaceColor',[0.6 0.6 0.6],'FaceAlpha',0.4);

gca_format(ax2, 2, 30, [-maxX maxX -maxY maxY], '', '', '', '');
box on
objs = get(ax2,'Children');
ax = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Line'),objs);
set(objs(ax),'LineWidth', 1);
set(objs(ax),'Color', [0 0 0]);

axis square

ax1 = axes('Units', 'normalized','position',[0.08 0.15 .7 .75]);
samplePlot = all_data_s_scan.A0_R5d5S2T6P1.DInf{10};

plot(samplePlot(:,1),samplePlot(:,2),'-.','Color','k'); hold on;
plot(samplePlot(:,1),samplePlot(:,3),'-','Color','k');
legend({'x','n'},'box','off',...
    'Location','northeast','Orientation','horizontal','Interpreter','latex')
title('$D_n = \infty$','Interpreter','latex')
gca_format(ax1, 2, 16, [0 max(samplePlot(:,1)) 0 1], [0:50:max(samplePlot(:,1))], [0:0.5:1],...
    'time t', 'dynamics');
set(gcf,'renderer','Painters');
print(gcf,['./output/supp_fig4d'],'-dpdf','-r600')
disp('FIG. S4d was generated!')
