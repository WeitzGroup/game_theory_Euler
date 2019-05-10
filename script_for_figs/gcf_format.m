% Function to format the layout of a figure window
% handle: the graph handle, e.g., gcf
% bgColor: backgroud color of the window, usually 'w' for white
% pos: a row vector specified the location and position of the window
%      [distance to left, distance to bottom, width, height]

function gcf_format(handle, bgColor, pos)
    set(handle,'color', bgColor)
    set(handle,'position',pos)
    set(handle, 'PaperPositionMode', 'auto')
    set(0,'defaultTextInterpreter','latex')
end
