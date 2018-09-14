function [Z,invZ,T,H] = addArrivalExample(Z,invZ,T,H,EPS,Kx)
%% Adding an arrival example
% INPUT
%   Z: the matrix Z
%   invZ: the inverse of Z
%   T: the matrix T
%   H: the matrix H
%   EPS: the regularizer
%   Kx: the inner product x'*(XTr x)
% OUTPUT
%   the updated values of matrices
%-------------------------------------------------------------------------%
% author: Bac Nguyen (bac.nguyencong@ugent.be)
%-------------------------------------------------------------------------%

    n   = size(Z,1);
    tmp = 1/EPS*(Kx(1:n)*H);        
    %update Z and invZ
    Z    = [Z zeros(n,1); tmp 1];
    invZ = [invZ zeros(n,1); -tmp*invZ 1];
    % update T
    T = [T zeros(n,1); zeros(1,n+1)];
    % update H
    H = [H zeros(n,1); zeros(1,n+1)];        
end