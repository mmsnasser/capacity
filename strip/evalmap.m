function w = evalmap(map,z,b)
% evalmap.m 
% Nasser, September 17, 2019
% 
% 
%
%
%
m        =  map.m;
n        =  map.n;
et       =  map.et;
etp      =  map.etp;
zet      =  map.zet;
cent     =  map.cent;
alpha    =  map.alpha;
fmet     =  map.fmet;
foi      =  map.foi;
% zphietp  =  map.zphip;
%
%
if b=='d'
    %
    aaa
    zv   = z(:).';
    wzv  = Phi(zv)+(zv-alpha).*fcau(et,etp,fmet,zv)-(i-alpha)*foi;    
    if isrow(z)==1
        w=wzv(:).';
    else
        w=wzv(:);
    end
    %
elseif b=='v'
    %
    zv     =  z(:).';
    zvc    =  Phiv(zv);
    %
    zetc    =  Phiv(zet);
    for k=1:m+1  
        Jk  = (k-1)*n+1:k*n;
        zetcp(Jk,1) = derfft(real(zetc(Jk,1)))+i*derfft(imag(zetc(Jk,1)));
    end
    %    
    wvc  = fcau(zetc,zetcp,et,zvc);
    if isrow(z)==1
        w=wvc(:).';
    else
        w=wvc(:);
    end
    %
    %
end
%
end
%%