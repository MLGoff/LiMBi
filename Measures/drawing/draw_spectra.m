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
function draw_spectra(STUDY,ind_cond,chanind,norm)


    %intialisation
    if norm,data=STUDY.spectrum.norm;else,data=STUDY.spectrum.densities;end
    freq=STUDY.spectrum.frequency;
    ind_cond=string(ind_cond);

    %Delete values for other conditions
    data(data.cond~=ind_cond,:)=[];

    %creation color scale
    color=prism(9);

    %plot spectre for all session and one channel
    leg=arrayfun(@(i) ['Session ' num2str(i)],1:size(data,1),'UniformOutput',false);
    for i = chanind
%         figure
        for k = [1 size(data,1)]
            plot(freq,data.values{k}(i,:),'color',color(k,:),'LineStyle','--',...
                'Marker','s','MarkerSize',6,'MarkerFaceColor',color(k,:))
            hold on
        end
        title(['Evolution of the density spectra across session '])
        xlabel('Frequency (Hz)')
         if norm,ylabel('Variation baseline (%)'),else,ylabel('PSD 10 x log(µV²/Hz)'),end
        legend(leg([1 end]))
    end
end

