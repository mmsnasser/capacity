% Example 
% u(x)=\capa(S,F_1\cup F_2) where $F_1=-x+[-1-\i,1+\i] and F_2=x+[0,1-\i]
% 9-2-2020
% 
clc;clear
addpath ../bie
addpath ../fmm
addpath ../strip
% 
%%
xv = [0.01,0.025,0.05,0.1,0.15,0.2:0.1:1,1.05:0.05:1.3,1.325:0.025:1.45,1.46:0.01:1.5].';        
%
%
n         =  2^12;
t         = (0:2*pi/n:2*pi-2*pi/n).';
%
%%
%
for kk=1:length(xv)
    %
    x     =  xv(kk);
    r     =  min(min(0.2,x/2),1.53-x);
    a(1)  = -x*i-1;    a(2)  =  x*i-1;
    b(1)  = -x*i+1;    b(2)  =  x*i+1;
    if x>0.35
        alphas  =  0;
    else
        alphas  =  0.75i;
    end
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
    map = PreImageStripRec(Lc,Lk,thetk,alphas,r,n,1e-14,200);
    toc
    %
    et     = map.et;
    etp    = map.etp;
    zet    = map.zet;
    alpha  = map.alpha;
    alphav = map.alphav;
    %
    %
    capn2g(kk,1) = capac(et,etp,alphav,m,alpha);
    %
end
%%
for kk=1:length(xv)
    %
    x     =  xv(kk);
    r     =  min(0.2,1.53-x);
    a     = -x*i-1;    
    b     = -x*i+1;    
    alphas  =  0.5i;
    m       =  length(a);
    %
    Lc = [];   Lc = [0 ; (a+b)/2];
    Lk = [];   Lk = [0 ; abs(b-a)];
    thetk =[]; thetk =[0; angle(b-a)];
    %
    tic
    map = PreImageStripRec(Lc,Lk,thetk,alphas,r,n,1e-14,200);
    toc
    %
    et     = map.et;
    etp    = map.etp;
    zet    = map.zet;
    alpha  = map.alpha;
    alphav = map.alphav;
    %
    %
    capn1(kk,1) = capac(et,etp,alphav,m,alpha);
    %
end
%%
for kk=1:length(xv)
    %
    x     =  xv(kk);
    r     =  min(0.2,1.53-x);
    a     =  x*i-1;    
    b     =  x*i+1;    
    alphas  =  -0.5i;
    m       =  length(a);
    %
    Lc = [];   Lc = [0 ; (a+b)/2];
    Lk = [];   Lk = [0 ; abs(b-a)];
    thetk =[]; thetk =[0; angle(b-a)];
    %
    tic
    map = PreImageStripRec(Lc,Lk,thetk,alphas,r,n,1e-14,200);
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
format long g
[xv capn2g capn1 capn2]
%%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
plot(xv,capn1,'-k','MarkerFaceColor','r','LineWidth',1.5);
hold on
plot(xv,capn2,'--m','MarkerFaceColor','r','LineWidth',1.5);
plot(xv,capn1+capn2,'-.r','MarkerFaceColor','r','LineWidth',1.5);
plot(xv,capn2g,'b','LineWidth',1.5);
%
legend({'${\rm cap}(S,E_1)$',...
        '${\rm cap}(S,E_2)$',...
        '${\rm cap}(S,E_1)+{\rm cap}(S,E_2)$',...
        '${\rm cap}(S,E_1\cup E_2)$'},'Interpreter','LaTeX',...
        'location','NorthWest')
%
xlabel({'$x$'},'Interpreter','LaTeX')
axis([0 1.5 0 60])
grid(gca,'minor')
grid on
set(gca, 'XMinorTick','on')
set(gca, 'YMinorTick','on')
ax=gca;
ax.GridAlpha=0.5;
ax.MinorGridAlpha=0.5;
% set(gca,'XTick',[0:0.5:4]);
% set(gca,'YTick',[3:1:12]);
set(gca,'FontSize',18)
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc 2hi_cont_u
%%