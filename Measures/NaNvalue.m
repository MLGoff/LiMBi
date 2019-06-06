

function EEGout = NaNvalue(EEG)

data=EEG.data;
ind=EEG.artifactedPnts;
for c=1:numel(ind)
    v=NaN(EEG.nbchan,numel(ind{c}));
    ideb=ind{c}(1);
    data=[data(:,1:ideb-1) v data(:,ideb:end)];
end
EEG.data=data;
EEG.pnts=size(data,2);
EEG.xmin=0;
EEGout=eeg_checkset(EEG);
end

