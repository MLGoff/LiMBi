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
function [mean_m,std_m] = stats_abs(STUDY,ALLEEG,ind_cond,ind_ses,ind_mark)

%Select datasets corresponding to the conditions and session
ind=STUDY.index;
ind(ind(:,7)~=ind_cond|ind(:,5)~=ind_ses,:)=[];

% convert the number of dataset in a double
ind = arrayfun(@(i) str2double(ind(i,1:3)),1:size(ind,1));

%Concatenation of the value
data=[];
for i = ind
    data=[data ALLEEG(i).markers.Value{ind_mark}];
end

%Compute statistics
m=mean(data,2,'omitnan');
s=std(data,0,2,'omitnan');

%output 
mean_m=m;
std_m=s;

end

