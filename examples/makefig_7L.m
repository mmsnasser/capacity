% Example  
% u(x,y)=\capa(S,[i,x+\i y]).
% 9-2-2020
% 
clc;clear
addpath ../bie
addpath ../fmm
addpath ../strip
% 
%%
sv          =  linspace(-1.55,1.55,101).';
%
%
n         =  2^11;
t         = (0:2*pi/n:2*pi-2*pi/n).';
r         =  0.1;  
%
%%
%
for kk=1:length(sv)
    %
    %
    s       =  sv(kk);
    if abs(s)>1.4
        r = 0.01;
    end
    a       =  i*s-1;  
    b       =  i*s+1;
    [kk a  b]
    alphas  =  1.5;
    m       =  1;
    %
    Lc(1,1) =  0;      Lk(1,1) =  0;        thetk(1,1) =  0;
    Lc(2,1) = (a+b)/2; Lk(2,1) =  abs(b-a); thetk(2,1) =  angle(b-a);    
    %
    %
    tic
    map = PreImageStripRec(Lc,Lk,thetk,alphas,r,n,1e-14,100);
    %
    et     = map.et;
    etp    = map.etp;
    zet    = map.zet;
    alpha  = map.alpha;
    alphav = map.alphav;
    %
    %
    cap         = capac(et,etp,alphav,m,alpha)
    capn(kk,1) = cap;
    toc
end
%
%%
format short g
[sv capn]
%%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
plot(sv,capn,'b','LineWidth',1.5);
% axis equal
% axis off
hold on
xlabel('$s$','Interpreter','latex')
ylabel('${\rm cap}(S,{\rm i} s+[-1,1])$','Interpreter','latex')
% axis([-3.0 3.0 -2 2])
grid(gca,'minor')
grid on
set(gca, 'XMinorTick','on')
set(gca, 'YMinorTick','on')
ax=gca;
ax.GridAlpha=0.5;
ax.MinorGridAlpha=0.5;
set(gca,'FontSize',18)
set(gca,'LooseInset',get(gca,'TightInset'))
set(gca,'XTick',[-1.6:0.4:1.6]);
set(gca,'YTick',[0:20:100]);
axis([-1.7 1.7 0 103])
print -depsc sing_cont_hor_is
%%