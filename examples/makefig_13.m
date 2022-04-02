% 
clc;clear
%
resr = [  4.30568998739557           11.494238973647
          4.30568998739557          11.6408647910613
          4.30568998739557          11.5482357651783
          4.30568998739557          11.5233603475936
          4.30568998739557          11.4407113946188
          4.30568998739557          11.5066111313876
          4.30568998739557          11.5969718614194
          4.30568998739557          11.4131523892704
          4.30568998739557          11.5213756730289
          4.30568998739557          11.6515830875807
          ];
%          
resx = [  4.30568998739557           20.497226570821
          4.30568998739557          19.8716209271657
          4.30568998739557          19.6476459911952
          4.30568998739557          19.5903526277368
          4.30568998739557          19.6956623714033
          4.30568998739557          19.7020458652876
          4.30568998739557          19.7509490088201
          4.30568998739557          19.5963300752667
          4.30568998739557          20.3988647548693
          4.30568998739557          18.7466976350008          
          ];
%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
plot(1:10,resr(:,1),'-.k','MarkerFaceColor','r','LineWidth',1.5);
hold on
plot(1:10,resr(:,2),'b','LineWidth',1.5);
plot(1:10,resx(:,2),'r','LineWidth',1.5);
%
legend({'$2\pi/\mu(\tanh(1))$','${\rm cap}(S,\cup_{j=1}^m E_j)$',...
        '${\rm cap}(S,\cup_{j=1}^m \hat E_j)$'},...
        'Interpreter','LaTeX','location','NorthEast')
%
xlabel({'Number of the experiment'},'Interpreter','LaTeX')
grid(gca,'minor')
grid on
set(gca, 'XMinorTick','on')
set(gca, 'YMinorTick','on')
ax=gca;
ax.GridAlpha=0.5;
ax.MinorGridAlpha=0.5;
set(gca,'LooseInset',get(gca,'TightInset'))
axis([1 10 0 30])
set(gca,'XTick',[0:1:10]);
set(gca,'YTick',[0:5:30]);
set(gca,'FontSize',18)
print -depsc slits100cap
%%