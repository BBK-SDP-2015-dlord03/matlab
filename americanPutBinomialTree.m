function [ P ] = americanPutBinomialTree( S, K, r, sigma, T, n )
% Input arguments: S = asset price at time t
%                  K = Strike price
%                  r = interest rate
%                  sigma = volatility
%                  tau = time to expiry (T-t) 
%                  n = number of steps
% Outputs: P = Put Value
%
% Example call:
% p = americanPutBinomialTree(100, 100, 0.05, 0.2, 1, 100)

% Time step
dt = T / n;

% Cox, Ross, & Rubinstein (CRR) parameters
u = exp(sigma * sqrt(dt));             % up
d = 1 / u;                             % down
p = ( exp( r * dt) - d ) / ( u - d );  % probability

% Calculate asset values at T
for i = 1 : n + 1
    ST(i) = S * d ^ (i - 1) * u ^ (n - (i - 1));
end

% Calculate the payoff at T
for i = 1 : n + 1
    V(i) = max(K - ST(i), 0);
end

% Roll back through the tree (american put method)
for i = n : -1 : 1
    for j = 1: i
        % Same as Euro version (what is the basic option value
        V(j) = exp(-r * dt) * (p * V(j) + (1 - p) * V(j + 1));
        % What is the asset value here?
        Asset(j) = S * d ^ (j - 1) * u ^ (i - 1 - (j - 1));
        % Is it worth exercising now?
        V(j) = max(V(j), K - Asset(j));
    end
end

% Put value has been collapsed down into first member of array
P = V(1);

end

