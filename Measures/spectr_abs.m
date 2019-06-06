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
function  mean_s = spectr_abs(STUDY,ALLEEG,ind_cond,ind_ses)

%Select datasets corresponding to the conditions and session
ind=STUDY.index;
ind(ind(:,7)~=ind_cond|ind(:,5)~=ind_ses,:)=[];

% test existence dataset
if isempty(ind)
    mean_s=NaN(size(ALLEEG(1).spectrum{1}));
    return
end

% convert the number of dataset in a double
ind = arrayfun(@(i) str2double(ind(i,1:3)),1:size(ind,1));

%Exclude dataset if their size or frequencies are different
for i = 1:numel(ind)
    k=ind(i);
    if prod(ALLEEG(1).spectrum{1, 2}==ALLEEG(k).spectrum{1, 2})==0,ind(i)=0;end
    if size(ALLEEG(1).spectrum{1},1)~=size(ALLEEG(k).spectrum{1},1),ind(i)=0;end
end
ind(ind==0)=[];

%Concatenation of the value
data=ALLEEG(ind(1)).spectrum{1,1};
for i = 2:numel(ind)
    k=ind(i);
    data(:,:,i)=ALLEEG(k).spectrum{1,1};
end

%Compute statistics
m=mean(data,3,'omitnan');

%output 
mean_s=m;

end

