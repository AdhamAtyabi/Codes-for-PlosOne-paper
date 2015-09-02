%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  A collection of MATLAB codes used for drawing the results        %
%  Version 1.0 - Aug. 2015                                          %
%                                                                   %
%  According to:                                                    %
%  H.R. Tavakoli, A. Atyabi, Antti Rantanen, Seppo J. Laukka,       %
%  Samia Nefti-Meziani, & Janne Heikkilä,                          %
%  "Predicting the valence of a scene from observers' eye movements"%
%  PLOS ONE, 2015.                                                  %
%                                                                   %
%                                                                   %
%  Programmed By: A. Atyabi                                         %
%                                                                   %
%         e-Mail: a.atyabi@salford.ac.uk                            %
%                 adham.atyabi@flinders.edu.au                      %
%                                                                   %
% Homepage: http://www.seek.salford.ac.uk/profiles/AAtyabi.jsp      %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Draw_Bar_Plotxx(x,y,l,Y,E,Y2,E2,x2,d,angle)
% Plot bars
width=1;
ymax = 0;
numgroups = size(Y, 1); % number of groups
numbars = size(Y, 2); % number of bars in a group
if(size(Y,1)<2)
    E=[E;zeros(size(E))];
    Y=[Y;zeros(size(Y))];    
end
if(size(Y2,1)<2)
    E2=[E2;zeros(size(E2))];
    Y2=[Y2;zeros(size(Y2))];    
end
    handles.bars = bar(Y, width,'edgecolor','k', 'linewidth', 2);
	hold on
	% Plot erros    
for i = 1:numbars
		xx =get(get(handles.bars(i),'children'), 'xdata');
		xx = mean(xx([1 3],:));
		handles.errors(i) = errorbar(xx, Y(:,i), E(:,i), 'k', 'linestyle', 'none', 'linewidth', 2);
		ymax = max([ymax; Y(:,i)+E(:,i)]);
%         hhh=text(xx,repmat(ymax,[size(xx)]),strcat('       ',num2str(Y2(:,i)*100),'% '));
        hhh=text(xx,repmat(ymax,[size(xx)]),strcat('     ',num2str(Y2(:,i)*100),'% +/-',num2str(E2(:,i))));
        set(hhh,'Rotation',90);
end
    title(d, 'fontsize',14);
    xlabel(x, 'fontsize',14);
	ylabel(y, 'fontsize',14);
%
set(gca,'XGrid','off','YGrid','on','ZGrid','off');
% grid on
% grid minor
leg_h=legend(l(:,:));   
    %legend(l(1),l(2),l(3));   
    set(gca,'xtick',1:numgroups);
    set(gca,'xticklabel',x2);
    set(gca,'YLim',[min(Y(:))-0.05 max(Y(:))+0.3],'Layer','top')     
   rotateXLabels( gca,angle)
% bar(Y); 
% hold on
% 
% Xlabel(x);
% Ylabel(y);
% title(d);
% set(gca,'xtick',1:4);
% set(gca,'xticklabel',x2);
% errorbar(Y,E,'xr');
 colormap(gray)
 hold off
 paperPosition=[0 0 7.2 6];
set(gcf,'PaperUnits','inches','PaperPosition',paperPosition)
% print(gcf,'-depsc2', sprintf('rank_%s', upper(dataSet)));
end