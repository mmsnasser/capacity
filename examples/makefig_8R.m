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
xv          = [-3.05:0.1:3.05];
yv          = [-1.55:0.05:1.55]; 
[x,y]       =  meshgrid(xv,yv);
z           =  x+i*y;
%
%
n         =  2^11;
t         = (0:2*pi/n:2*pi-2*pi/n).';
r         =  0.1;  
%
%%
%
[mz,nz] = size(z);
for kk=1:mz
    for jj=1:nz
        %
        %
        a       =  i;  
        b       =  z(kk,jj);
        [kk jj  b]        
        if abs(imag(b)-1.55)<0.01 & abs(real(b))>2
            capn(kk,jj) = NaN;
        else            
        %
        if real(b)>0
            alphas    = -1;
        else
            alphas    =  1;
        end
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
        capn(kk,jj) = cap;
        toc
        end
        %
    %%
% figure
% set(groot,'defaultAxesTickLabelInterpreter','latex');  
% set(groot,'defaulttextinterpreter','latex');
% set(groot,'defaultLegendInterpreter','latex');
% %
% hold on
% box on
% for k=2:m+1
%     crv = zet((k-1)*n+1:k*n,1); crv(n+1)  =  crv(1);crv(abs(crv)>10)=NaN+i*NaN;
%     plot(real(crv),imag(crv),'k','LineWidth',1.5)
% end
% crv = zet(1:n,1); 
% plot(real(crv),imag(crv),'b','LineWidth',1.5)
% plot(real(alphas),imag(alphas),'pr')
% set(gca,'FontSize',22)
% axis equal
% axis([-4.  4.  -2.  2.])
% set(gca,'LooseInset',get(gca,'TightInset'))
% drawnow
% %%
% figure
% hold on
% box on
% for k=2:m+1
%     crv = et((k-1)*n+1:k*n,1); crv(n+1)  =  crv(1);crv(abs(crv)>10)=NaN+i*NaN;
%     plot(real(crv),imag(crv),'k','LineWidth',1.5)
% end
% crv = et(1:n,1); 
% plot(real(crv),imag(crv),'b','LineWidth',1.5)
% plot(real(alpha),imag(alpha),'pr')
% plot(real(alphav),imag(alphav),'pb')
% set(gca,'FontSize',22)
% axis equal
% axis([-1.05  1.05  -1.05  1.05])
% set(gca,'LooseInset',get(gca,'TightInset'))
% drawnow
%%
    end
end
%%
format short g
capn
%%
save('xi_pt.mat', 'x', '-ascii', '-double');
save('yi_pt.mat', 'y', '-ascii', '-double');
save('ui_pt.mat', 'capn', '-ascii', '-double');
%%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
cntv  =  [2:8];
[cnt1,cnt2] = contour(x,y,capn,cntv,'b','LineWidth',1.5);
clabel(cnt1,cnt2,'labelspacing',500,'FontSize',18,'Interpreter','latex');
% axis equal
% axis off
hold on
plot(real(a),imag(a),'or','MarkerfaceColor','r');
plot([-3 3],[ pi/2  pi/2],'k','LineWidth',1.5);
plot([-3 3],[-pi/2 -pi/2],'k','LineWidth',1.5);
% xlabel('$x$','Interpreter','latex')
% ylabel('$y$','Interpreter','latex')
axis([-3.0 3.0 -2 2])
grid(gca,'minor')
grid on
set(gca, 'XMinorTick','on')
set(gca, 'YMinorTick','on')
ax=gca;
ax.GridAlpha=0.5;
ax.MinorGridAlpha=0.5;
set(gca,'XTick',[-3:1:3]);
set(gca,'YTick',[-2.0:0.5:2.0]);
set(gca,'FontSize',18)
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc sing_cont_i_x_yi
%%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(gca,'LooseInset',get(gca,'TightInset'))
cntv  =  [0:8];

contourf(x,y,capn,cntv,'b','LineWidth',1.5)
colormap cool
colorbar
% axis equal
% axis off
hold on
plot(real(a),imag(a),'or','MarkerfaceColor','r');
plot([-3 3],[ pi/2  pi/2],'k','LineWidth',1.5);
plot([-3 3],[-pi/2 -pi/2],'k','LineWidth',1.5);
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
axis([-3.0 3.0 -2 2])
grid(gca,'minor')
grid on
set(gca, 'XMinorTick','on')
set(gca, 'YMinorTick','on')
ax=gca;
ax.GridAlpha=0.5;
ax.MinorGridAlpha=0.5;
set(gca,'XTick',[-3:1:3]);
set(gca,'YTick',[-2.0:0.5:2.0]);
set(gca,'FontSize',18)
%%