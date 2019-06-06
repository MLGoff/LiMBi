%{
%list_filenames() - Return the info of all the files of a given format in
%                   a specific folder and its subfolders
%Usage :
%   >> filenames = list_filenames(folder,type_fichier)
%Inputs:
%    folder         -   [char array | string ] absolute path of the searched
%                       repertory
%    Type_fichier   -   [char array | string ] extension of the type of
%                       files you looking for. 
% Output : 
%    filenames      -   a structure containing the name, directory, date,
%                       weight of the files of the given format
%Author : Marion Le Goff, 05/14/2019
%}

function filenames = list_filenames(folder,type_fichier)
%Conversion variable in char
folder=char(folder);
type_fichier=char(type_fichier);
%Creation term including folder and all subfolders
if type_fichier(1)=='.'
    search_term = [folder '\**\*' type_fichier];
else
     search_term = [folder '\**\*.' type_fichier];
end
%compute structure
filenames = dir(search_term);
end

