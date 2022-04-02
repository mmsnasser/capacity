function fpw = gradu_of_z (w,et,etp,fet,mell)
%
%
%
%
n     = length(et)/(mell+1);
% 
%
wv1  = w(:).';
wv   = wv1(abs(wv1)>=0);
% 
% 
% Compute f'(w): the values of the derivative of the function f where u=Re
% f where fetp = f'(et)*etp (on the whole boundary)
%
for k=1:mell+1      
    Jk  = (k-1)*n+1:k*n;
    fpet(Jk,1) = derfft(real(fet(Jk,1)))+i*derfft(imag(fet(Jk,1)));
end
fpwv    =  fcaup(et,etp,fpet,wv);
fpwv1   =  NaN(size(wv1));
fpwv1(abs(wv1)>=0) = fpwv;
fpw   = (1+i).*NaN(size(w));
fpw(:)= fpwv1;
%
end