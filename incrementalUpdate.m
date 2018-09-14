function [Z,invZ,T,H] = incrementalUpdate(a,b,alpha,Z,invZ,T,H,K,EPS)
%% Update at position (a,b)
% INPUT
%   a: first index
%   b: second index
%   alpha: coefficient of update (-1/1)
%   Z: the matrix Z, ....
%   EPS: the regularizer parameter
%   Kx: kernel vector x'*(XTr x)
% OUTPUT
%   Z, invZ,T,H the updated matrices after adding constraints
%-------------------------------------------------------------------------%
% author: Bac Nguyen (bac.nguyencong@ugent.be)
%-------------------------------------------------------------------------%

    u = alpha*invZ*K(:,a)/(EPS+invZ(b,:)*alpha*K(:,a));
    v = invZ(b,:);%v'
    T(a,:) = T(a,:)+alpha*(1-u(b))*v;    
    T      = T -(H*u)*v;
    Z(:,b) = Z(:,b) + alpha/EPS*K(:,a);
    invZ   = invZ - u*v;
    H(a,b) = H(a,b)+alpha;
end