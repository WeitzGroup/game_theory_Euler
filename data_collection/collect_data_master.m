% reset the environment
clear all; clc;
restoredefaultpath

% goes to the folder the current script is in
% and add this path into searching path for future use
cd(fileparts(matlab.desktop.editor.getActiveFilename))
addpath(fullfile(pwd));

% collect the name of folders containing data
% record the name of folders under the parent folder
parent_fd = fullfile(pwd, '..');
all_dir = dir(parent_fd);

% pick the folders of interest, whose names starting with A0_
cnt = 1;
for ii=3:length(all_dir)
    if strcmp(all_dir(ii).name(1:3),'A0_')
        fNum = numel(dir(['../',all_dir(ii).name,'/outfile/dyn*.dat']));
        fd{cnt} = all_dir(ii).name;
        cnt = cnt+1;
    end
end
clearvars -except parent_fd fd

%%
% goes into each folder and collect data
for ii=1:length(fd)
    
    cd(['../',fd{ii}])
    cnt = 1;    % counter for index
    x0 = [0.3, 0.5, 0.7];
    n0 = [0.3, 0.5, 0.7];
    
    for x = x0
        for n = n0
            all_data_ns.(fd{ii}).para = para_set(0);
            
            ic_str = ['x',num2str(x),'n',num2str(n)]; % string for idenfitication
            all_data_ns.(fd{ii}).ODE{cnt,1} = ic_str;
            all_data_ns.(fd{ii}).IBM{cnt,1} = ic_str;
            all_data_ns.(fd{ii}).avg{cnt,1} = ic_str;
            
            all_data_ns.(fd{ii}).ODE{cnt,2} = GT_ODE_sol(x,n,fd{ii});
            
            for rs=1:100
                all_data_ns.(fd{ii}).IBM{cnt,1+rs}=...
                    collect_data_all(x,n,rs,0,0);
            end
            all_data_ns.(fd{ii}).avg{cnt,2} =...
                mean(cat(3,all_data_ns.(fd{ii}).IBM{cnt,2:101}),3);
            
            cnt = cnt + 1;
        end
    end
end

save([parent_fd,'/all_data_ns.mat'],'all_data_ns');
