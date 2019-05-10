function sections_A0_fig1(maxX, maxY, theta, pos)
% initialization
%restoredefaultpath
%cd(fileparts(matlab.desktop.editor.getActiveFilename))


% some basic parameters
% A = [R, S; T, P];
% maxX = 5; maxY = 5;

% the slope of dividers is set to be 1 for easy visualization
% in simulations, the parameters are actually
% theta = 2;

A1 = [3, 0; 5, 1]; 
slope2 = .97;
% slope2 = (A1(2,1)-A1(1,1))/(A1(2,2)-A1(1,2));
% set slope2=1 rather than real definition for better visualization


clf; clc;
% create lines
axes('Units', 'normalized','position',pos)
line([0 0],[-maxY maxY]); hold on;
line([-maxX maxX],[0 0]); hold on;
line([0 maxX],[0 maxX].*slope2); hold on;
line([-maxX maxX],[maxX -maxX].*(theta));  hold on;

% adding labels
text(maxX*1.03, 0,'$S_0 - P_0 > 0$')
text(-maxX*1.3, -maxY*0.08,'$S_0 - P_0 < 0$')
text(-maxX*0.2, maxY* 1.1,'$R_0 - T_0 > 0$')
text(-maxX*0.2, -maxY* 1.1,'$R_0 - T_0 < 0$')

text(-1.15*maxX/theta, maxY* 1.05,'$|$slope$|$ = $\theta$')
text(0.8*maxX/theta, -maxY* 1.1,'$|$slope$|$ = $\theta$')
text(0.8*maxX/theta, maxY* 1.05,'slope = $\frac{T_1 - R_1}{P_1 - S_1}$')


% figure formatting
gca_format(gca, 3, 30, [-maxX maxX -maxY maxY], '', '', '', '');
objs = get(gca,'Children');
ax = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Line'),objs);
set(objs(ax),'LineWidth', 2);
set(objs(ax),'Color', [0.7 0.7 0.7]);
axis equal

% text formatting
txts = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Text'),objs);
set(objs(txts),'FontSize',22)
set(objs(txts),'Interpreter','latex')

% patches formattion
patch = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Patch'),objs);
set(objs(patch),'LineStyle','none');
set(objs(patch),'FaceColor',[0 0.6 0.8]);
set(objs(patch),'FaceAlpha',0.3);
uistack(objs(patch),'bottom')


end
% new axes for patches outside the quadrants, if needed.


