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
function STUDYout = std_index(STUDY)

nd=numel(STUDY.datasetinfo);
index=arrayfun(@(i) [sprintf('%03d',i) ' ' STUDY.datasetinfo(i).session...
    ' ' STUDY.datasetinfo(i).condition(1)],1:nd,'UniformOutput',false)';
index=char(index);
STUDY.index=index;
STUDYout=std_checkset(STUDY);


end

