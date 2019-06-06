%{
% active_part() - Cut the EEG data to excluded part out of training, based
%                 on the event start experimment 32775 and the length of
%                 the experiment (120s or 300s)
% Usage :
%   >>      EEGout = active_part(EEG)
% Inputs:
%   EEG             -   EEG continuous data structure (EEG.trials = 1)    
% Output : 
%   EEGout          -   Input EEG minimus the part out of the session 
%Author : Marion Le Goff, 05/14/2019
%}

function EEGout = active_part(EEG)

tab=struct2table(EEG.urevent);
if ismember(32775,tab.type)     %Check if the event 32775 exists, as it indicates the start of the recording
    if EEG.times(end)>=300000
        EEG = pop_rmdat( EEG, {'32775'},[0 300] ,0);
    else
        EEG = pop_rmdat( EEG, {'32775'},[0 120] ,0);
    end
else
    if EEG.times(end)>=300000
        EEG = pop_select( EEG, 'time',[0 300]);
    else
        EEG = pop_select( EEG, 'time',[0 120]);
    end
end
EEGout=EEG;
end

