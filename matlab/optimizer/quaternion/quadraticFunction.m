function [f, g] = quadraticFunction(x, Q)
% QUADRATICFUNCTION  Quadratic cost function.

f = x' * Q * x;
g = 2 * Q * x;

end
