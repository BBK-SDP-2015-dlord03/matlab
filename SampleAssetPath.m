%
% Plot discrete sample paths
%

% seed the random number generator
randn('state'); 

clf % clear figure window

S = 1; 
mu = 0.05; 
sigma = 0.015; 
L = 1e2; 
T = 1; 
dt = T/L; 
M = 1;

% Time intervals from 0 to T in steps of dt
tvals = 0:dt:T;

Svals = S*cumprod(exp((mu-0.5*sigma^2)*dt + sigma*sqrt(dt)* randn(M, L)),2);
Svals = [S*ones(M, 1) Svals];  % add initial asset price

plot(tvals,Svals)
title('Asset Path')
xlabel('t'), ylabel('S(t)')