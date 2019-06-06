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


function STUDYout = progress_spectra(STUDY,ALLEEG)

% number of pairing possible and numeros of sessions
[~,ses] = n_measures(STUDY);

nchan=ALLEEG(1).nbchan + numel(ALLEEG(1).badchannels);
k=1;

% pre allocation
freq=ALLEEG(1).spectrum{1, 2};
density=table("1","b",{ones(nchan,size(freq,2))},...
    'VariableNames',{'Session','cond','values'});

% compute mean
for s=ses
    ind_ses = num2str(s);
    for i =1:numel(STUDY.condition)
        ind_cond = STUDY.condition{i}(1);
        mean_s = spectr_abs(STUDY,ALLEEG,ind_cond,ind_ses);
        density(k,:)={string(ind_ses),string(ind_cond),mean_s};
        k=k+1;
    end
end

% field containing the stats and info relative
STUDY.spectrum.frequency = freq;
STUDY.spectrum.densities = density;

% output
STUDYout=STUDY;

end

