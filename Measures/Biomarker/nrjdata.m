%{
% nrjdata() -  Estimate the energy of the signal for one epoch and one channel
% Usage :
%   >> vec = nrjdata(data)
% Inputs:
%   data        - An array of discrete value of the signal in µv and with
%                 3 dimensions : channel x time x epochs
%   logarithm   - [0|1] If true take the log value of the spectral energy
% Output : 
%   vec         - An array of two dimension : channel x epochs representing 
%                 the log value of the spectral energy
% Author : Marion Le Goff, 05/14/2019
%}


function vec = nrjdata(data,logarithm)
%Energy estimation
mu = mean(data.*data,2,'omitnan');
%log value
if logarithm, vec = log(1+mu); else, vec=mu; end
end

