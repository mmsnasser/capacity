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
sv          =  linspace(-0.55,0.55,101).';
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
    a       =  i*(s-1);  
    b       =  i*(s+1);
    [kk a  b]
    alphas  =  1;
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
ylabel('${\rm cap}(S,{\rm i} s+[-{\rm i},{\rm i}])$','Interpreter','latex')
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
set(gca,'XTick',[-0.6:0.2:0.6]);
set(gca,'YTick',[4:1:9]);
print -depsc sing_cont_ver_is
%%