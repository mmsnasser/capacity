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
        -1.90+0.10i     -1.90+1.00i
        -2.90-0.10i     -2.90-1.00i
        
        -1.90+1.10i     -2.90+1.10i
        -1.90-1.10i     -2.90-1.10i
        -1.90-0.00i     -2.90-0.00i
        
        -1.30+0.10i     -1.30+1.00i
        -1.30-0.10i     -1.30-1.00i
        -0.30+0.10i     -0.30+1.00i
        -0.30-0.10i     -0.30-1.00i
         
        -1.30+1.10i     -0.30+1.10i
        -1.30-1.10i     -0.30-1.10i
        
         1.30+0.10i      1.30+1.00i
         0.30-0.10i      0.30-1.00i
        
         1.30+1.10i      0.30+1.10i
         1.30-1.10i      0.30-1.10i
         1.30-0.00i      0.30-0.00i
         
         2.90+0.10i      2.90+1.00i
         1.90-0.10i      1.90-1.00i
         
         1.90+1.10i      2.90+1.10i
         1.90-1.10i      2.90-1.10i
         1.90-0.00i      2.90-0.00i
         
        ];
%
alphas    =  0-0.0i;
%
n         =  2^11;
r         =  0.2;  
%
plotdomain (Coefs , [] , alphas , n )
%%
%
av    =  Coefs(:,1);  
bv    =  Coefs(:,2);
m     =  length(av);
%
t         = (0:2*pi/n:2*pi-2*pi/n).';
Lc(1,1)   =  0;  Lk(1,1)   =  0;  thetk(1,1) = 0;
for k=1:m
    Lc(k+1,1)     =  (av(k)+bv(k))/2;
    Lk(k+1,1)     =   abs(bv(k)-av(k));
    thetk(k+1,1)  =   angle(bv(k)-av(k));
end
tic
map       =  PreImageStripRec (Lc , Lk , thetk , alphas , r , n , 1e-14  , 100 );
toc
%
et    = map.et;
etp   = map.etp;
zet   = map.zet;
alpha = map.alpha;
%
%%

%%
xh      =  linspace(-4.0,4.0,1000);
zh(1,:) =  xh+i*1.4;
zh(2,:) =  xh+i*1.15;
zh(3,:) =  xh+i*1.05;
zh(4,:) =  xh+i*0.05;
zh(5,:) =  xh-i*0.05;
zh(6,:) =  xh-i*1.05;
zh(7,:) =  xh-i*1.15;
zh(8,:) =  xh-i*1.4;
yv      =  linspace(-1.4,1.4,1000);
zv(1,:) = -4+i*yv;
zv(2,:) = -3+i*yv;
zv(3,:) = -1.8+i*yv;
zv(4,:) = -1.4+i*yv;
zv(5,:) = -0.2+i*yv;
zv(6,:) =  0.2+i*yv;
zv(7,:) =  1.4+i*yv;
zv(8,:) =  1.8+i*yv;
zv(9,:) =  3+i*yv;
zv(10,:)=  4+i*yv;
%%
% for k=1:8
%     wh(k,:) = evalmap(map,zh(k,:),'v');
% end
% for k=1:10
%     wv(k,:) = evalmap(map,zv(k,:),'v');
% end  
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
% for k=1:8
% %     plot(real(zh(k,:)),imag(zh(k,:)),'b','LineWidth',0.5);
%     plot(real(zh(k,:)),imag(zh(k,:)),'.b','MarkerSize',0.5);
% end    
% for k=1:10
% %     plot(real(zv(k,:)),imag(zv(k,:)),'r','LineWidth',0.5);
%     plot(real(zv(k,:)),imag(zv(k,:)),'.r','MarkerSize',0.5);
% end    
% plot(real(alphas),imag(alphas),'pr','MarkerFaceColor','r')
grid on; grid('minor')
set(gca, 'XMinorTick','on'); set(gca, 'YMinorTick','on')
ax=gca; ax.GridAlpha=0.5; ax.MinorGridAlpha=0.5;
set(gca,'FontSize',22)
axis equal
set(gca,'LooseInset',get(gca,'TightInset'))
axis([-4.  4.  -2.  2.])
print -depsc fig_dom_O
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
% for k=1:8
% %     plot(real(wh(k,:)),imag(wh(k,:)),'b','LineWidth',0.5);
%     plot(real(wh(k,:)),imag(wh(k,:)),'.b','MarkerSize',0.5);
% end
% for k=1:10
% %     plot(real(wv(k,:)),imag(wv(k,:)),'r','LineWidth',0.5);
%     plot(real(wv(k,:)),imag(wv(k,:)),'.r','MarkerSize',0.5);
% end
% plot(real(alpha),imag(alpha),'pr','MarkerFaceColor','r')
grid on; grid('minor')
set(gca, 'XMinorTick','on'); set(gca, 'YMinorTick','on')
ax=gca; ax.GridAlpha=0.5; ax.MinorGridAlpha=0.5;
set(gca,'FontSize',22)
axis equal
set(gca,'LooseInset',get(gca,'TightInset'))
axis([-1.05  1.05  -1.05  1.05])
print -depsc fig_dom_G
%%
error = map.error;
No    = length(error)
p = polyfit(1:No,log(error'),1);
p1 = p(1,1)
p2 = p(1,2);
c1 = exp(p2);
q  = exp(p1)
%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
semilogy(1:No,error,'-db','LineWidth',1.5)
hold on
semilogy(0:No+1,c1*(0.264).^(0:No+1),'-.r','LineWidth',1.5)
xlabel('The number of iteration: $k$')
legend({'$E_k$','$O(0.264^k)$'},'Location','northeast','Interpreter','latex')
set(gca,'FontSize',18)
grid on; grid('minor')
set(gca, 'XMinorTick','on'); set(gca, 'YMinorTick','on')
ax=gca; ax.GridAlpha=0.5; ax.MinorGridAlpha=0.5;
set(gca,'LooseInset',get(gca,'TightInset'))
% axis([-1.05  1.05  -1.05  1.05])
% print -depsc map_error2
%%