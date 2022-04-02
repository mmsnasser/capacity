% 
clc;clear
addpath ../bie
addpath ../fmm
addpath ../strip
% 
%%
n  =  2^10;
t  = (0:2*pi/n:2*pi-2*pi/n).';
m  =  100;
Lb = 2*pi/mu(tanh(1));
Ub = m*2*pi/mu(tanh(0.01));
alphas  =  0.5i;
%
for kk=1:10
    %
    kk
for k=1:10^4
    cv(k,1)= (8*rand-4)+(2*rand-1)*i;
end
for k=1:10^4-1
    for j=k+1:10^4
        if abs(cv(j)-cv(k))<0.04
            cv(j)=NaN+i*NaN;
        end
    end
end
cv(abs(cv-alphas)<=0.1)=NaN+i*NaN;
cv=cv(abs(cv)>=0);
cv=sort(cv(1:m));
%
if kk==1
figure
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
%
hold on
box on
for k=1:m
    plot([real(cv(k))-0.01 real(cv(k))+0.01],[imag(cv(k)) imag(cv(k))],'k','LineWidth',1.5)
end
plot([-4.1 4.1],[-pi/2 -pi/2],'b','LineWidth',1.5)
plot([-4.1 4.1],[ pi/2  pi/2],'b','LineWidth',1.5)
set(gca,'FontSize',22)
axis equal
axis([-4.  4.  -2.  2.])
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc slits100_x 
end
%
%
%%
%
r       =  0.2;
%
Lc      = [0;cv]; Lk = [0;0.02+zeros(m,1)];  thetk = zeros(m+1,1);
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
%%
capv(kk,1) = capac(et,etp,alphav,m,alpha);
Lbv(kk,1)  = Lb;
%
end
%%
format long g
[Lbv capv]
%%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
plot(1:10,Lbv,'-.k','MarkerFaceColor','r','LineWidth',1.5);
hold on
plot(1:10,capv,'b','LineWidth',1.5);
%
legend({'$2\pi/\mu(\tanh(1))$','${\rm cap}(S,\cup_{k=1}^m E_k)$'},...
        'Interpreter','LaTeX','location','East')
%
xlabel({'Number of the experiment'},'Interpreter','LaTeX')
axis([1 10 0 14])
grid(gca,'minor')
grid on
set(gca, 'XMinorTick','on')
set(gca, 'YMinorTick','on')
ax=gca;
ax.GridAlpha=0.5;
ax.MinorGridAlpha=0.5;
set(gca,'XTick',[0:2:10]);
set(gca,'YTick',[0:2:14]);
set(gca,'FontSize',22)
set(gca,'LooseInset',get(gca,'TightInset'))
%%