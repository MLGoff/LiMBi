

function [EEGout,nrej] = artifactEpochs(EEG,ALLEEG,CURRENTSET)

% compArt=unique(EEG.badcomps);
% EEG = pop_subcomp( EEG, compArt,0);
% [~,EEG,~] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',ALLEEG(1).setname,'overwrite','on','gui','off'); 

time=EEG.times; 

%Convert continuous EEG into consecutive epochs of 1s
EEGe=eeg_regepochs(EEG,'recurrence',1,'limits',[0 1],'rmbase',NaN,'extractepochs','on');
%initialisation
indicePnts=reshape(1:EEGe.pnts*EEGe.trials,EEGe.pnts,EEGe.trials);
time=time(1:EEGe.pnts*EEGe.trials);
data=EEGe.data;

%Compute the epochs above threshold artifacts with 3 methods
% EEGe=pop_jointprob(EEGe,1,3:EEGe.nbchan,3,3,0,0);
% EEGe=pop_rejkurt(EEGe,1,3:EEGe.nbchan,3,3,0,0);
EEGe=pop_eegthresh(EEGe,1,3:EEGe.nbchan,-100,100,EEGe.xmin,EEGe.xmax,0,0);

%Results global of epoched rejected
% rejglob=EEGe.reject.rejjp + EEGe.reject.rejkurt + EEGe.reject.rejthresh;
rejglob=EEGe.reject.rejthresh;
% rejglob(rejglob>0)=1;
nrej=sum(rejglob)/numel(rejglob)*100;
rejglob=logical(rejglob);

%supress artifacted value
data(:,:,rejglob)=[];
indicePnts(:,not(rejglob))=[];            %Indice to the artifacted point


%reshape as continuous data
data=reshape(data,EEG.nbchan,[],1);
indicePnts=reshape(indicePnts,1,[]);
time(indicePnts)=[];

%change element in EEG structure
EEG.data=data;
EEG.times=time;
EEG.pnts=numel(time);
EEG.xmax=max(time)/1000;
EEG.xmin=min(time)/1000;

%Create a cell array with the consecutive point artifacted
k=1;artifactedPnts={};inon=1;
 while not(isempty(indicePnts)) 
    a=indicePnts(1);
    inon=find(arrayfun(@(x) indicePnts(x)~=a+x-1,1:numel(indicePnts)),1);      %find the first value non consecutive
    if isempty(inon),inon=numel(indicePnts)+1;end
    artifactedPnts{k}=indicePnts(1:inon-1);
    k=k+1;
    indicePnts(1:inon-1)=[];
 end
 
EEG.artifactedPnts=artifactedPnts(1:end);

%output
EEGout=eeg_checkset(EEG);
end



