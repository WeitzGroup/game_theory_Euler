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
        'TickLabels',cellstr(num2str(cBarTick'))',...
        'TickLabelInterpreter','latex')
end

shading flat
axis tight
axis equal
axis xy
end
