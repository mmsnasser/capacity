function  fpz  = fcaup (et,etp,fetp,z,n,finf)
%
%
% This function is a modified version of the MATLAB function "fcau.m".
% The function compute: fpz=f'(z) where fetp = f'(et).*etp
iprec =  4;
vz    = [real(z) ; imag(z)];       % target
nz    = length(z);                 % ntarget
a     = [real(et.') ; imag(et.')]; % source
tn    = length(et);                % nsource=(m+1)n
bf    = fetp.';
[Uf]  = zfmm2dpart(iprec,tn,a,bf,0,0,0,nz,vz,1,0,0);
b1    = [etp].';
[U1]  = zfmm2dpart(iprec,tn,a,b1,0,0,0,nz,vz,1,0,0);
if( nargin == 4 ) 
    fpz    = (Uf.pottarg)./(U1.pottarg);
end
if( nargin == 6 ) 
    fpz= (finf-(Uf.pottarg)./(n*i))./(1-(U1.pottarg)./(n*i));
end
end
