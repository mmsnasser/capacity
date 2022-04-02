function plotdomain (Coefs , Coefc , alphas , n )
%
%
%
%%
if isempty(Coefs)==0
    av    =  Coefs(:,1);  
    bv    =  Coefs(:,2);
    m     =  length(av);
else
    av    =  [];  
    bv    =  [];
    m     =  0;
end
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
for k=1:ell
    zets_cir((k-1)*n+1:k*n,1)  =  circent(k)+cirrad(k).*exp(-i.*t);
end
if ell>0
    zetc_cir = Phiv(zets_cir);
end
%%
figure;
plot([-4 4],[-pi/2  -pi/2],'k','LineWidth',1.2)
hold on
plot([-4 4],[+pi/2  +pi/2],'k','LineWidth',1.2)
for k=1:m
    plot(real([av(k),bv(k)]),imag([av(k),bv(k)]),'b','LineWidth',1.2)
end
for k=1:ell
    crv = zets_cir((k-1)*n+1:k*n,1); crv(n+1)  =  crv(1);crv(abs(crv)>10)=NaN+i*NaN;
    plot(real(crv),imag(crv),'r','LineWidth',1.2)
end
plot(real(alphas),imag(alphas),'pk','MarkerFaceColor','k')
axis equal
grid on
end