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

function STUDYout = percent_bs(STUDY,ind_base,ind_mark)

%List of session
[~,ses] = n_measures(STUDY);
ns=length(ses);

%Initialisation 
ind_base=string(ind_base);
data=STUDY.stats_marker.stats{ind_mark};
ncond=numel(STUDY.condition);
base=cell(1,1,ns);
data_ses=cell(1,ncond-1,ns);
std_ses=cell(1,ncond-1,ns);
k=1;

%Compute the percentage of baseline
for s=ses
    ind_ses=string(s);
    base(k)=data.mean(data.Session==ind_ses & data.cond==ind_base);
    data_ses(:,:,k)=data.mean(data.Session==ind_ses & data.cond~=ind_base)';
    std_ses(:,:,k)=data.std(data.Session==ind_ses & data.cond~=ind_base)';
    k=k+1;
end

%delete empty cell
i_empty=[];
for i=1:ns,if isempty(base{:,:,i}),i_empty=[i_empty i];end,end
base(:,:,i_empty)=[];
data_ses(:,:,i_empty)=[];
std_ses(:,:,i_empty)=[];

%Conversion in array
base=cell2mat(base);
data_ses=cell2mat(data_ses);
std_ses=cell2mat(std_ses);
%calcul
y=(data_ses./base-1)*100;
%elimination of absurd value
y(y==Inf | y==0)=NaN;
std_ses(y==Inf | y==0)=NaN;


%field creation
STUDY.Normalized.ViaBaseline=table(y,std_ses,'VariableNames',{'Mean','STD'});
STUDY.Normalized.leg_act=reshape(join([data.Session(data.cond~=ind_base) ...
    data.cond(data.cond~=ind_base)]),ncond-1,ns);

%Output
STUDYout=std_checkset(STUDY);
end

