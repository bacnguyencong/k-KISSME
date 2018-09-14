function [Z,invZ,T,H] = onlineUpdate(a,b,EPS,Z,invZ,T,H,K)    
% Online update for one pairwise constraint
% INPUT
%   a: first index
%   b: second index
%   EPS: the regularizer parameter
%   Z: the matrix Z, inv, T, H....
%   K: the kernel matrix
% OUTPUT
%   Z, invZ,T,H the updated matrices after adding the constraint
%-------------------------------------------------------------------------%
% author: Bac Nguyen (bac.nguyencong@ugent.be)
%-------------------------------------------------------------------------%
    [Z,invZ,T,H]=incrementalUpdate(a,a,1,Z,invZ,T,H,K,EPS);
    [Z,invZ,T,H]=incrementalUpdate(b,b,1,Z,invZ,T,H,K,EPS);    
    [Z,invZ,T,H]=incrementalUpdate(a,b,-1,Z,invZ,T,H,K,EPS);
    [Z,invZ,T,H]=incrementalUpdate(b,a,-1,Z,invZ,T,H,K,EPS);
end