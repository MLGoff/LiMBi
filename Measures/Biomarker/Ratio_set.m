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

function EEGout = Ratio_set(EEG,freqs1,freqs2,length_epoch,interval,logratio)

%Filter the dataset between two frequencies
EEG1= pop_eegfiltnew(EEG, freqs1);

EEG2= pop_eegfiltnew(EEG, freqs2);

%Add NaN value where was the artifacted
EEG1=NaNvalue(EEG1);

EEG2=NaNvalue(EEG2);


% Divide the dataset in epochs of length_epoch second and shift from
% interval second
data1=epochs_data(EEG1,length_epoch,interval);

data2=epochs_data(EEG2,length_epoch,interval);

%Estimate the energy
f1 = nrjdata(data1,logratio);
f1 = reshape(f1,EEG1.nbchan,[]);

f2 = nrjdata(data2,logratio);
f2 = reshape(f2,EEG2.nbchan,[]);

%Estimate the ratio
if logratio,ratio=f1./f2;else, ratio = log(1+f1./f2);end

%add null value for missing channel
ratio=nul_value(ratio,EEG.badchannels);

%info on the calcul
info={'',"Ratio",{freqs1},{freqs2},length_epoch,interval};

%creation of the field EEG.markers if not existing
try ind=size(EEG.markers,1)+1;
catch
    ind = 1;
    EEG.markers=table({eye(2)},"2",{3},{4},5,6,'VariableNames',...
        {'Value','Type','Freq1','Freq2','LengthEpoch','Reccurence'});
end

%field containing the energy and info relative
info{1}=ratio;
EEG.markers(ind,:)=info;


%output
EEG=eeg_checkset(EEG);
EEGout=EEG;
end

