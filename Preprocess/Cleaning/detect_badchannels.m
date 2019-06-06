%{
%detect_badchannels() - Detect channel with signals of bad quality and
%                       notes their indices
%Usage :
%   >>  EEGout = detect_badchannels(EEG)
%Inputs:
%   EEG             -   EEG continuous data structure (EEG.trials = 1)     
% Output : 
%   EEGout          -   input EEG with the added fields EEG.badchannels & EEG.origindata 
%Author : Marion Le Goff, 05/14/2019
%}

function EEGout = detect_badchannels(EEG)
%determination indice channel with bad signals
i_gl=automatic_detection(EEG);
i_gl=reshape(i_gl,1,[]);

i_ep=Epoched_detection(EEG);
i_ep=reshape(i_ep,1,[]);

i_bad=unique([i_gl i_ep]);

%stock indices in the structure EEG
EEG.badchannels=i_bad;

%Stock old data
EEG.origindata=EEG.data;

%Stock data pruned 
EEG=pop_select(EEG,'nochannel',i_bad);

%Check if the set is consistent with an EEG structure
EEG=eeg_checkset(EEG);

%output
EEGout=EEG;
end

