% Example 
% \capa(S,[a,b]U[c,d])
% 9-2-2020
% 
clc;clear
addpath ../bie
addpath ../fmm
addpath ../strip
% 
%%
mcoef = [-1    -1+i    1    1-i    0
         -1    -1+i    1    1+i    0
         -1    -2      1    2      0
         -1+i   1+i   -1-i  1-i    0
         ];        
%
%
n         =  2^10;
t         = (0:2*pi/n:2*pi-2*pi/n).';
r         =  0.2;  
%
%%
%
[mc,nc] = size(mcoef);
for kk=1:mc
    %
    a(1)  =  mcoef(kk,1);  a(2)  =  mcoef(kk,3);
    b(1)  =  mcoef(kk,2);  b(2)  =  mcoef(kk,4);
    alphas  =  mcoef(kk,5);
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
    deltv =  ones(size(alphav));
    cap(kk,1) = capgc(et,etp,alphav,deltv,m,alpha);
    %
%%
figure
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
%
hold on
box on
for k=2:m+1
    crv = zet((k-1)*n+1:k*n,1); crv(n+1)  =  crv(1);crv(abs(crv)>10)=NaN+i*NaN;
    plot(real(crv),imag(crv),'k','LineWidth',1.5)
end
crv = zet(1:n,1); 
plot(real(crv),imag(crv),'b','LineWidth',1.5)
plot(real(alphas),imag(alphas),'pr')
set(gca,'FontSize',22)
axis equal
axis([-4.  4.  -2.  2.])
set(gca,'LooseInset',get(gca,'TightInset'))
drawnow
%%
figure
hold on
box on
for k=2:m+1
    crv = et((k-1)*n+1:k*n,1); crv(n+1)  =  crv(1);crv(abs(crv)>10)=NaN+i*NaN;
    plot(real(crv),imag(crv),'k','LineWidth',1.5)
end
crv = et(1:n,1); 
plot(real(crv),imag(crv),'b','LineWidth',1.5)
plot(real(alpha),imag(alpha),'pr')
plot(real(alphav),imag(alphav),'pb')
set(gca,'FontSize',22)
axis equal
axis([-1.05  1.05  -1.05  1.05])
set(gca,'LooseInset',get(gca,'TightInset'))
drawnow
%%
end
%%
format shortG
res=[mcoef(:,1) mcoef(:,2) mcoef(:,3) mcoef(:,4) cap]
format long g
cap
%%