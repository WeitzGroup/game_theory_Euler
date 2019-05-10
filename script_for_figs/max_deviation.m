%% a function to find max deviation between contiguous local extremums

function devM = max_deviation(t_series)
[pM,pMInd] = findpeaks(t_series,'MinPeakProminence',5e-2);
[pm,pmInd] = findpeaks(-t_series,'MinPeakProminence',5e-2);
pm = -pm;

% if no local extremal is found, max deviation = 0
if isempty(pM) && isempty(pm)
    devM = 0;
    
% due to demographic noise presented in the system
% it is possible function 'findpeaks' identifies more than one min.(max.)
% between two max.(min.) points
% if this happens, pick the min. / max. values
% to represent the multiple min.(max.) values between two max.(min.) points

% if only local min./max. are found, 
% max deviation = min./max. of the time series - local extremums
elseif isempty(pM) && ~isempty(pm)
    devM = abs(max(t_series) - min(pm));
elseif isempty(pm) && ~isempty(pM)
	devM = abs(min(t_series) - max(pM));
else
    % also consider possible plateaus on both ends
    % 'findpeaks' does not peak the start of a plateau, so need to manually
    % check if there is a plateau outside the range with values larger(smaller)
    % than neighboring max.(min.) 
    if max(t_series(1:pmInd(1)-1)) > pM(1)
        val = max(t_series(1:pmInd(1)-1));
        ind = find(t_series==val); ind = ind(end);
        if ind < pM(1)
            pMInd = [ind; pMInd];
            pM = [val; pM];
        end
    end
    if max(t_series(pmInd(end)+1:end)) > pM(end)
        val = max(t_series(pmInd(end)+1:end));
        ind = find(t_series==val); ind = ind(1);
        if ind > pM(end)
            pMInd = [pMInd; ind];
            pM = [pM; val];
        end
    end
    if min(t_series(1:pMInd(1)-1)) < pm(1)
        val = min(t_series(1:pMInd(1)-1));
        ind = find(t_series==val); ind = ind(end);
        if ind < pm(1)
            pmInd = [ind; pmInd];
            pm = [val; pm];
        end
    end
    if min(t_series(pMInd(end)+1:end)) < pm(end)
        val = min(t_series(pMInd(end)+1:end));
        ind = find(t_series==val); ind = ind(1);
        if ind > pm(end)
            pmInd = [pmInd; ind];
            pm = [pm; val];
        end
    end

    % collect values of local extremums,
    % give them a lable +1 for local Max. and -1 for local Min.
    Max = [pMInd, pM, ones(size(pM))];
    Min = [pmInd, pm, -ones(size(pm))];
    
    % sort all the local extremume according to the index (time step)
    inlay = [Max; Min];
    [~, order] = sort(inlay(:,1));
    inlay = inlay(order,:);
    
    % If the difference of the labels (+1 for max. and -1 for min.)
    % between two neighoring rows are not 0, they are different groups
    diff_label = [true; diff(inlay(:,3))~=0];
    
    % identify each group
    groupStart = find(diff_label);
    
    % identify the feature of each group
    % + for max. values and - for min. values
    diff_label=diff_label.*inlay(:,3);
    
    % a new container to store the calculated results
    % the 'new' matrix will have alternating max. and min. values
    new = [];
    for i=1:length(groupStart)-1
        gStart=groupStart(i);
        gEnd=groupStart(i+1)-1;
        
        % if elements belong to max. groups, pick the max value to represent
        if diff_label(gStart)>0
            new = [new; max(inlay(gStart:gEnd,2))];
        % if elements belong to min. groups, pick the min value to represent
        else
            new = [new; min(inlay(gStart:gEnd,2))];
        end
    end
    
    % also need to deal with the last group
    gStart=groupStart(end);
    gEnd=size(inlay,1);
    if diff_label(gStart)>0
        new = [new; max(inlay(gStart:gEnd,2))];
    else
        new = [new; min(inlay(gStart:gEnd,2))];
    end

    % find the maximum deviation by calculating difference of neighboring
    % elements 
    if mod(length(new),2) == 0
        devM = max(abs(new(1:2:end) - new(2:2:end)));
        
        % if there are odd number of local extremums
        % calculate the difference of both directions to find the maximum deviation
    else
        dev1 = max(abs(new(1:2:end-1) - new(2:2:end)));
        dev2 = max(abs(new(2:2:end) - new(3:2:end)));
        devM = max(dev1,dev2);
    end
end
end