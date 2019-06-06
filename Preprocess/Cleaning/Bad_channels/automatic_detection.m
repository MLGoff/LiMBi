%{
%automatic_detection() - Detect the EEG channels with a signal of bad
%                        quality using its kurtosis and joint probability.
%                        The threshold used is a z-score of 2.58
%Usage :
%   >> indices = automatic_detection(EEG)
%Inputs:
%   EEG             -  EEG data structure continuous or discrete     
% Output : 
%   indices         -  The numeros of channels with a bad signals     
%Author : Marion Le Goff, 05/14/2019
%}


function indices = automatic_detection(EEG)
%Measures of kurtosis and probability for all channel except FP1 and 2.
[~,indicek]=pop_rejchan(EEG,'elec',[3:16],'measure','kurt','norm','on','threshold',[-2.58 2.58]);
[~,indicep]=pop_rejchan(EEG,'elec',[3:16],'measure','prob','norm','on','threshold',[-2.58 2.58]);
%Creation of the vector indices
indices=(unique([indicek indicep]));
end

