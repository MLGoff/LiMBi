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

function EEGout = spectrum_set(EEG,fmin,fmax)

EEGi=EEG;
%Estimation power spectral
[px,fa]=pop_spectopo(EEGi, 1, [EEGi.xmin*1000 EEGi.xmax*1000], 'EEG','plot','off');

% ecuperation data in the proper frequency band
px(:,fa<fmin|fa>fmax)=[];
fa(fa<fmin|fa>fmax)=[];

%add null value for missing channel
px=nul_value(px,EEG.badchannels);

%Add field
EEG.spectrum={px,fa};
%output
EEGout=eeg_checkset(EEG);
end

