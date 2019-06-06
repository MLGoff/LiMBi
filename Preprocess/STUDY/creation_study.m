%{
% creation_study() - 
%Usage :
%   >>  [STUDY, ALLEEG]= creation_study(set_session,STUDY,ALLEEG); 
%Inputs:
%   set_session         - Variable containing all the datasets to include
%   STUDY               - EEGLAB STUDY structure, can be empty
%   ALLEEG              - EEGLAB ALLEEG structure, can be empty
% Output : 
%   STUDY               - new EEGLAB STUDY structure containing relevant info
%   ALLEEG              - EEGLAB EEG structure with multi elements corresponding to the input datasets   
%Author : Marion Le Goff, 05/14/2019
%}
function [STUDY, ALLEEG]= creation_study(set_session,STUDY,ALLEEG);

% param to save the study
[name_study,file_name,sav_fold]=param_study(set_session);

%creation of the instructions for all the set
com=Command_creation(set_session);

%Creation of a study file
[STUDY, ALLEEG] = std_editset( STUDY, ALLEEG, 'name',name_study,...
            'commands',com,'updatedat','off','rmclust','on','filename',...
            file_name ,'filepath',sav_fold);
        
%No output if not mentionned       
if nargout<1
    return
end
end

