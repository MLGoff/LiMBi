%{
% () - 
% Usage :
%   >> 
% Inputs:
%    
% Output : 
%    
% Author : Marion Le Goff, 05/14/2019
%}

function STUDYout = absolute_progress(STUDY,ALLEEG,ind_mark)

% number of pairing possible and numeros of sessions
[n,ses] = n_measures(STUDY);

% pre allocation
stat_marker=cell(n,2);
info=cell(n,2);
k=1;

% compute mean
for s=ses
    ind_ses = num2str(s);
    for i =1:numel(STUDY.condition)
        ind_cond = STUDY.condition{i}(1);
        [mean_m,std_m] = stats_abs(STUDY,ALLEEG,ind_cond,ind_ses,ind_mark);
        stat_marker{k,1}=mean_m;
        stat_marker{k,2}=std_m;
        info{k,1}=ind_ses;
        info{k,2}=ind_cond;
        k=k+1;
    end
end

% creation of the field STUDY.stats_marker if not existing
try 
    ind=size(STUDY.stats_marker,1)+1;
    STUDY.stats_marker(ind,1:5)=ALLEEG(1).markers(ind_mark,2:end);
catch
    ind = 1;
    STUDY.stats_marker=ALLEEG(1).markers(ind_mark,2:end);
end

% field containing the stats and info relative
info=string(info);
tab=table(info(:,1),info(:,2),stat_marker(:,1),stat_marker(:,2),...
    'VariableNames',{'Session','cond','mean','std'});
 STUDY.stats_marker.stats(ind)={tab};
% output
STUDY=std_checkset(STUDY);
STUDYout=STUDY;
end

