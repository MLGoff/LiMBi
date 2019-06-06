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
function [n,ses] = n_measures(STUDY)

%number of dataset
n=numel(STUDY.datasetinfo);
%Creation of an array containing the numeros of sessions
ses=unique(arrayfun(@(i) str2double(STUDY.datasetinfo(i).session),1:n));
%number of session
ns=numel(ses);
%number of condition
nc=numel(STUDY.condition);
%number of pairing possible
n=nc*ns;
end

