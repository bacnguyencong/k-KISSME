clc; clear;

addpath('helps');
rng('default');
load('viper/viper_features.mat');

EPS   = 0.001;% the regularization constant
sigma = 2^-16; % the kernel width
N     = 632;  % number of persons
d     = 100;  % number of features

idxa = double(idxa); % index of images in the first set
idxb = double(idxb); % index of images in the second set
X    = ux(1:d,:);    % training set

% draw random permuation 
perm = randperm(N);

% split in equal-sized train and test sets
idxtrain = perm(1:N/2);
idxtest  = perm(N/2+1:end);

%--------------------------------------------------------------
% BEGIN k-KISSME
    first_ind   = [idxa(idxtrain) idxa(idxtrain)];
    second_ind  = [idxb(idxtrain) idxb(idxtrain(randperm(N/2)))];    
    matches = logical([ones(1,size(idxtrain,2)) zeros(1,size(idxtrain,2))]);
    
    S = [first_ind(matches);second_ind(matches)];    % must-link constraints
    D = [first_ind(~matches); second_ind(~matches)]; % cannot-link constraints
    
    K  = kernelmatrix('rbf',X,[], sigma); % compute the kernel matrix
    M  = kernel(EPS,S,D,K,1); % learn k-KISSME
% END k-KISSME
%---------------------------------------------------------------

% test rank-1 matching rate
cmc{1} = calcMCMC(eye(d),X,idxa,idxb,idxtest);
cmc{2} = calcMCMC(M,K,idxa,idxb,idxtest);

s = length(idxtest);
fprintf('Rank-1 matching rate:\n');
fprintf('IDENTITY = %.2f\nk-KISSME = %.2f\n', 100*cmc{1}(1)/s, 100*cmc{2}(1)/s);
