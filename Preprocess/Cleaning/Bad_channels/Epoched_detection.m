%{
%    i_badchannel() -   Detect the EEG channels with a signal of bad
%                       quality using high statistics method on 1s-epochs.
%                       Channel with too many epochs artifacted are dubbed
%                       with a bad signal
% Usage :
%   >> i_badchannel = Epoched_detection(EEG)
% Inputs:
%   EEG             -  EEG continuous data structure (EEG.trials = 1)  
% Output : 
%   i_badchannel    -  The numeros of channels with a bad signals  
% Author : Marion Le Goff, 05/14/2019
%}

function i_badchannel = Epoched_detection(EEG)

%Convert continuous EEG into consecutive epochs of 1s
EEGe=eeg_regepochs(EEG,'recurrence',1,'limits',[0 1],'rmbase',NaN,'extractepochs','on');

%Compute the epochs above threshold artifacts with 3 methods
EEGe=pop_jointprob(EEGe,1,3:EEGe.nbchan,3,3,0,0);
EEGe=pop_rejkurt(EEGe,1,3:EEGe.nbchan,3,3,0,0);
EEGe=pop_eegthresh(EEGe,1,3:EEGe.nbchan,-100,100,EEGe.xmin,EEGe.xmax,0,0);

%Results global of epoched rejected x channel
rejglobE=EEGe.reject.rejjpE + EEGe.reject.rejkurtE + EEGe.reject.rejthreshE;
rejglobE(rejglobE>0)=1;

%Results global of epoched rejected x channel
rejglob=EEGe.reject.rejjp + EEGe.reject.rejkurt + EEGe.reject.rejthresh;
rejglob(rejglob>0)=1;

%number of artifacts
n_art_chan=sum(rejglobE,2);
n_ep_art=sum(rejglob);

%estimation if its a bad signals
bad_signals=n_art_chan>0.3*n_ep_art & n_art_chan>0.5*EEGe.trials;
%output
i_badchannel=find(bad_signals);
if not (isempty(i_badchannel))
    disp(["Channels numeros " i_badchannel' "are exluded from ICA analysis"])
end
end

