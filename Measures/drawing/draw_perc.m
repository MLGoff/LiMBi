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
function [f,b]=draw_perc(STUDY,ALLEEG,chanind,ind_mark,suj,fig)

if nargin<6,fig=figure;end
des=[[0.3010 0.7450 0.9330];[0.9290 0.6940 0.1250];[0.961 0.2 0.251];[0.541 0.871 0.251]];

%Initialisation
data=STUDY.Normalized.ViaBaseline;
leg=STUDY.Normalized.leg_act;

%Definition x values
[nc,ns]=size(leg);
x=reshape(1:nc*ns,nc,ns);
% x=suj:5:ns*5;
    
% for c=chanind
%     f=figure(fig);
%     for i=1
%         d=squeeze(data.Mean(c,i,:))';
% %         s=squeeze(data.STD(c,i,:))';
% %         b=bar(x(i,:),d,'BarWidth',0.4);
%         b=bar(x,d,'BarWidth',0.2,'FaceColor',des(suj,:));
%         hold on
% %         errorbar(x(i,:),d,s*100,'LineStyle','none','Color','k')
% %         hold on
%     end
%     title('Evolution of the target regarding the baseline across each session')
%     ylabel('Variation of the target(%)')
% %     xticks(1:nc*ns)
% %     xticklabels(leg)
% %     legend('Neurofeedback','Standard Deviation','Transfer')
% end
if numel(chanind)>8  
    [ntot,id]=max(arrayfun(@(i) ALLEEG(i).nbchan,1:numel(ALLEEG)));
    chanloc=ALLEEG(id).chanlocs(chanind);
    for i=1:nc
        meant=squeeze(data.Mean(chanind,i,:));
        meant(meant==0)=NaN;
        vmax=max(meant,[],'all');
        vmin=min(meant,[],'all');
        figure
        for s=1:ns
            subplot(3,3,s)
            topoplot(meant(:,s),chanloc,'maplimits',[vmin vmax])
            title(['Session' num2str(s)])
        end
        subplot(3,3,s)
        c = colorbar;
        c.Label.String = 'Variation (in %)';
    end
end
end

