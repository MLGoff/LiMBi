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

function [f,d]=draw_mean(STUDY,ALLEEG,ind_mark,chanind,fig,s)

if nargin<5,fig=figure;end
st=STUDY.stats_marker.stats{ind_mark};
sti=STUDY.stats_marker;
nm=size(st,1);
nc=numel(STUDY.condition);
if size(chanind)==1
    y=arrayfun(@(i) st.mean{i}(chanind),1:nm);
    er=arrayfun(@(i) st.std{i}(chanind),1:nm);

%     des=['sr';'sm';'sb'];
%     des=[[0.3010 0.7450 0.9330];[0.9290 0.6940 0.1250];[0.961 0.2 0.251]];
    des=[[0.3010 0.7450 0.9330];[0.9290 0.6940 0.1250];[0.961 0.2 0.251];[0.541 0.871 0.251]];

    if sti.Type(ind_mark)=="Ratio"
        titl=sprintf(['absolute progression of %s concerning %s : %0.2f - %0.2f hz '...
            '/ %0.2f - %0.2f hz' ],STUDY.subject{1}, sti.Type(ind_mark),....
            sti.Freq1{ind_mark},sti.Freq2{ind_mark});
    else
        titl=sprintf('absolute progression of %s concerning %s : %0.2f - %0.2f hz',...
            STUDY.subject{1}, sti.Type(ind_mark),sti.Freq1{ind_mark},sti.Freq2{ind_mark});
    end
    f=figure(fig);
    mark=['s';'o';'^'];
    for i=2
        ic=st.cond==STUDY.condition{i}(1);
        e=errorbar(find(ic),y(ic),er(ic),mark(i),'k');
%         plot(find(ic),y(ic),mark(i),'MarkerFaceColor',des(s,:),...
%             'MarkerSize',10,'MarkerEdgeColor','none');
        e.MarkerFaceColor=des(s,:);
        e.MarkerSize=10;
        e.MarkerEdgeColor='none';
        hold on
    end
    
    d=plot(find(ic),y(ic),'--','Color',des(s,:));
%     xticks(1:3:nm)
%     xticklabels(join([st.Session st.cond]))
%     xticklabels(STUDY.session')
%     legend('baseline','neurofeedback','transfert')
%     legend('baseline','neurofeedback')
%     title(titl)
else
    [ntot,id]=max(arrayfun(@(i) ALLEEG(i).nbchan,1:numel(ALLEEG)));
    chanloc=ALLEEG(id).chanlocs(chanind);
    for i=2
        ic=st.cond==STUDY.condition{i}(1);
        is=find(ic);
        ns=sum(ic);
        meant=zeros(ntot,ns);
        for s =1:ns,meant(:,s)=st.mean{is(s)};end
        meant(meant==0)=NaN;
        vmax=max(meant,[],'all');
        vmin=min(meant,[],'all');
        figure(fig)
        for s=1:numel(is)
            subplot(3,3,s)
            try topoplot(meant(:,s),chanloc,'maplimits',[vmin vmax]);end
            title(['Session' num2str(s) 'Condition :' STUDY.condition{i}])
        end
        subplot(3,3,s)
        colorbar
    end
    
end

