%{
%() - 
%Usage :
%   >> EEGout = Marker_set(EEG,freqs,length_epoch,overlap)
%Inputs:
%   EEG
%   freqs
%   length_epoch
% Output : 
%    
%Author : Marion Le Goff, 05/14/2019
%}

function EEGout = Marker_set(EEG,freqs,length_epoch,interval)

%Filter the dataset between the two frequency of freqs
EEGe= pop_eegfiltnew(EEG, freqs);

%add NaN for artifacted values
EEGe=NaNvalue(EEGe);

% Divide the dataset in epochs of length_epoch second and shift from
% interval second
data1=epochs_data(EEGe,length_epoch,interval);

%Estimate the energy
marker = nrjdata(data1,1);
marker = reshape(marker,EEG.nbchan,[]);

%add null value for missing channel
marker=nul_value(marker,EEG.badchannels);

%info on the calcul
info={'',"FreqBand",{freqs(1)},{freqs(2)},length_epoch,interval};

%creation of the field EEG.markers if not existing
try ind=size(EEG.markers,1)+1;
catch
    ind = 1;
    EEG.markers=table({eye(2)},"2",{3},{4},5,6,'VariableNames',...
        {'Value','Type','Freq1','Freq2','LengthEpoch','Reccurence'});
end

%field containing the energy and info relative
info{1}=marker;
EEG.markers(ind,:)=info;

%output
EEG=eeg_checkset(EEG);
EEGout=EEG;
end

