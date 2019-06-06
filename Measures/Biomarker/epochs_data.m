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
function epochs = epochs_data(EEG,length_ep,rec)

% Initialisation
data=EEG.data;
fs=EEG.srate;
tmax=EEG.xmax;
ne=floor(tmax/rec);
npnt=floor(length_ep*fs);

%Pre allocate the epochs
ep=zeros(EEG.nbchan,npnt,ne);

%Attribution values for each epochs
for i=1:ne
    
   ideb=floor((0+(i-1)*rec)*fs) + 1;
   ifin=ideb + length_ep*fs - 1;
   d=data(1:end,ideb:ifin);
   if sum(isnan(d),'all')<1,ep(:,:,i)=d;end   
   % Condition to avoid an end indice outside of the data
   if length_ep+i*rec>tmax,break, end   
end

% Supression of epoch out of bound
ep(:,:,i+1:end)=[];
iart=logical(sum(ep==0,[1,2]));
ep(:,:,iart)=[];
% Output
epochs=ep;
end

