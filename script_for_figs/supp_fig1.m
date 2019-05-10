% A0 background
clf; clc;
disp('Generating FIG. S1...')
set(gcf,'visible','off');

gcf_print_format(gcf, 'w', [8 6]);
axes('Units', 'normalized','position',[0.18 0.06 .63 .9])

maxX = 5; maxY = 5;

% create lines
line([0 0],[-maxY maxY]); hold on;
line([-maxX maxX],[0 0]); hold on;
line([0 maxX],[0 maxY]); hold on;
line([-maxX maxX],[maxX -maxX]);  hold on;
set(gca,'Xcolor','w')
set(gca,'Ycolor','w')


% adding labels
text(maxX*1.03, 0,'$S_0 - P_0 > 0$')
text(-maxX*1.53, 0,'$S_0 - P_0 < 0$')
text(-maxX*0.2, maxY* 1.05,'$R_0 - T_0 > 0$')
text(-maxX*0.2, -maxY* 1.05,'$R_0 - T_0 < 0$')

text(-1.2*maxX, maxY* 1.05,'slope = $| \theta |$')
text(0.8*maxX, -maxY* 1.05,'slope = $| \theta |$')
text(0.8*maxX, maxY* 1.05,'slope = $\frac{T_1 - R_1}{P_1 - S_1}$')

% figure formatting
gca_format(gca, 3, 30, [-maxX maxX -maxY maxY], '', '', '', '');
objs = get(gca,'Children');
ax = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Line'),objs);
set(objs(ax),'LineWidth', 3);
set(objs(ax),'Color', [0 0 0]);
axis square

% text formatting
txts = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Text'),objs);
set(objs(txts),'FontSize',18)
set(objs(txts),'Interpreter','latex')

text(-4, -2.5,'$\Big[\matrix{5 & 5.5 \cr 6 & 6}\Big]$','FontSize',24,'Interpreter','latex')
text(-5, 1.2,'$\Big[\matrix{1.5 & 5.5 \cr 1 & 6}\Big]$','FontSize',24,'Interpreter','latex')
text(-3.2, 3.8,'$\Big[\matrix{2.5 & 5.5 \cr 1 & 6}\Big]$','FontSize',24,'Interpreter','latex')
text(.05, 3.8,'$\Big[\matrix{2.5 & 1.5 \cr 1 & 1}\Big]$','FontSize',24,'Interpreter','latex')
text(2.2, 1.3,'$\Big[\matrix{1.5 & 1.5 \cr 1 & 1}\Big]$','FontSize',24,'Interpreter','latex')
text(2.2, -1.3,'$\Big[\matrix{5.5 & 1.5 \cr 6 & 1}\Big]$','FontSize',24,'Interpreter','latex')
text(0.05, -3.8,'$\Big[\matrix{4.5 & 1.5 \cr 6 & 1}\Big]$','FontSize',24,'Interpreter','latex')

set(gcf,'renderer','Painters');
print(gcf,['./output/supp_fig1'],'-dpdf','-r600')
disp('FIG. S1 was generated!')