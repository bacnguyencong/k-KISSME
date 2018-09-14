function M = projectPSD(M)
% project the matrix M to its cone of PSD
% INPUT
%   M: a squared matrix
% OUTPUT
%   M: the PSD matrix
%-------------------------------------------------------------------------%
% author: Bac Nguyen (bac.nguyencong@ugent.be)
%-------------------------------------------------------------------------%
    [V,D]=eig(M); V = real(V); 
    d=diag(real(D));
    d(d<=0)=eps;
    M = V*diag(d)*V';
end