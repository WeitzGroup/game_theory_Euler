function spatial_figure(M_struct, dyn, D, L, cbar)
M_temp = M_struct.value;
if D <=10
    imagesc(M_temp(:,:,2));
else
    imagesc(dyn(M_struct.step+1,3).*ones(L));    
end
hold on;
[nz_r, nz_c, ~] = find(M_temp(:,:,1));
plot(nz_c, nz_r, 's','Color',[1 .2 .2],'MarkerSize',4)
gca_format(gca, 1, 24, [0 L 0 L], [0:L/2:L], [0:L/2:L],...
    'x $(\Delta x)$', 'y $(\Delta x)$')

set(gca,'YTickLabel',{'', num2str(L/2), num2str(L)})
set(gca,'TickLength',[0 0])
g_cmp = gray;
hMap_format(gca, [0 1], flipud(g_cmp(1:50,:)), cbar, '')
end


% Function to format the layout of a heat map,
% e.g., spatial distribution of cooperators / environments
% handle: the graph handle, e.g., gca
% cAxis: range of the color axis [lower bound, upper bound]
% cmap: colormap of the heat map
% cbar: 1 for showing the colorbar, 0 otherwise
% cBarTtick: axis lable ticks, should be a ROW vecor

function hMap_format(handle,  cAxis, cmap, cbar, cBarTick)
caxis(cAxis)

% setting 0 value to be white
% find the ratio where the 0 is
ratio0 = (0-cAxis(1))/(cAxis(2)-cAxis(1));

% find the index of color axis according to the ratio found
% max(x, 1) ensures the index to be positive
pos0 = max(round(ratio0*size(cmap, 1)), 1);

% apply change the color around 0 value to be whie [1 1 1]
cmap(pos0,:) = [1 1 1];

% re-apply colormap
colormap(handle, cmap);

if cbar == 1
    colorbar
    colorbar('Ticks',cBarTick,...
        'TickLabels',cellstr(num2str(cBarTick'))')
end

shading flat
axis tight
axis equal
axis xy
end
