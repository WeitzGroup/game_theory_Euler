%% start with non-spatial IBM first, initialization
% load raw data for dynamics classification
clear; clc;
cd(fileparts(matlab.desktop.editor.getActiveFilename))
addpath(fullfile(pwd));
disp('loading raw data of non-spatial simulations for dynamics classification...')
load('./input/fig2/all_data_ns_scan.mat')
disp('data loaded')
%%
epsi = 0.01; L = 100;
N = L^2;
% collect all possible folder names into a list
fd = fieldnames(all_data_ns_scan);
cnt = 0;

% how much data at the beginning of the simulations are disgarded
% when calculated the average of x, n of the somewhat "equilibrium" states
burnIn_ratio = 0.8;

% loop over each folder
disp('classifying non-spatial dynamics...')
disp('       ')
for fn=fd'
    fprintf(repmat('\b',1,9));
    fprintf('%6.2f%% \n',(cnt/length(fd))*100);
    for rs = 1:length(all_data_ns_scan.(fn{1}).all)
        A0 = all_data_ns_scan.(fn{1}).para.A0;
        dynClass_ns.(fn{1}).all{rs,1} = [A0(1,2)-A0(2,2), A0(1,1)-A0(2,1)];
        
        tempDyn = all_data_ns_scan.(fn{1}).all{rs};
        sHor = length(tempDyn);    % simulation horizon
        
        devM_x = max_deviation(tempDyn(:,2));
        devM_n = max_deviation(tempDyn(:,3));
        devM = max(devM_x, devM_n);
        
        measuredDyn = tempDyn(max(ceil(sHor*burnIn_ratio),1):end,2:3);
        mean_x = mean(measuredDyn(:,1));
        mean_n = mean(measuredDyn(:,2));
        
        
        if devM > 1-2*epsi
            dynClass_ns.(fn{1}).all{rs,2} = 'o-TOC';
            dynClass_ns.(fn{1}).all{rs,3} = [NaN, NaN];
        else
            % approaching one of the corner (x,n)=(0,0)
            if mean_n < epsi
                dynClass_ns.(fn{1}).all{rs,2} = 'TOC';
                dynClass_ns.(fn{1}).all{rs,3} = [mean_x, mean_n];
            else
                dynClass_ns.(fn{1}).all{rs,2} = 'averted';
                dynClass_ns.(fn{1}).all{rs,3} = [mean_x, mean_n];
                
            end
        end
    end
    cnt = cnt+1;
end

save('./input/fig2/dynClass_ns.mat','dynClass_ns')
save('./input/fig2/dynClass_ns.mat','fd','-append')
fprintf(repmat('\b',1,9));
fprintf('%6.2f%% \n',100);
disp('finished!')

%% Then handle spatial IBMs, initialization
% load raw data for dynamics classification
clear; clc;
cd(fileparts(matlab.desktop.editor.getActiveFilename))
addpath(fullfile(pwd));
disp('loading raw data of spatial simulations for dynamics classification...')
load('./input/fig2/all_data_s_scan.mat')
disp('data loaded')
%%
epsi = 0.01; L = 100; D_str = {'D0d0','D1d0','DInf'};
N = L^2;
fd = fieldnames(all_data_s_scan);
burnIn_ratio = 0.8;
disp('classifying spatial dynamics...')
disp('       ')
cnt = 0;
for fn=fd'
    fprintf(repmat('\b',1,9));
    fprintf('%6.2f%% \n',(cnt/length(fd))*100);
    for Ds = D_str
        for rs = 1:length(all_data_s_scan.(fn{1}).(Ds{1}))
            A0 = all_data_s_scan.(fn{1}).para.A0;
            dynClass_s.(fn{1}).(Ds{1}){rs,1} = [A0(1,2)-A0(2,2), A0(1,1)-A0(2,1)];
            
            tempDyn = all_data_s_scan.(fn{1}).(Ds{1}){rs};
            sHor = length(tempDyn);    % simulation horizon
            
            devM_x = max_deviation(tempDyn(:,2));
            devM_n = max_deviation(tempDyn(:,3));
            devM = max(devM_x, devM_n);
            
            measuredDyn = tempDyn(max(ceil(sHor*burnIn_ratio),1):end,2:3);
            mean_x = mean(measuredDyn(:,1));
            mean_n = mean(measuredDyn(:,2));            
            
            if devM > 1-2*epsi
                dynClass_s.(fn{1}).(Ds{1}){rs,2} = 'o-TOC';
                dynClass_s.(fn{1}).(Ds{1}){rs,3} = [NaN, NaN];
            else
                
                % approaching one of the corner (x,n)=(0,0)
                if mean_n < epsi
                    dynClass_s.(fn{1}).(Ds{1}){rs,2} = 'TOC';
                    dynClass_s.(fn{1}).(Ds{1}){rs,3} = [mean_x, mean_n];
                else
                    dynClass_s.(fn{1}).(Ds{1}){rs,2} = 'averted';
                    dynClass_s.(fn{1}).(Ds{1}){rs,3} = [mean_x, mean_n];                    
                end
                
            end
        end
    end
    cnt = cnt+1;
end

save('./input/fig2/dynClass_s.mat','dynClass_s')
save('./input/fig2/dynClass_s.mat','fd','-append')

fprintf(repmat('\b',1,9));
fprintf('%6.2f%% \n',100);
disp('finished!')
