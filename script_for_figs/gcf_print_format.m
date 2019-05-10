% Function to format the layout of a figure window
% handle: the graph handle, e.g., handle
% bgColor: backgroud color of the window, usually 'w' for white
% sz: a 2-element vector specified the size of the paper in inches
%      [width, height]

function gcf_print_format(handle, bgColor, sz)
set(handle,'color', bgColor)
set(handle,'PaperUnits','inches')
set(handle,'PaperType','<custom>')
set(handle,'PaperPosition',[0 0, sz])
set(handle,'PaperSize',sz)
end