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
av          =  [0.3.*(randperm(10)-5)+0.2i.*(randperm(10)-5)].';
bv          =  [0.3.*(randperm(10)-5)+0.2i.*(randperm(10)-5)].';
%
%
n         =  2^11;
t         = (0:2*pi/n:2*pi-2*pi/n).';
r         =  0.2;  
%
%%
%
for kk=1:length(av)
    %
    %
    a       =  av(kk);
    b       =  bv(kk);
    [kk a  b]
    alphas  =  0.5+max(abs(real(a)),abs(real(b)));
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
    %
    figure(1)
    clf
    plot(real([a b]),imag([a b]),'-or')
    hold on
    plot(real(alphas),imag(alphas),'ob')
    axis([-3 3 -1.5 1.5])
    drawnow
end
%
%%
format short g
[av bv capn]
%%
