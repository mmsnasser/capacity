function f = halfslitmap (Lc , Lk , thetk , n )
%
% Nasser, June 11, 2019
% Given an unbounded multiply connected domain Omega of connectivity m+1
% consists of m slits in the lower half-plan where
% Lc: is a vector of the center points of these slits
% Lc: is a vector of the length of these slits
% thetk: is a vector of the angles between these slits and the positive
% real line.
% 
% This function computes: zet , zetp , cent , wet; i.e., a preimage 
% bounded multiply connected circular domain G border by m circles 
% interior to the unit circle:
% zet: the parametruzation of the circles. 
% zetp: the derivative of et.
% cent: the center of the circles
% wzet: the boundary values of the conformal mapping from G onto Omega,
% 
% 
% n: the number of discretization points in each boundary component of G
% tolerance: is the tolerance of the iterative method
% Maxiter: is the maximum number of iterations for the iterative method
%
%
% This code of computing the preimage domain G and the conformal mapping
% is based on the iterative method presented in Section 4 in the paper:
% M. Nasser and C. Green, A fast numerical method for ideal fluid flow 
% in domains with multiple stirrers, Nonlinearity 31 (2018) 815-837.
% 
%%
tolerance  =  1e-12;
Maxiter    =  100;
%
t             =   (0:2*pi/n:2*pi-2*pi/n).'; 
%
Phi   = @(z)(  i+2./(z+i));
Phip  = @(z)(   -2./(z+i).^2);
%
Phii  = @(w)(-i+2./(w-i));
Phiip = @(w)(  -2./(w-i).^2);
%
m             =   length(thetk);
thet(1:n,1)   =   0;
for k=2:m+1
    thet(1+(k-1)*n:k*n,1)  =  thetk(k-1);
end
Lc = [0;Lc]; Lk = [0;Lk]; thetk = [0;thetk]; centk(1,1) = 0; radk(1,1) = 0;
centh    =  Lc;
radh     =  0.2.*Lk;
%
zet(1:n,1)   =   exp(i.*t);
zetp(1:n,1)  =   i.*exp(i.*t);
err = inf;
itr = 0;
alpha   =  0;
while (err>tolerance)
    itr  =itr+1;  
    %
    for k=2:m+1
        centc(k) = -i+2*conj(centh(k)-i)/(abs(centh(k)-i)^2-radh(k)^2);
        radc(k)  =  2*radh(k)/abs(abs(centh(k)-i)^2-radh(k)^2);    
    end    
    %
    for k=2:m+1
        zet(1+(k-1)*n:k*n,1)  =  centc(k)+radc(k).*exp(-i.*t);
        zetp(1+(k-1)*n:k*n,1) =       -i.*radc(k).*exp(-i.*t);    
    end    
    %    
    A            =  exp(i.*(pi/2-thet)).*zet;
    gam(1:n,1)   =   0;
    for k=2:m+1
        gam((k-1)*n+1:k*n,1)=imag(exp(-i*thet((k-1)*n+1:k*n,1)).*Phi(zet((k-1)*n+1:k*n,1))); 
    end
    %
    [mun , h ]   =  fbie(zet,zetp,A,gam,n,5,[],5e-14,100);
    h0           =  sum(h(1:n,1))/n;
    %
    phizet       = (gam+h+i.*mun)./A;
    et           = (Phi(zet)+zet.* phizet+i*h0)/(1-h0);
    %    
%     figure;
%     hold on
%     for k=1:m+1
%         crv = zet(1+(k-1)*n:k*n);
%         plot(real(crv),imag(crv))
%     end
%     drawnow;
%     figure;
%     hold on
%     for k=1:m+1
%         crv = wet(1+(k-1)*n:k*n);
%         plot(real(crv),imag(crv))
%     end
%     axis([-2 2 -2 2])
%     drawnow;      
    rotwn         =  exp(-i.*thet).*et;
    for k=2:m+1
        wnL         =  rotwn((k-1)*n+1:k*n,1);
        centk(k,1)  =  exp(i.*thetk(k)).*((max(real(wnL))+min(real(wnL)))/2+i.*(max(imag(wnL))+min(imag(wnL)))/2);     
        radk(k,1)   =  max(real(wnL))-min(real(wnL)); 
    end
    centh  =  centh-1.0.*(centk-Lc);
    radh   =  radh -0.2.*(radk-Lk);
    %
    err    = (norm(centk-Lc,1)+norm(radk-Lk,1))/(m);
    [itr err]
    error (itr,1) = err;
    itrk  (itr,1) = itr;    
    %
    if err>1e1
        disp('The slits are close to each other!')
        break;
    end
    if (itr>=10 & error(itr)>error(itr-1))
        disp(['The iterative method truncated after  ',num2str(itr),...
            '  iterations, with error  ',num2str(err)])
        break;
    end    
    if itr>=Maxiter
        disp('No convergence after Maximunm number of iterations')
        break;
    end
    
%     figure;
%     hold on
%     for k=1:m+1
%         crv = zet(1+(k-1)*n:k*n);
%         plot(real(crv),imag(crv))
%     end
%     drawnow;
end
%
centc(1) = 0;
radc(1)  = 1;
for k=2:m+1
    centc(k) = -i+2*conj(centh(k)-i)/(abs(centh(k)-i)^2-radh(k)^2);
    radc(k)  =  2*radh(k)/abs(abs(centh(k)-i)^2-radh(k)^2);    
end
%
for k=2:m+1
    zet(1+(k-1)*n:k*n,1)  =  centc(k)+radc(k).*exp(-i.*t);
    zetp(1+(k-1)*n:k*n,1) =       -i.*radc(k).*exp(-i.*t);    
end    
%    
A       =  exp(i.*(pi/2-thet)).*zet;
gam(1:n,1)   =   0;
for k=2:m+1
    gam((k-1)*n+1:k*n,1)=imag(exp(-i*thet((k-1)*n+1:k*n,1)).*Phi(zet((k-1)*n+1:k*n,1))); 
end
%
[mun , h ]    =  fbie(zet,zetp,A,gam,n,5,[],1e-14,100);
h0            =  sum(h(1:n,1))/n;
%
phizet        = (gam+h+i.*mun)./A;
et            = (Phi(zet)+zet.* phizet+i*h0)/(1-h0);   
%
for k=1:m+1  
    Jk        = (k-1)*n+1:k*n;
    zph(Jk,1) =  zet(Jk,1).*phizet(Jk,1);
    zphizetp(Jk,1) = derfft(real(zph(Jk,1)))+i*derfft(imag(zph(Jk,1)));
end
%
y = Phii(et);
for k=1:m+1  
    Jk        = (k-1)*n+1:k*n;
    yp(Jk,1) = derfft(real(y(Jk,1)))+i*derfft(imag(y(Jk,1)));
end
etp = yp./Phiip(et);
%
f.zet    =  zet;
f.zetp   =  zetp;
f.cent   =  centc;
f.rad    =  radc;
f.et     =  et;
f.etp    =  etp;
f.n      =  n;
f.zphi   =  zet.*phizet;
f.zphip  =  zphizetp;
f.h0     =  h0;
end