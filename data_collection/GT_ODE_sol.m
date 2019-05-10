function ode_dyn = GT_ODE_sol(x0, n0, fd)

para = para_set(0);

para.x0 = x0;
para.n0 = n0;
para.dyn0 = [para.x0, para.n0];

options = odeset('RelTol',2.22e-14);
[t,y] = ode45(@GT_ODE,[0:1:para.Tf].*para.dt,para.dyn0,options,para);

ode_dyn(:,1)=t;
ode_dyn(:,2)=y(:,1);
ode_dyn(:,3)=y(:,2);

function dydt = GT_ODE(t,y,para)

x = y(1);
n = y(2);

R0 = para.A0(1,1);  S0 = para.A0(1,2); T0 = para.A0(2,1); P0 = para.A0(2,2);
R1 = para.A1(1,1);  S1 = para.A1(1,2); T1 = para.A1(2,1); P1 = para.A1(2,2);
g = x*(n*((R1-T1)+(P1-S1)+(T0-R0)+(S0-P0))+(R0-T0)+(P0-S0))...
    +n*((S1-P1)+(P0-S0))+(S0-P0);

dot_x = x*(1-x)*g/(para.epsi);
dot_n = n*(1-n)*(para.theta*x - (1-x));

dydt = [dot_x; dot_n];

function A0 = A0_str2num(fn)
iR = strfind(fn,'R');
iS = strfind(fn,'S');
iT = strfind(fn,'T');
iP = strfind(fn,'P');
temp_str{1,1} = fn(iR+1:iS-1);
temp_str{1,2} = fn(iS+1:iT-1);
temp_str{2,1} = fn(iT+1:iP-1);
temp_str{2,2} = fn(iP+1:end);

A0_c = cellfun(@(x)str2num(strrep(x,'d','.')),temp_str,...
    'UniformOutput',0);
A0 = cell2mat(A0_c);
