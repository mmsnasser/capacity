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
sv  =  [0.5,2];
nv  =  [8:4:200,220:20:1000]';
%
r   =   0.2;  
m   =   1;
%
%%
%
for kk=1:length(sv)
    %
    s       =  sv(kk);    
    a       = -s;  
    b       =  s;
    alphas  =  i;
    %
    Lc      = [0 ; 0];
    Lk      = [0 ; 2*s];
    thetk   = [0 ; 0];
    %
    cape(kk,1) =  2*pi/mu(tanh(s));
    %
    for jj=1:length(nv)
        %
        n         =  nv(jj)
        t         = (0:2*pi/n:2*pi-2*pi/n).';
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
        capn(kk,jj) = capac(et,etp,alphav,m,alpha);
        tim(kk,jj)  = toc;
        %
        rerr(kk,jj) =  abs(capn(kk,jj)-cape(kk,1))/cape(kk,1); 
        itr(kk,jj)  =  map.itr;
        %
figure(1)
clf
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
%
figure(2)
clf
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
        %
    end
end
%%
rerr(rerr<eps)=eps;
figure
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
%
loglog(nv,rerr(1,:),'b','LineWidth',1.5)
hold on
loglog(nv,rerr(2,:),'r','LineWidth',1.5)
%
loglog(nv,0.04*exp(-0.217*nv),'-.k','LineWidth',1.5)
loglog(nv,0.1*exp(-0.215*nv),':k','LineWidth',1.5)
%
legend('$s=0.5$','$s=2$','$O(e^{-0.217n})$','$O(e^{-0.215n})$','Location','northeast')
%
xlabel('$n$','Interpreter','latex')
set(gca,'XTick',[1e1,1e2,1e3]);
set(gca,'YTick',[1e-15,1e-10,1e-5,1e0]);
grid(gca,'minor')
grid on
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
ax=gca;
ax.GridAlpha=0.5;
ax.MinorGridAlpha=0.5;
set(gca,'FontSize',18)
axis square
set(gca,'LooseInset',get(gca,'TightInset'))
axis([1e1  1e3  1e-16  1e0])
print -depsc sing_ms_s_err
%%