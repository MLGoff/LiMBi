%{
%import_data_via_biosig() - Take a file to a format .gdf and import it as a
%                           part of the workspace as a variable EEG usable
%                           by EEGlab and containing relevant informations 
%                           concerning the dataset.
% Usage :
%   >>  EEG = import_data_via_biosig(file_data)
% Inputs:
%   file_data       -   the complete adress of the file to import    
% Output : 
%   EEG             -   EEG structure documented and usable with EEGlab    
% Author : Marion Le Goff, 05/14/2019
%}

function EEG = import_data_via_biosig(file_data)

%Check if eeglab is installed
if exist('pop_chanedit')==0
    error('Launch eeglab before using this function',class(''))
elseif exist('pop_biosig') == 0
    error('Biosig is not installed as an eeglab plugin, please installed it',class(''))
end

%import files using biosig
EEGi=pop_biosig(file_data , 'channels',1:16);

%cut the part out of the experiment
EEGi=active_part(EEGi);

%Fill electrode localisation
fichier=dir([pwd '\**\localisation\standard-10-5-cap385.elp']);
localisation=[fichier(1).folder '\' fichier(1).name];
EEGi=pop_chanedit(EEGi, 'lookup',localisation);

%Complete informations on the set 
[EEGi.subject,EEGi.session,EEGi.condition,EEGi.bloc]=extract_info_trial(file_data);

%Define set name :
EEGi.setname = char(join([EEGi.subject,EEGi.session,EEGi.bloc],"_"));

%Create fields related to cleaning 
EEGi.badcomps=0;
EEGi.badchannels=0;

%Check if the set is consistent with an EEG structure
EEGi=eeg_checkset(EEGi);

%output
EEG=EEGi;

end

