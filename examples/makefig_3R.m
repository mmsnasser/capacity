clear
%%
clc;clear
addpath ../bie
addpath ../fmm
addpath ../strip
%
%%
n         =   2^10;
t         =  (0:2*pi/n:2*pi-2*pi/n).';
%%
et0   =  exp(i.*t);
et1   = -0.45+0.25i+0.2.*exp(-i.*t);
et2   = -0.35-0.45i+0.3.*exp(i.*t)+0.15.*exp(-i.*t);
et3   = +0.5-0.25i+0.22.*exp(i.*t)+0.13.*exp(-i.*t);
et4   =  0.3+0.55i+0.10.*exp(i.*t)-0.2.*exp(-i.*t);
%
fig=figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
hold on
box on

plot(real(et0),imag(et0),'k','LineWidth',1.5)
plot(real(et1),imag(et1),'b','LineWidth',1.5)
plot(real(et2),imag(et2),'-b','LineWidth',1.5)
plot(real(et3),imag(et3),'-b','LineWidth',1.5)
plot(real(et4),imag(et4),'-b','LineWidth',1.5)

plot(-0.15,-0.0,'ok','MarkerFaceColor','k','MarkerSize',3)
% 
text(0.1,0,'{$G$}','FontSize',18,'Interpreter','latex');
text(-0.14,0.06,'{$\alpha$}','FontSize',18,'Interpreter','latex');
%
text(+0.23,0.55,'{$E_1$}','FontSize',18,'Interpreter','latex');
text(-0.55,0.25,'{$E_2$}','FontSize',18,'Interpreter','latex');
text(-0.47,-0.47,'{$E_3$}','FontSize',18,'Interpreter','latex');
text(+0.5,-0.25,'{$E_4$}','FontSize',18,'Interpreter','latex');
%
text(+0.65,0.8,'{$u=0$}','FontSize',18,'Interpreter','latex');
text(+0.42,0.5,'{$u=\delta_1$}','FontSize',18,'Interpreter','latex');
text(-0.55,0.5,'{$u=\delta_2$}','FontSize',18,'Interpreter','latex');
text(-0.47,-0.68,'{$u=\delta_3$}','FontSize',18,'Interpreter','latex');
text(+0.35,-0.42,'{$u=\delta_4$}','FontSize',18,'Interpreter','latex');
% 
% text(-0.65,1.35,'{$\alpha$}','FontSize',18,'Interpreter','latex');
% 
% hA=gca;
% set(hA,'GridAlpha',0.8);       
%
set(gca,'LooseInset',get(gca,'TightInset'))
set(gca,'FontSize',18)
axis equal
axis([-1.2 1.2 -1.05 1.05])
% axis off
set(gcf,'renderer','painters')
print(fig,'-depsc',sprintf('domaingc.eps')) 
%%