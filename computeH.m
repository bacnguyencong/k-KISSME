function H = computeH(n, ib, ie)
%% Compute the kernel matrix H 
% INPUT
%    n: the number of training examples
%   ib: indices of the first terms in pairs
%   ie: indices of the second terms in pairs
% OUTPUT
%    H: the matrix H that satisfies Sigma = 1/n*X*H*X'
%-------------------------------------------------------------------------%
% author: Bac Nguyen (bac.nguyencong@ugent.be)
%-------------------------------------------------------------------------%

    B = zeros(n,1);
    E = zeros(n,1);
    W = zeros(n,n);
    
    B(ib) = arrayfun(@(t)nnz(ib==t), ib); B = diag(B);   
    E(ie) = arrayfun(@(t)nnz(ie==t), ie); E = diag(E);
    
    for i=1:length(ib)
        W(ib(i),ie(i)) = W(ib(i),ie(i)) + 1;
    end    
    H = B + E - W' - W;    
end