%% initialization
% reset the environment
clear all; clc;
% goes to the folder the current script is in
% and add this path into searching path for future use
cd(fileparts(matlab.desktop.editor.getActiveFilename))
addpath(fullfile(pwd));
L = 100;
% D=0
disp('loading data files for plotting FIG. 3a...')
load(['./input/movies/propagating_wave.mat'])
load(['./input/movies/propagating_wave_gr.mat'])
dyn = load(['./input/movies/propagating_wave_dyn.dat']);
disp('data loaded!')
%%
% create a new figure window
set(gcf,'visible','off');
clf;
disp('Generating the figure: spatial profiles and pair correlaion of snapshots for Dn=0')

gcf_print_format(gcf, 'w', [15 8]);

% assign time frames for plotting
t_s = [28, 61, 90];     % frame of time to plot
for ii = 1:length(t_s)
    M_plot{ii}.step = t_s(ii)./0.05; % frame of step to plot, a step = 0.05 unit time
    M_s = strcat('M',sprintf('%04d',M_plot{ii}.step));  % matrix at each step to plot
    M_plot{ii}.value = eval(M_s);
end



% the first snapshot in a new plot axes
axes('Units', 'normalized','position',[-0.02 0.42 0.45 0.45])
spatial_figure(M_plot{1}, dyn, 0, 100, 0)
title(['t=',sprintf('%3.2f',t_s(1))],'interpreter','latex')
xlabel('')
% gr of the first snapshot in new plot axes
axes('Units', 'normalized','position',[0.085 0.12 0.238 0.17])
line([0 L/2],[1 1],'Color',[0.7, 0.7, 0.7],'LineStyle',':',...
    'LineWidth',2);hold on;
plot([0:L/2-1],gr_C(:,M_plot{1}.step + 1),'k'); hold on;
plot([0:L/2-1],gr_CN(:,M_plot{1}.step + 1),'Color',[0.7 0 0]); 
gca_format(gca, 3, 24, [1 20 0.1 10.1], [1,10,20], [0.1,1,10],...
    'r $(\Delta x)$', '$g(r)$')
set(gca,'YScale','log')
box on
xlabel('')

% the second in a new plot axes
axes('Units', 'normalized','position',[0.26 0.42 0.45 0.45])
spatial_figure(M_plot{2}, dyn, 0, 100, 0)
line1 = '$D_n=0$';
line2 = ['t=',sprintf('%3.2f',t_s(2))];
title(sprintf('\\begin{tabular}{c} %s %s %s \\end{tabular}',line1,'\\',line2),...
    'interpreter','latex')
set(gca,'YTickLabel','')
ylabel('')
% gr of the second snapshot in a new plot axes
axes('Units', 'normalized','position',[0.367 0.12 0.238 0.17])
line([0 L/2],[1 1],'Color',[0.7, 0.7, 0.7],'LineStyle',':',...
    'LineWidth',2);hold on;
plot([0:L/2-1],gr_C(:,M_plot{2}.step + 1),'k'); hold on;
plot([0:L/2-1],gr_CN(:,M_plot{2}.step + 1),'Color',[0.7 0 0]);
gca_format(gca, 3, 24, [1 20 0.1 10.1], [1,10,20], [0.1,1,10],...
    'r $(\Delta x)$', '$g(r)$')
set(gca,'YScale','log')
set(gca,'YTickLabel','')
ylabel('')
box on

% 
% the third in a new plot axes
axes('Units', 'normalized','position',[0.57 0.42 0.45 0.45])
spatial_figure(M_plot{3}, dyn, 0, 100, 0)
title(['t=',sprintf('%3.2f',t_s(3))],'interpreter','latex')
ylabel('')
xlabel('')
set(gca,'YTickLabel','') 
hcb = colorbar;
set(hcb,'TickLabelInterpreter','latex')
ylabel(hcb, 'Environment','Interpreter','latex')
% gr of the third snapshot in a new plot axes
axes('Units', 'normalized','position',[0.645 0.12 0.238 0.17])
line([0 L/2],[1 1],'Color',[0.7, 0.7, 0.7],'LineStyle',':',...
    'LineWidth',2);hold on;
grC = plot([0:L/2-1],gr_C(:,M_plot{3}.step + 1),'k'); hold on;
grCN = plot([0:L/2-1],gr_CN(:,M_plot{3}.step + 1),'Color',[0.7 0 0]);
gca_format(gca, 3, 24, [1 20 0.1 10.1], [1,10,20], [0.1,1,10],...
    'r $(\Delta x)$', '$g(r)$')
set(gca,'YScale','log')
set(gca,'YTickLabel','')
ylabel('')
xlabel('')
box on
lgd = legend([grC,grCN],{'$g_{CC}(r)$','$g_{CN}(r)$'},...
    'Location','northeastoutside','Orientation','vertical',...
    'Box','off','Interpreter','latex','FontSize',18);
lgd_pos = lgd.Position;
set(lgd, 'Position', lgd_pos + [0.135 0 0 0])

set(gcf,'renderer','Painters');
print(gcf,['./output/fig3a'],'-dpdf','-r600')
disp('FIG. 3a was generated!')