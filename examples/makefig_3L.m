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
et0   =  [5+i*pi/2 -5+i*pi/2 -5-i*pi/2 5-i*pi/2];
et1   =  [2-i 3.5+0.5i];
et2   =  [1+i -1+i];
et3   =  [-i -2.5+0.5i];
et4   =  [-3-i -3+i];
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

% 
text(0.1,0,'{$\Omega$}','FontSize',18,'Interpreter','latex');
%
text(+0.0,0.8,'{$E_1$}','FontSize',18,'Interpreter','latex');
text(+2.4,-0.75,'{$E_2$}','FontSize',18,'Interpreter','latex');
text(-0.5,-0.6,'{$E_3$}','FontSize',18,'Interpreter','latex');
text(-2.98,+0.75,'{$E_4$}','FontSize',18,'Interpreter','latex');
%
text(-0.5,1.75,'{$u=0$}','FontSize',18,'Interpreter','latex');
text(-0.5,-1.8,'{$u=0$}','FontSize',18,'Interpreter','latex');
text(-0.4,1.2,'{$u=\delta_1$}','FontSize',18,'Interpreter','latex');
text(2.1,+0.25,'{$u=\delta_2$}','FontSize',18,'Interpreter','latex');
text(-1.95,+0.25,'{$u=\delta_3$}','FontSize',18,'Interpreter','latex');
text(-2.98,-0.75,'{$u=\delta_4$}','FontSize',18,'Interpreter','latex');
% 
% text(-0.65,1.35,'{$\alpha$}','FontSize',18,'Interpreter','latex');
% 
% hA=gca;
% set(hA,'GridAlpha',0.8);       
%
set(gca,'LooseInset',get(gca,'TightInset'))
set(gca,'FontSize',18)
axis equal
axis([-4 4 -2 2])
% axis off
set(gcf,'renderer','painters')
print(fig,'-depsc',sprintf('domaingcs.eps')) 
%%