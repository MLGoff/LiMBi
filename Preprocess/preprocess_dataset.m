%{
%preprocess_dataset() -   Transform a file of EEG data in a EEGLAB EEG
%                         structure containing the data, the relevant
%                         information and a decomposition in ICA that is
%                         saved as a .set file
% Usage :
%   >> EEG=preprocess_dataset(file,save_fold)
%   >> preprocess_dataset(file)
% Inputs:
%   file              -   file containing the protocol data in a .gdf format
%   save_fold         -   location (existing or not) where to save the pre process data  
% Output : 
%   EEG               -   (optional) EEGLAB EEG structure
% Author : Marion Le Goff, 05/14/2019
%}


function EEG=preprocess_dataset(file,save_fold)

%import file
EEG=import_data_via_biosig(char(file));

%analize quality signals
EEG=detect_badchannels(EEG);

% Decomposition in ICA
% EEG=pop_runica(EEG,'icatype','runica');
% EEG=eeg_checkset(EEG);

%sauvegarde fichier
if nargin==1
    save_fold=join([pwd '\datasets3\' EEG.subject '\' EEG.session],'');
end
if exist(save_fold,'dir')==7
    EEG=pop_saveset(EEG,'filename',EEG.setname,'filepath',char(save_fold),'savemode','twofiles');
else
    mkdir(save_fold)
    EEG=pop_saveset(EEG,'filename',EEG.setname,'filepath',char(save_fold),'savemode','twofiles');
end

% if use just to process a file, no output
if nargout == 0
    EEG=['dataset : ' char(EEG.setname) ' has been created and saved'];
    disp(EEG)
end
end

