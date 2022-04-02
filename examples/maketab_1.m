% Example 
% \capa(S,[-si,si])
% 9-2-2020
% 
clc;clear
addpath ../bie
addpath ../fmm
addpath ../strip
% 
%%
sv  =  [0.1,0.25,0.5,1,1.5,1.55];
%
%
n         =  2^10;
t         = (0:2*pi/n:2*pi-2*pi/n).';
r         =  0.2;  
%
%%
%
for kk=1:length(sv)
    %
    s       =  sv(kk);
    a       = -i*s;  
    b       =  i*s;
    alphas  =  1;
    m       =  1;
    %
    Lc      = [0 ; 0];
    Lk      = [0 ; 2*s];
    thetk   = [0 ; pi/2];
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
    capn(kk,1) = capac(et,etp,alphav,m,alpha);
    tim(kk,1)  = toc;
    %
    cape(kk,1) =  2*pi/mu(sin(s));
    rerr(kk,1) =  abs(capn(kk,1)-cape(kk,1))/cape(kk,1); 
    itr(kk,1)  =  map.itr;
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
format long 
[capn cape ]
format short g
[rerr tim itr]
%%