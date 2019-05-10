% A0 background
clf; clc;
disp('Generating FIG. S2...')
set(gcf,'visible','off');

gcf_print_format(gcf, 'w', [8 6]);
axes('Units', 'normalized','position',[0.18 0.06 .63 .9])

maxX = 5; maxY = 5;

% create lines
line([0 0],[-maxY maxY]); hold on;
line([-maxX maxX],[0 0]); hold on;

set(gca,'Xcolor','w')
set(gca,'Ycolor','w')

% adding labels
text(maxX*1.03, 0,'$S_0 - P_0 > 0$')
text(-maxX*1.53, 0,'$S_0 - P_0 < 0$')
text(-maxX*0.2, maxY* 1.05,'$R_0 - T_0 > 0$')
text(-maxX*0.2, -maxY* 1.05,'$R_0 - T_0 < 0$')

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

% 1st quadrant
text(1.2, 3.5,'$\Big[\matrix{R_0 & S_0 \cr 1 & 1}\Big]$','FontSize',20)
text(0.95, 2.4,'$R_0 = 1.0 + 0.1m$','FontSize',16)
text(0.94, 1.7,'$S_0 = 1.0 + 0.1m$','FontSize',16)
text(0.4, 1.0,'$m = \{m \in$','FontSize',14)
text(2.2, 0.95,['',char(8469)],'FontSize',14)
text(2.6, 1.0,'$^0 \mid m \leq 20\}$','FontSize',14)

% 2nd quadrant
text(-3.8, 3.5,'$\Big[\matrix{R_0 & S_0 \cr 1 & 6}\Big]$','FontSize',20)
text(-4.05, 2.4,'$R_0 = 1.0 + 0.1m$','FontSize',16)
text(-4.0, 1.7,'$S_0 = 4.0 + 0.1m$','FontSize',16)
text(-4.5, 1.0,'$m = \{m \in$','FontSize',14)
text(-2.7, 0.95,['',char(8469)],'FontSize',14)
text(-2.3, 1.0,'$ \mid m \leq 20\}$','FontSize',14)

% 3rd quadrant
text(-3.8, -1.7,'$\Big[\matrix{R_0 & S_0 \cr 6 & 6}\Big]$','FontSize',20)
text(-4.05, -2.8,'$R_0 = 4.0 + 0.1m$','FontSize',16)
text(-4.0, -3.5,'$S_0 = 4.0 + 0.1m$','FontSize',16)
text(-4.6, -4.2,'$m = \{m \in$','FontSize',14)
text(-2.8, -4.25,['',char(8469)],'FontSize',14)
text(-2.4, -4.2,'$^0 \mid m \leq 20\}$','FontSize',14)

% 4nd quadrant
text(1.2, -1.7,'$\Big[\matrix{R_0 & S_0 \cr 6 & 1}\Big]$','FontSize',20)
text(0.95, -2.8,'$R_0 = 4.0 + 0.1m$','FontSize',16)
text(0.94, -3.5,'$S_0 = 1.0 + 0.1m$','FontSize',16)
text(0.6, -4.2,'$m = \{m \in$','FontSize',14)
text(2.4, -4.25,['',char(8469)],'FontSize',14)
text(2.8, -4.2,'$ \mid m \leq 20\}$','FontSize',14)

objs = get(gca,'Children');
txts = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Text'),objs);
set(objs(txts),'Interpreter','latex')

set(gcf,'renderer','Painters');
print(gcf,['./output/supp_fig2'],'-dpdf','-r600')
disp('FIG. S2 was generated!')