function [ V ] = euroBarrierBinomialTree( S, K, r, sigma, T, n, B )
% Input arguments: S = asset price at time t
%                  K = Strike price
%                  r = interest rate
%                  sigma = volatility
%                  tau = time to expiry (T-t) 
%                  n = number of steps
%                  B = barrier price
% Outputs: V = Barrier Option Value
%
% Example call:
% v = euroBarrierBinomialTree(100, 100, 0.05, 0.2, 1, 400, 80)

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

% Calculate the payoff at T (checking the barrier)
for i = 1 : n + 1
    if (ST(i) > B) % if we're over the barrier it's normal
        V(i) = max (ST(i) - K, 0);
    else % otherwise it's worthless
        V(i) = 0;
    end
end

% Roll back through the tree (checking for barrier breach)
for i = n : -1 : 1
    for j = 1: i
        % What is the asset value here?
        Asset(j) = S * d ^ (j - 1) * u ^ (i - 1 - (j - 1));
        % If the asset value is above barrier then normal value
        if (Asset(j) > B)         
            V(j) = exp(-r * dt) * (p * V(j) + (1 - p) * V(j + 1));
        % Otherwise it's worthless
        else 
            V(j) = 0;
        end
    end
end

% Put value has been collapsed down into first member of array
V = V(1);

end

