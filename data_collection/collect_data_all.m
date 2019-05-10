% spa = 0, non-spatial simulations
% spa = 1, spatial simulations

function dyn_temp = collect_data_all(x0,n0,rs,spa,D)
if spa
    if D<10
        fn_in = ['outfile/dyn_D',sprintf('%.1f',D),'_x',num2str(x0),'_n',num2str(n0),'_rs',...
            num2str(rs),'_s.dat'];
    else
        fn_in = ['outfile/dyn_DInf_x',num2str(x0),'_n',num2str(n0),'_rs',...
            num2str(rs),'_s.dat'];
    end
else
    fn_in = ['outfile/dyn_x',num2str(x0),'_n',num2str(n0),'_rs',...
        num2str(rs),'_ns.dat'];
end

dyn_temp = load(fn_in);

end