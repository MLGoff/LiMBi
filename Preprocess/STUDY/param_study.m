%{
%param_study() - extract the general information needed to create a study file
%Usage :
%   >> [study_name,study_file,study_path] = param_study(set_session)
%Inputs:
%   set_session         - variable containing the files soon to be include 
%                         in a study, either as a repertory or list of
%                         adresses       
% Output : 
%   study_name          - name of the study to build
%   study_file          - name of the file .study containing the structure
%   study_path          - path of the repertory where to save the study file 
% Author : Marion Le Goff, 05/14/2019
%}


function [study_name,study_file,study_path] = param_study(set_session)

% test the type of input to extract the repertory
if not(isfolder(set_session))
    set_session=string(set_session);
    path=fileparts(set_session(1));
else
    path=set_session;
end

% build the information needed
comp=split(path,'\');
if comp(end)=="", comp(end)=[];end
study_name=char(comp(end));
study_file=[study_name '.study'];
study_path=char(join(comp(1:end-1),'\'));    

end

