function u = uofz (Coefs , Coefc , alphas , n , ratio , nop , m , map)
%
%
%
%%

%%
if isempty(Coefc)==0
    circent  =  Coefc(:,1);  
    cirrad   =  Coefc(:,2);
    ell      =  length(circent);
else
    ell =0;
end
%%
t         = (0:2*pi/n:2*pi-2*pi/n).';
%%
if m>0
    eto       =  map.et;
    etop      =  map.etp;
    zets      =  map.zet;
    alpha     =  map.alpha;
else
    eto       =  exp(i.*t);
    etop      =  i.*exp(i.*t);
    zets      =  Phi(eto);
    alpha     =  Phiv(alphas);
end
%%
zetc    =  Phiv(zets);
for k=1:m+1  
    Jk  = (k-1)*n+1:k*n;
    zetcp(Jk,1) = derfft(real(zetc(Jk,1)))+i*derfft(imag(zetc(Jk,1)));
end
%%
for k=1:ell
    zets_cir((k-1)*n+1:k*n,1)  =  circent(k)+cirrad(k).*exp(-i.*t);
end
if ell>0
    zetc_cir = Phiv(zets_cir);
else
    zetc_cir = [];
end
%%
et_cir =  fcau(zetc,zetcp,eto,zetc_cir.').';
for k=1:ell  
    Jk  = (k-1)*n+1:k*n;
    etp_cir(Jk,1) = derfft(real(et_cir(Jk,1)))+i*derfft(imag(et_cir(Jk,1)));
end
if ell==0
    etp_cir = []; zets_cir = [];
end
et   =  [eto  ; et_cir];
etp  =  [etop ; etp_cir];
zet  =  [zets ; zets_cir];
%%
figure
hold on
box on
for k=1:m+ell+1
    crv = et((k-1)*n+1:k*n,1); crv(n+1)  =  crv(1);crv(abs(crv)>10)=NaN+i*NaN;
    plot(real(crv),imag(crv),'k','LineWidth',1.2)
end
crv = et(1:n/2,1); 
plot(real(crv),imag(crv),'b','LineWidth',1.2)
crv = et(n/2+1:n,1); 
plot(real(crv),imag(crv),'r','LineWidth',1.2)
plot(real(alpha),imag(alpha),'dr','MarkerFaceColor','r')
axis equal
axis([-1.05  1.05  -1.05  1.05])
% axis off
grid on
set(gca,'LooseInset',get(gca,'TightInset'))
% print -depsc strip_fig_domi
% print -dpdf  strip_fig_domi
%%
figure;
hold on
box on
for k=1:m+1
    crv = zets((k-1)*n+1:k*n,1); crv(n+1)  =  crv(1);crv(abs(crv)>10)=NaN+i*NaN;
    plot(real(crv),imag(crv),'k','LineWidth',1.2)
end
for k=1:ell
    crv = zets_cir((k-1)*n+1:k*n,1); crv(n+1)  =  crv(1);crv(abs(crv)>10)=NaN+i*NaN;
    plot(real(crv),imag(crv),'k','LineWidth',1.2)
end
crv = zets(1:n/2,1); 
plot(real(crv),imag(crv),'b','LineWidth',1.2)
crv = zets(n/2+1:n,1); 
plot(real(crv),imag(crv),'r','LineWidth',1.2)
plot(real(alphas),imag(alphas),'dr','MarkerFaceColor','r')
axis equal
axis([-3.0 3.0 -1.65 1.65])
% axis off
grid on
set(gca,'LooseInset',get(gca,'TightInset'))
% print -depsc strip_fig_dom
% print -dpdf  strip_fig_dom2
%%
figure;
hold on
box on
for k=1:m+1
    crv = zetc((k-1)*n+1:k*n,1); crv(n+1)  =  crv(1);crv(abs(crv)>10)=NaN+i*NaN;
    plot(real(crv),imag(crv),'k','LineWidth',1.2)
end
for k=1:ell
    crv = zetc_cir((k-1)*n+1:k*n,1); crv(n+1)  =  crv(1);crv(abs(crv)>10)=NaN+i*NaN;
    plot(real(crv),imag(crv),'r','LineWidth',1.2)
end
crv = zetc(1:n/2,1); 
plot(real(crv),imag(crv),'b','LineWidth',1.2)
crv = zetc(n/2+1:n,1); 
plot(real(crv),imag(crv),'r','LineWidth',1.2)
axis equal
axis([-1.05  1.05  -1.05  1.05])
% axis off
grid on
set(gca,'LooseInset',get(gca,'TightInset'))
% print -depsc strip_fig_dom
% print -dpdf  strip_fig_dom
%%

%%
thet = zeros(size(et)); 
thet((m+1)*n+1:(m+1+ell)*n) = pi/2;
A    = exp(-i.*thet).*(et-alpha);
gam  = zeros(size(et)); 
for k=2:m+1
    J  = (k-1)*n+1:k*n;
    gam(J) = (-1/pi).*carg((1-et(J))./(1+et(J)));
end
for k=m+2:m+ell+1
    J  = (k-1)*n+1:k*n;
    gam(J) = (1/pi).*log(abs((1-et(J))./(1+et(J))));
end
%
[mu , h ]  =  fbie(et,etp,A,gam,n,5,[],1e-12,100);
c          = -mean(h(1:n));
gnet        = (gam+h+i.*mu)./A;
fnet        = (et-alpha).*gnet+c;
for k=1:m+ell+1
    avh(k,1) = mean(h((k-1)*n+1:k*n));
end
for k=1:m
    delta(k,1) =avh(k+1,1)+c+0.5;
end
for k=m+1:m+ell
    delta(k,1) = avh(k+1,1);
end
%%

%%
wx   =  linspace(-1,1,nop);
wy   =  linspace(-1,1,nop);
wv  =  ones(nop,1)*wx;
wv  =  wv(:)+1i*repmat(wy',nop,1);
[ny , nx ] = size(wv)
sum(sum(abs(wv)>=0))
%
wv(abs(wv)>=1) = NaN+i*NaN;
for k=2:m+ell+1
    tic
    ct    =  et(1+(k-1)*n:k*n);
    node  =  [real(ct)  imag(ct)];
    for j=1:nx
        point = [real(wv(:,j)) imag(wv(:,j))];
        [in(:,j),on(:,j)] = inpoly(point,node);
    end
    wv(in) = NaN+i*NaN;
    wv(on) = NaN+i*NaN;
    toc
end
%
w         =  NaN(nop)+i*NaN(nop);
w(:)      =  wv;
iszin     =  abs(wv)>=0;
noz_in    =  nnz(iszin)
zvin      =  wv(iszin>0);
%
if m>0
    fmet    =  map.fmet;
    foi     =  map.foi;
    fmz     =  fcau(eto,etop,fmet,zvin(:).');
    wv      =  Phi(zvin)+(zvin-alpha).*fmz(:)-(i-alpha)*foi;
else
    wv      =  Phi(zvin);
end
%
wvall   =  NaN(nop^2,1)+i*NaN(nop^2,1);
wvall(iszin>0) = wv;
z     =  NaN(nop)+i*NaN(nop);
z(:)  =  wvall;
%%
fnzv    =  fcau(et,etp,fnet,zvin(:).');
uzv    =  real(fnzv(:))+(1/pi).*imag(log((1-zvin(:))./(1+zvin(:))))+0.5;
uzvall =  NaN(nop^2,1);
uzvall(iszin>0) = uzv;
uz     =  zeros(nop);
uz(:)  =  uzvall;
%%
u.uz    =  uz;
u.w     =  w;
u.m     =  m;
u.ell   =  ell;
u.et    =  et;
u.etp   =  etp;
u.zet   =  zet;
u.alpha =  alpha;
u.z     =  z;
u.delta =  delta;
u.fet   =  fnet;
end