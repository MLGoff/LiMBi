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
function dataout= nul_value(data,ibad)
if nargin~=2|ibad==0,dataout=data;return,end
v=NaN(1,size(data,2));
for i = ibad
    data=[data(1:i-1,:);v;data(i:end,:)];
end
dataout=data;
end

