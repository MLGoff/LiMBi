%{
% list_studies()  - Compute a list of path of folder containing the datasets
%                   parting from a gobal repertory and extracting either
%                   subject folder or sessions one
%Usage :
%   >> list_studies = list_folder_study(repertory,type) 
% Inputs:
%   repertory     - folder containing the datasets of the experiment              
%   type          - [0|1] type of studies to build, 0 for subject and 1
%                   for sessions
% Output : 
%   list_studies  -    
%Author : Marion Le Goff, 05/14/2019
%}

function list_studies = list_folder_study(repertory,type)

% list the content of the repertory
list_content = dir([repertory '\**\']);
nc=numel(list_content);

% select the folders
indn=arrayfun(@(i) string(list_content(i).name)=="."||...
    string(list_content(i).name)==".."||list_content(i).isdir==0,1:nc);
list_content(indn)=[];
nf=numel(list_content);

% Select either the global folder of the subject or all the session folder
% for all subject
indf=find(arrayfun(@(i) prod(ismember('session',list_content(i).name)==type),1:nf));

% Creation of the list of the absolute path for each folder
adresses=arrayfun(@(i) string([list_content(i).folder '\' list_content(i).name '\']),indf);

% Output
list_studies=adresses';

end

