function Dist = dissimilarity( X, Y, S, XTr, sigma, EPS)
% compute the distances between two sets of column vectors
% INPUT
%   X:     (d x n1)
%   Y:     (d x n2)
%   S:     the dissimilarity structure
%   XTr: (d x n) the training examples
%   sigma: the kernel parameter
%   EPS:   the egularization parameter
%   
% OUTPUT
%   Dist: the dissimilarities between X and Y
%-------------------------------------------------------------------------%
% author: Bac Nguyen (bac.nguyencong@ugent.be)
%-------------------------------------------------------------------------%

    C   = (S{1}.n/(EPS(1)^2))*S{1}.T - (S{2}.n/(EPS(2)^2))*S{2}.T;    

    X2  = diag(kernelmatrix('rbf',X,X,sigma));
    Y2  = diag(kernelmatrix('rbf',Y,Y,sigma));
    XY  = kernelmatrix('rbf',X,Y,sigma);
    
    % first part
    Dist = bsxfun(@plus,X2,bsxfun(@plus,-2*XY,Y2'));
    
    % second part
    X   = kernelmatrix('rbf',XTr,X,sigma);
    Y   = kernelmatrix('rbf',XTr,Y,sigma);
    
    Dist = (S{2}.n/EPS(2)-S{1}.n/EPS(1))*Dist + sqdist(X,Y,C);    
end