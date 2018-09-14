function [aux, XTr, K, index, timer, CMCs] = onlineKKISSME(X,Pairs,EPS,sigma, pars)
%% update online for k-KISSME
% INPUT
%   X:       the flow of input examples
%   Pairs:   index of pairwise constraints in X, (i,j,0/1): 0 stands for 
%                                           dissimilar, 1 stands for similar
%   sigma:   the sigma for kernel
% OUTPUT
%   aux:     the structure of smilar and dissimilar
%   XTr:     the training examples
%   K:       the kernel matrix
%   index:   the indeces of arrived examples in the training set
%   timmr:   times (in sec) for each update
%   CMCs:    rank-1 matching rates
%-------------------------------------------------------------------------%
% author: Bac Nguyen (bac.nguyencong@ugent.be)
%-------------------------------------------------------------------------%

    n = size(X,2);
    m = size(Pairs,2);
    
    % start the auxiliar structure
    aux = cell(2,1);
    for i=1:2
        aux{i}.Z   = []; 
        aux{i}.invZ= []; 
        aux{i}.T   = []; 
        aux{i}.H   = [];
        aux{i}.EPS = EPS(i);
        aux{i}.n   = 0;
    end
    
    % current kernel and input matrix
    K   = [];    
    XTr = [];
    % current index of the training example
    index = zeros(n,1);
    
    timer = zeros(m,2);
    CMCs  = zeros(m,2);
    
    for i=1:m,       
        
        u = Pairs(1,i); xu = X(:,u);
        v = Pairs(2,i); xv = X(:,v);
        
        % adding a new example
        if ~index(u),
            XTr      = [XTr xu]; %Kx       = xu'*XTr;            
            Kx       = kernelmatrix('rbf',XTr,xu,sigma)'; 
            t1 = tic;
            [aux,K]    = updateDataBase(aux,Kx,K,EPS);
            timer(i,1) = timer(i,1) + toc(t1);
            index(u)   = size(XTr,2);
        end
        % adding a new example
        if ~index(v),
            XTr      = [XTr xv]; %Kx       = xv'*XTr;            
            Kx       = kernelmatrix('rbf',XTr,xv,sigma)'; %xv'*XTr;
            t2 = tic;
            [aux,K]  = updateDataBase(aux,Kx,K,EPS);
            timer(i,1) = timer(i,1) + toc(t2);
            index(v) = size(XTr,2);
        end
        t3  = tic;
        idx = Pairs(3,i) + 1; % find the similar or dissimilar update
        [aux{idx}.Z,aux{idx}.invZ,aux{idx}.T,aux{idx}.H] = ...
                             onlineUpdate(index(u),index(v),EPS(idx), ...
                                 aux{idx}.Z,aux{idx}.invZ,aux{idx}.T,aux{idx}.H,K);
        aux{idx}.n = aux{idx}.n + 1;   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        timer(i,1) = timer(i,1) + toc(t3);        
        %%% Testing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ddist     = dissimilarity(pars.xGals,pars.xPros,aux,XTr,sigma,EPS);
        tmp       = EvalCMC(-ddist, pars.yGals, pars.yPros, 10);
        CMCs(i,1) = tmp(1);        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Bruteforce
        
%         t4 = tic;        
%         ind = Pairs(3,1:i) == 1;
%         if (sum(ind)==0 || sum(~ind) ==0 ), continue; end;
%         
%         KER    = kernelmatrix('rbf',XTr,[],sigma);
%         C      = kernel(pars.EPS,index(Pairs(1:2,ind)),...
%                                  index(Pairs(1:2,~ind)),KER,1);
%         xxGals = kernelmatrix('rbf',XTr,pars.xGals,sigma);
%         xxPros = kernelmatrix('rbf',XTr,pars.xPros,sigma);
%         
%         timer(i,2) = toc(t4);
%         %%% Testing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         ddist     = sqdist(xxGals,xxPros,C);
%         tmp       = EvalCMC(-ddist,pars.yGals,pars.yPros,10);
%         CMCs(i,2) = tmp(1);       
%         fprintf('Updating (%d)...%.3f %.3f\n',i, CMCs(i,1), CMCs(i,2));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    end
end

function [aux,K] = updateDataBase(aux,Kx,K,EPS)    
    K = [K Kx(1:end-1)'; Kx];
    for i=1:2,
        [aux{i}.Z,aux{i}.invZ,aux{i}.T,aux{i}.H] = ...
            addArrivalExample(aux{i}.Z,aux{i}.invZ,aux{i}.T,aux{i}.H,EPS(i),Kx);
    end
end