% Function to format the layout of a graph
% handle: the graph handle, e.g., gca
% LineW: line width of the plot
% axRange: axis range [lower bound, upper bound]
% xtick, ytick: axis lable ticks, should be a ROW vecor
% xlb, ylb: axis lables, should be a string

function gca_format(handle, LineW, fontS, axRange, xtick, ytick, xlb, ylb)

% set figure properties
axis(axRange)
set(handle,'Xtick',xtick)
set(handle,'XtickLabel',cellstr(num2str(xtick'))')
set(handle,'Ytick',ytick)
set(handle,'YtickLabel',cellstr(num2str(ytick'))')
set(handle,'FontSize',fontS)
xlabel(handle,xlb,'Interpreter','latex')
ylabel(handle,ylb,'Interpreter','latex')
set(handle,'TickLabelInterpreter','latex')

% find objects in the current axes for further operation
obj = get(handle,'Children');

% if find lines, change the default line width accordingly
% if LineW <= 0, keep the original object features and do not override
if LineW > 0
    line_obj = arrayfun(@(a) isa(a,'matlab.graphics.chart.primitive.Line'),obj);
    set(obj(line_obj),'LineWidth', LineW);
end
    
% if it's an imagesc plot, shift coordinate label accordingly
if ~isempty(findobj(handle,'Type','Image'))
    axis(axRange+0.5)
    set(handle,'Xtick',xtick+0.5)
    set(handle,'XtickLabel',cellstr(num2str(xtick'))')
    set(handle,'Ytick',ytick+0.5)
    set(handle,'YtickLabel',cellstr(num2str(ytick'))')
end
set(gca,'TickLabelInterpreter','latex');
end
