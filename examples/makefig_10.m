% Example 
% u(x)=\capa(S,F_1\cup F_2) where F_1=-x+I, F_2=x+I,  I=[-1,1]
% 9-2-2020
% 
clc;clear
addpath ../bie
addpath ../fmm
addpath ../strip
% 
%%
xv = [1.01,1.05,1.1,1.15,1.25:0.125:5].';        
%
%
n         =  2^11;
t         = (0:2*pi/n:2*pi-2*pi/n).';
%
%%
%
for kk=1:length(xv)
    %
    x     =  xv(kk);
    r     =  0.2;
    a(1)  = -x-1;    a(2)  =  x-1;
    b(1)  = -x+1;    b(2)  =  x+1;
    alphas  =  0.5i;
    m       =  length(a);
    %
    Lc(1,1)   =  0;  Lk(1,1)   =  0;  thetk(1,1) = 0;
    for k=1:m
        Lc(k+1,1)     =  (a(k)+b(k))/2;
        Lk(k+1,1)     =   abs(b(k)-a(k));
        thetk(k+1,1)  =   angle(b(k)-a(k));
    end
    %
    tic
    map = PreImageStripRec(Lc,Lk,thetk,alphas,r,n,1e-14,100);
    toc
    %
    et     = map.et;
    etp    = map.etp;
    zet    = map.zet;
    alpha  = map.alpha;
    alphav = map.alphav;
    %
    %
    capn2(kk,1) = capac(et,etp,alphav,m,alpha);
    %
end
%%
%
Lb = 2*pi/mu(tanh(2));
Ub = 4*pi/mu(tanh(1));
%
%%
format long g
[xv capn2]
%%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
plot(xv,Lb+zeros(size(xv)),'-.k','MarkerFaceColor','r','LineWidth',1.5);
hold on
plot(xv,Ub+zeros(size(xv)),'-.r','MarkerFaceColor','r','LineWidth',1.5);
plot(xv,capn2,'b','LineWidth',1.5);
%
legend({'$2\pi/\mu(\tanh(2))$',...
        '$4\pi/\mu(\tanh(1))$',...
        '${\rm cap}(S,E_1\cup E_2)$'},'Interpreter','LaTeX',...
        'location','East')
%
xlabel({'$x$'},'Interpreter','LaTeX')
axis([1 5 6.5 9])
grid(gca,'minor')
grid on
set(gca, 'XMinorTick','on')
set(gca, 'YMinorTick','on')
ax=gca;
ax.GridAlpha=0.5;
ax.MinorGridAlpha=0.5;
set(gca,'XTick',[1:0.5:5]);
set(gca,'YTick',[6.5:0.5:9]);
set(gca,'FontSize',18)
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc 2h_cont_u
%%