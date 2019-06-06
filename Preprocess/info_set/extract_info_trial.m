%{
% extract_info_trial() - Using the absolute adress
% Usage :
%   >> [sujet,session,condition,bloc] = extract_info_trial(filename,baseline_indicator,transfer_indicator)
% Input:
%     filename           -   Adress of the file analyze
% Optionnal inputs:
%     baseline_indicator -   Element indicating that the file is a
%                            recording of baseline
%     transfer_indicator -   Element indicating that the file is a
%                            recording of a bloc transfer
% Output : 
%     sujet              -   [string] The id of the participant
%     session            -   [string] The numero of the session 
%     condition          -   [string] The type of bloc performed
%     bloc               -   [string] The number of the bloc
% Author : Marion Le Goff, 05/14/2019
%}

function [sujet,session,condition,bloc] = extract_info_trial(filename,baseline_indicator,transfer_indicator)
%component adress filename
[filepath,name,~] = fileparts(char(filename));
% Check if all the info needed exists
if isempty(filepath)
    error("[WARNING] invalid input data,check if its indeed the full adress of the files",class(""))
    return
end
%extract info contains in the name of the file
name=split(name,'_');
session = string(name{end-2});
bloc = string(name{end-1});
% Deduce the conditions of the set : baseline, NF or transfer
if nargin==3
    if bloc==string(baseline_indicator), condition="baseline"; ...
    elseif bloc==string(transfer_indicator), condition="transfer";...
    else, condition="neurofeedback";
    end
elseif nargin==2
    if bloc==string(baseline_indicator), condition="baseline"; ...
    elseif bloc=="7", condition="transfer";...
    else, condition="neurofeedback";
    end
else
    if bloc=="0", condition="baseline"; ...
    elseif bloc=="7", condition="transfer";...
    else, condition="neurofeedback";
    end
end
%Extract data using file path
filepath=split(filepath,'\');
sujet=string(filepath(end-1));
end

