% This is a funciton to plot an quiver on the phase space at a specific
% location [x, n]
% para: parameter set for the dynamics system
%       if want to plot the arrows based on simulation dynamics, put the dynamics
%       sereis in this position
% sz: size of the arrow head, preferably ~= 20
% offset: move the arrow to a better position [offset_x, offset_n]


function quiver_xn_plot(x,n,para,sz,offset)
if isa(para,'struct')
    R0 = para.A0(1,1);  S0 = para.A0(1,2); T0 = para.A0(2,1); P0 = para.A0(2,2);
    R1 = para.A1(1,1);  S1 = para.A1(1,2); T1 = para.A1(2,1); P1 = para.A1(2,2);
    g = x*(n*((R1-T1)+(P1-S1)+(T0-R0)+(S0-P0))+(R0-T0)+(P0-S0))...
        +n*((S1-P1)+(P0-S0))+(S0-P0);
    
    vx = x*(1-x)*g/(para.epsi);
    vn = n*(1-n)*(para.theta*x - (1-x));
else
    % finite difference to approximate the differential at a given location
    [~,x_ind] = min(abs(para(:,2)-x));
    [~,v_ind] = min(abs(para(:,3)-n));
    vx = para(x_ind+1,2)-para(x_ind,2);
    vn = para(v_ind+1,3)-para(v_ind,3);
end


ah=annotation('arrow','position',...
    [x+vx*sz/30+offset(1) n+vn*sz/30+offset(2) vx*0.03 vn*0.03],...
    'LineStyle','none',...
    'headStyle','plain','HeadLength',sz,'HeadWidth',sz);
set(ah,'parent',gca);
end
