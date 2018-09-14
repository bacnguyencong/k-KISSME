function C = kernel(e, S, D, K, pmetric)
%% compute the matrix C
% INPUT
%   e: epsilon for the regularizer
%   S: similar pairs in column
%   D: dissimilarpars in column
%   K: the kernel matrix
%   pmetric: Is it a metric?
% OUTPUT
%   C: the matrix used for kernel
    n  = size(K,1);
    n1 = size(S,2); n0 = size(D,2);
    H0 = computeH(n,D(1,:),D(2,:));
    H1 = computeH(n,S(1,:),S(2,:));    
    C  = computeT(n0,e,H0,K)-computeT(n1,e,H1,K);
    if pmetric, C  = projectPSD(C); end;
end

function I = computeT(n, e, H, K)
%% compute the inverse of (eI +(1-e) )    
    I = (1/(n*e^2))*H*inv(eye(size(K))+(1/(n*e))*K*H);
end