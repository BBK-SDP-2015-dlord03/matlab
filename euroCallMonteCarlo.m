function [ C ] = euroCallMonteCarlo( S, K, r, sigma, tau, N )
% Input arguments: S = asset price at time t
%                  K = Strike price
%                  r = interest rate
%                  sigma = volatility
%                  tau = time to expiry (T-t) 
%                  N = number of simulations
% Outputs: C = Call Value
%
% Example call:
% c = euroCallMonteCarlo(100, 100, 0.05, 0.2, 1, 1000)

% Seed the random number generator to repeat
randn('state', 0); 

% Generate a range of final asset prices
final_S = S * exp((r - 0.5 * sigma ^ 2) * tau + sigma * sqrt(tau) * randn(N,1));

% Calculate the payoffs for each of these final prices
final_payoff = max(final_S - K, 0);

% Find the present value of these payoffs
present_payoff = exp(-r * tau) * final_payoff;

% Find the average value of the present payoffs
C = mean(present_payoff);

end

