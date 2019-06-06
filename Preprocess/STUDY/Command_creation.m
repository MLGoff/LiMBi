%{
% Command_creation() - Create a cell array containing the consigns necessary
%                      to define a study set with all the files given in 
%                      input either as the folder containing them all or as
%                      a list of the full adresses of the files
%Usage :
%   >>  com = Command_creation(set_session)
%Inputs:
%   set_session     -       variable containing the files needed to deduce 
%                           command lines, either as a repertory or list of
%                           adresses
% Output : 
%   com             -       cell array containing one cell per line of command   
%Author : Marion Le Goff, 05/14/2019
%}

function com = Command_creation(set_session)

% Construction database of sets
if isfolder(set_session)
    files_data=list_filenames(set_session,'.set');
    nfic=numel(files_data);
    adresse=arrayfun(@(i) string([files_data(i).folder '\' files_data(i).name]),1:nfic)';
    setnames=arrayfun(@(f) {files_data(f).name},1:nfic);
    path=set_session;
%   test if the files are all in the same folder
    if prod(arrayfun(@(i) files_data(i).isdir==1,1:nfic))==0,path=[];end
else
    adresse = set_session;
    nfic=numel(adresse);
    setnames=cell(1,nfic);
    for i = 1:nfic
        [~,name,ext]=fileparts(adresse(i));
        setnames{i}=char(join([name ext],''));
    end
    [path,~,~]=fileparts(adresse(i));
%   test if the files are all in the same folder
    ad=split(adresse,'\');
    subf=ad(1,end-1);
    if prod(ad(:,end-1)==subf)==0,path=[];end
end

% Import the sets in the workspace
if isempty(path)
    for i=nfic:-1:1
        EEG(i)=pop_loadset(char(adresse(i)));
    end
else    
    path=char(path);
    EEG=pop_loadset('filename',setnames,'filepath',path);
end

% Create a cell array that can be used as command variable in std_editset
comind=arrayfun(@(i) {'index',i,'load',char(adresse{i}),'subject',char(EEG(i).subject),...
    'condition',char(EEG(i).condition),'session',char(EEG(i).session)}, 1:nfic,...
    'UniformOutput', false);

% Output
com=comind;
end


