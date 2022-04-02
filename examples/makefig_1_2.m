% Example - test - one sli
% 9-2-2020
% 
clc;clear
addpath ../bie
addpath ../fmm
addpath ../strip
% 
%%
Coefs = [
         1.50-0.75i      2.50+1.25i
         1.00-1.25i      0.50+1.00i
        -0.50-1.25i     -0.50+1.00i
        -2.50-1.25i     -1.00+1.25i
        ];
%
av    =  Coefs(:,1);  
bv    =  Coefs(:,2);
m     =  length(av);
%
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
%
figure
hold on
box on
for k=1:m
    crv = [av(k) bv(k)];
    plot(real(crv),imag(crv),'k','LineWidth',1.5)
end
crv = [-5+i*pi/2 5+i*pi/2]; 
plot(real(crv),imag(crv),'b','LineWidth',1.5)
crv = [-5-i*pi/2 5-i*pi/2]; 
plot(real(crv),imag(crv),'b','LineWidth',1.5)
grid on; grid('minor')
set(gca, 'XMinorTick','on'); set(gca, 'YMinorTick','on')
ax=gca; ax.GridAlpha=0.5; ax.MinorGridAlpha=0.5;
set(gca,'FontSize',22)
axis equal
axis([-4.05  4.05  -2.05  2.05])
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc strip_fig_dom
%%
r         =  0.4;
n         =  2^11;
t         = (0:2*pi/n:2*pi-2*pi/n).'; 
%
Lc(1,1)   =  0;  Lk(1,1)   =  0;  thetk(1,1) = 0;
for k=1:m
    Lc(k+1,1)     =  (av(k)+bv(k))/2;
    Lk(k+1,1)     =   abs(bv(k)-av(k));
    thetk(k+1,1)  =   angle(bv(k)-av(k));
end
%
map   =  PreImageStripRec (Lc , Lk , thetk , 0 , 0.2 , n , 1e-14  , 100 );
%
et    =  map.et;
zet   =  map.zet;
%
cent   =  Lc;
ak     = (1-0.5*r).*Lk;
%
for k=2:m+1
    xt(1+(k-1)*n:k*n,1)  = cent(k)+0.5*exp(i*thetk(k))*ak(k).*( cos(t)-i*r.*sin(t));
end
%%
figure
hold on
box on
for k=1:m
    crv = [av(k) bv(k)];
    plot(real(crv),imag(crv),'k','LineWidth',1.5)
end
for k=2:m+1
    crv = xt(1+(k-1)*n:k*n);
    plot(real(crv),imag(crv),':r','LineWidth',1.5)
end
crv = [-5+i*pi/2 5+i*pi/2]; 
plot(real(crv),imag(crv),'b','LineWidth',1.5)
crv = [-5-i*pi/2 5-i*pi/2]; 
plot(real(crv),imag(crv),'b','LineWidth',1.5)
grid on; grid('minor')
set(gca, 'XMinorTick','on'); set(gca, 'YMinorTick','on')
ax=gca; ax.GridAlpha=0.5; ax.MinorGridAlpha=0.5;
set(gca,'FontSize',22)
axis equal
axis([-4.05  4.05  -2.05  2.05])
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc strip_fig_domc
%%
eto(1:n,1)   =   exp(i.*t);
%
for k=2:m+1
    eto(1+(k-1)*n:k*n,1)    =  Phiv(xt(1+(k-1)*n:k*n,1));
end
%
figure
hold on
box on
for k=2:m+1
    crv = eto(1+(k-1)*n:k*n);
    plot(real(crv),imag(crv),':r','LineWidth',1.5)
    crv = et(1+(k-1)*n:k*n);
    plot(real(crv),imag(crv),'k','LineWidth',1.5)
end
crv = eto(1:n); 
plot(real(crv),imag(crv),'b','LineWidth',1.5)
grid on; grid('minor')
set(gca, 'XMinorTick','on'); set(gca, 'YMinorTick','on')
ax=gca; ax.GridAlpha=0.5; ax.MinorGridAlpha=0.5;
set(gca,'FontSize',22)
axis equal
axis([-1.15  1.15  -1.15  1.15])
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc strip_fig_domi
%
%%
zetc    =  Phiv(zet);
figure
hold on
box on
k=1;
crv = zetc(1+(k-1)*n:k*n);
plot(real(crv),imag(crv),'b','LineWidth',1.5)
for k=2:m+1
    crv = zetc(1+(k-1)*n:k*n);
    plot(real(crv),imag(crv),'k','LineWidth',1.5)
end
grid on; grid('minor')
set(gca, 'XMinorTick','on'); set(gca, 'YMinorTick','on')
ax=gca; ax.GridAlpha=0.5; ax.MinorGridAlpha=0.5;
set(gca,'FontSize',22)
axis equal
axis([-1.15  1.15  -1.15  1.15])
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc strip_fig_domic
%%
