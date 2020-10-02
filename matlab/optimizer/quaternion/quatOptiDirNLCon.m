function [qrOpti, qdOpti, optival, time] = quatOptiDirNLCon(...
    Q, initialSolution)
% QUATOPTIDIRNLCON  Solve dual quaternion problem for 6D motion
% with fast optimization and with an optional initial solution.

% default arguments
if nargin < 2
    x0 = [1;0;0;0; 0;0;0;0];
else
    x0 = initialSolution;
end

% solve problem using SQP
options = optimoptions('fmincon', ...
    'SpecifyObjectiveGradient', true, ...
    'Algorithm', 'sqp', ...
    'Display', 'off');

tic
[x, f] = fmincon(...
    @(x)quadraticFunction(x, Q), ...
    x0, ...
    [],[],[],[],[],[], ...
    @quatNLCon, options);
time = toc;

% generate output
qrOpti = quaternion(x(1:4)');
qdOpti = quaternion(x(5:8)');
optival = f;

end
