function [K,sigma] = kernelmatrix(ker,X,X2,sigma, b, d)
% With Fast Computation of the RBF kernel matrix
% To speed up the computation, we exploit a decomposition of the Euclidean distance (norm)
%
% Inputs:
%       ker:    'lin','poly','rbf','sam'
%       X:      (d x n) input data
%       X2:     (d x m) test data
%       sigma:  width of the RBF kernel
%       b:      bias in the linear and polinomial kernel
%       d:      degree in the polynomial kernel
%
% Output:
%       K: kernel matrix

switch ker
    case 'lin'    
        if exist('X2','var')&&~isempty(X2);
            K = X' * X2;
        else
            K = X' * X;
        end
        
    case 'chi2'
        K = zeros(size(X,2),size(X2,2));
        for i =1:size(X2,2)
            dotp   = bsxfun(@times,X, X2(:,i));
            sump   = bsxfun(@plus, X, X2(:,i));
            K(:,i) = 2*sum(dotp./(sump+1e-10),1);
        end
        
    case 'expchi2'
        K = zeros(size(X,2),size(X2,2));
        for i=1:size(X2,2)
            d = bsxfun(@minus, X, X2(:,i));
            s = bsxfun(@plus, X, X2(:,i));
            K(:,i) = sum(d.^2./(s+eps), 1);
        end
        if ~exist('sigma','var')
            sigma = mean(mean(K));
        end
        K  = exp(- 1/(2*sigma) .* K);
        
    case 'poly'
        if exist('X2','var')
            K = (X' * X2 + b).^d;
        else
            K = (X' * X + b).^d;
        end
        
    case 'rbf'
        n1sq = sum(X.^2,1);
        n1 = size(X,2);

        if isempty(X2);
            K = (ones(n1,1)*n1sq)' + ones(n1,1)*n1sq -2*(X'*X);
        else
            n2sq = sum(X2.^2,1);
            n2 = size(X2,2);
            K = (ones(n2,1)*n1sq)' + ones(n1,1)*n2sq -2*X'*X2;
        end;
        K = exp(-K*sigma);

    case 'sam'
        if exist('X2','var');
            K = X'*X2;
        else
            K = X'*X;
        end
        K = exp(-acos(K).^2/(2*sigma^2));
        
    otherwise
        error(['Unsupported kernel ' ker])
end
