%% Preprocessing the raw data - classify dynamics
% reset the environment
clear all; clc;
% goes to the folder the current script is in
% and add this path into searching path for future use
cd(fileparts(matlab.desktop.editor.getActiveFilename))
addpath(fullfile(pwd));

classify_dyn;

%% import classfications of dynamics
clear; clc;
cd(fileparts(matlab.desktop.editor.getActiveFilename))
addpath(genpath(pwd));
disp('loading data files for plotting FIG. 2...')
load('./input/fig2/dynClass_ns.mat')
load('./input/fig2/dynClass_s.mat')
disp('data loaded!')
%% Heatmaps for non-spatial results

for fn=fd'
    % coordinate on (S-P, R-T) space, normalized and shift
    % to avoid non-positive index
    cde = (dynClass_ns.(fn{1}).all{1,1} + 6).*10;
    dynClass_ns_M(cde(1),cde(2)) = 0;
    for rs = 1:length(dynClass_ns.(fn{1}).all)
        tmpStr = dynClass_ns.(fn{1}).all{rs,2};
        if isempty(strfind(tmpStr,'TOC'))
            dynClass_ns_M(cde(1),cde(2)) =...
                dynClass_ns_M(cde(1),cde(2))+1;
        end
    end
end

%%

set(gcf,'visible','off');
clf;
disp('Generating the figure: fraction of averted dynamics for non-spatial simulations...')
gcf_print_format(gcf, 'w', [8.5 7.7]);
axes('Units', 'normalized','position',[0.14 0.16 0.75 0.75])
imagesc(dynClass_ns_M'./length(dynClass_ns.(fn{1}).all))

gca_format(gca, 1, 30, [40 80 40 80], [40:10:80], [40:10:80],...
    '$S_0 - P_0$', '$R_0 - T_0$')
set(gca,'Xtick',[40:10:80])
set(gca,'XtickLabel',cellstr(num2str([40:10:80]'./10-6))')
set(gca,'Ytick',[40:10:80])
set(gca,'YtickLabel',cellstr(num2str([40:10:80]'./10-6))')
colormap(parula)
caxis([0 1]);
hcb = colorbar;
colorbar('Ticks',[0:0.2:1],...
    'TickLabels',cellstr(num2str([0:0.2:1]'))',...
    'TickLabelInterpreter','latex')
shading flat
axis square
axis xy


% create boundaries
maxX = 2.5; maxY = 2.5;theta = 2;

A1 = [3, 0; 5, 1]; slope2 = (A1(2,1)-A1(1,1))/(A1(2,2)-A1(1,2));
line(([0 0]+6).*10,([-maxY maxY]+6).*10); hold on;
line(([-maxY maxY]+6).*10,([0 0]+6).*10); hold on;
line(([0 maxX]+6).*10,[0 maxX].*10.*slope2+60); hold on;
line(([-maxX maxX]+6).*10,[-maxX maxX].*10.*(-theta)+60);  hold on;

objs = get(gca,'Children');
ax = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Line'),objs);
set(objs(ax),'LineWidth', 3);
set(objs(ax),'Color', [1 1 1]);
axis square

hcb = colorbar;
set(hcb,'TickLabelInterpreter','latex')
ylabel(hcb, 'Fraction of averted simulations','Interpreter','latex')

ttl=title('non-spatial IBM','Interpreter','latex',...
    'FontSize',36);

set(gcf,'renderer','Painters');
print(gcf,['./output/fig2a'],'-dpdf','-r600')
disp('FIG. 2a was generated!')
%% Heatmaps for spatial results
D_str = fieldnames(dynClass_s.(fn{1}))';
for fn=fd'
    for Ds = D_str
        % coordinate on (S-P, R-T) space, normalized and shift
        % to avoid non-positive index
        cde = (dynClass_s.(fn{1}).(Ds{1}){1,1} + 6).*10;
        dynClass_s_M.(Ds{1})(cde(1),cde(2)) = 0;
        for rs = 1:length(dynClass_s.(fn{1}).(Ds{1}))
            tmpStr = dynClass_s.(fn{1}).(Ds{1}){rs,2};
            if isempty(strfind(tmpStr,'TOC'))
                dynClass_s_M.(Ds{1})(cde(1),cde(2)) =...
                    dynClass_s_M.(Ds{1})(cde(1),cde(2))+1;
            end
        end
    end
end


%%
plot_fn = {'fig2b','fig2c','fig2d'};
D_str = fieldnames(dynClass_s.(fn{1}))';
disp('Generating the figure: fraction of averted dynamics for spatial simulations...');
for Ds = D_str
    set(gcf,'visible','off');
    clf;
    disp(['Dn=',Ds{1}]);
    gcf_print_format(gcf, 'w', [8 7.7]);
    axes('Units', 'normalized','position',[0.16 0.15 0.78 0.78])
    imagesc(dynClass_s_M.(Ds{1})'./length(dynClass_s.(fn{1}).(Ds{1})))
    
    gca_format(gca, 1, 36, [40 80 40 80], [40:10:80], [40:10:80],...
        '$S_0 - P_0$', '$R_0 - T_0$')
    set(gca,'Xtick',[40:10:80])
    set(gca,'XtickLabel',cellstr(num2str([40:10:80]'./10-6))')
    set(gca,'Ytick',[40:10:80])
    set(gca,'YtickLabel',cellstr(num2str([40:10:80]'./10-6))')
    colormap(parula)
    caxis([0 1]); colorbar;
    colorbar('Ticks',[0:0.2:1],...
        'TickLabels',cellstr(num2str([0:0.2:1]'))',...
        'TickLabelInterpreter','latex')
    shading flat
    axis square
    axis xy
    
    % create boundaries
    maxX = 2.5; maxY = 2.5;theta = 2;
    
    A1 = [3, 0; 5, 1]; slope2 = (A1(2,1)-A1(1,1))/(A1(2,2)-A1(1,2));
    line(([0 0]+6).*10,([-maxY maxY]+6).*10); hold on;
    line(([-maxY maxY]+6).*10,([0 0]+6).*10); hold on;
    line(([0 maxX]+6).*10,[0 maxX].*10.*slope2+60); hold on;
    line(([-maxX maxX]+6).*10,[-maxX maxX].*10.*(-theta)+60);  hold on;
    
    objs = get(gca,'Children');
    ax = arrayfun(@(a) isa(a,'matlab.graphics.primitive.Line'),objs);
    set(objs(ax),'LineWidth', 3);
    set(objs(ax),'Color', [1 1 1]);
    axis square
    
    if ~strcmp(Ds{1},'DInf')
        d_title = strrep((Ds{1}),'d','.');
        d_title = strrep(d_title,'D','');
    else
        d_title = '$\infty$';
    end
    ttl=title(['$D_n$=',d_title],'Interpreter','latex',...
        'FontSize',40);
    
    idx = find(ismember(D_str,Ds{1}));
    set(gcf,'renderer','Painters');
    print(gcf,['./output/',plot_fn{idx}],'-dpdf','-r600');
    disp(['FIG. ',plot_fn{idx}(end-1:end),' was generated!']);
end