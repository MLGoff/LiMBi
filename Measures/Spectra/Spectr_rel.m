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

function STUDYout = Spectr_rel(STUDY,ind_base)

%List of session
[~,ses] = n_measures(STUDY);
ns=length(ses);

%Initialisation
data=STUDY.spectrum.densities;
freq=STUDY.spectrum.frequency;
ind_base=string(ind_base);
ncond=numel(STUDY.condition);


%Reorganize data per condition
d=unstack(data,'values','cond');
d.Properties.VariableNames{ind_base}='Baseline';
varnames = d.Properties.VariableNames;
others = ~strcmp('Baseline',varnames);
d=d(:,[varnames(others) 'Baseline']);

nchan=size(d.Baseline{1},1);
nf=size(freq,2);

%Creation array with all value
dens=zeros(nchan,nf,ns,ncond-1);
base=zeros(nchan,nf,ns);
for s=ses
    for c=1:ncond-1, dens(:,:,s,c)=cell2mat(d{s,c+1});end
    base(:,:,s)=d.Baseline{s};
end

%Variation from baseline
y=(dens./base-1)*100;

%Initialisation table
densNorm=table("1","b",{ones(nchan,size(freq,2))},...
    'VariableNames',{'Session','cond','values'});
k=1;
icond = d.Properties.VariableNames(2:end-1);
%Completing table;
for s=ses
    for c=1:ncond-1
        densNorm(k,:)={string(s) string(icond{c}) y(:,:,s,c)};
        k=k+1;
    end
end

%Add field
STUDY.spectrum.norm=densNorm;
%Output
STUDYout=std_checkset(STUDY);
end

