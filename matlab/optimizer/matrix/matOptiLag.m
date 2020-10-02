function [TOpti, optival, time] = matOptiLag(Q)
% MATOPTILAG  Solve matrix optimization problem using Lagrange duality.
%   The algorithm is based on:
%   M. Giamou, Z. Ma, V. Peretroukhin, and J. Kelly,
%   "Certifiably Globally Optimal Extrinsic Calibration from Per-Sensor
%   Egomotion", IEEE Robotics and Automation Letters, vol. 4, no. 2,
%   pp. 367-374, 2019

% calculate substitution with rotation only
a = Q(1:3,  1:3);
b = Q(1:3,  4:13);
c = Q(4:13, 1:3);
d = Q(4:13, 4:13);

Qs = d - c * (a \ b);


% hide cvx warnings
warning('off', 'CVX:UnsymmetricLMI');
warning('off', 'CVX:Empty');

% solve dual problem
cvx_tic;
cvx_begin sdp quiet
    % It is intended that the LMI is unsymmetric.
    % This is necessary to formulate the right handyness for R.

    variable l(21)
    variable muu
    
    L1 = [l(1),l(6),l(5);l(6),l(2),l(4);l(5),l(4),l(3)];
    L2 = [l(7), l(12),l(11); l(12), l(8), l(10); l(11), l(10), l(9)];
    Ld123 = [l(13), l(14), l(15)];
    Ld312 = [l(16), l(17), l(18)];
    Ld231 = [l(19), l(20), l(21)];
    
    Pr = cvx(zeros(10,10));
    Pc = cvx(zeros(10,10));
    Pd = cvx(zeros(10,10));
    Ph = cvx(zeros(10,10));

    Pr(1:9, 1:9) = kron(eye(3), L1);
    Pr(10, 10)   = -sum(diag(L1));

    Pc(1:9, 1:9) = kron(L2, eye(3));
    Pc(10, 10)   = -sum(diag(L2));

    Pd(1:3, 4:6) = orderMatrix(Ld123);
    Pd(4:6, 1:3) = orderMatrix(Ld123)';
    Pd(1:3, 7:9) = -orderMatrix(Ld312);
    Pd(7:9, 1:3) = -orderMatrix(Ld312)';
    Pd(4:6, 7:9) = orderMatrix(Ld231);
    Pd(7:9, 4:6) = orderMatrix(Ld231)';

    Pd(7:9, 10)  = Ld123;
    Pd(10,  7:9) = Ld123;
    Pd(4:6, 10)  = Ld312;
    Pd(10,  4:6) = Ld312;
    Pd(1:3, 10)  = Ld231;
    Pd(10,  1:3) = Ld231;

    Ph(10,10) = -muu;

    P = Pr + Pc + Pd + Ph;
    
    minimize -muu
    subject to
        Qs + P >= 0

    Sol = Qs + P;
cvx_end;

% solver timing
timings = cvx_toc;
time = timings(5);

% The primal solution can be extracted similar to the DQ optimization.
% However, a valid solution is not found for the kitti dataset.
% Thus, we use the second optimization step to ensure a valid solution.
% The second optimization takes a similar amount of time as the
% eigenvalue decomposition for matrices.
options=optimoptions('fmincon', ...
    'SpecifyObjectiveGradient', true, ...
    'Algorithm', 'sqp', ...
    'Display', 'off');
x0 = [1;0;0; 0;1;0; 0;0;1; 1];

tic
[x, ~] = fmincon(...
    @(x)quadraticFunction(x, Sol), ...
    x0, ...
    [],[],[],[],[],[], ...
    @matrixConstraints, options);
time = time + toc;


% calculate translation from optimal rotation
ROpti = reshape(x(1:9), 3,3);
tOpti = - a\b * x;
TOpti = [ROpti, tOpti; 0,0,0,1];

optival = x' * Qs * x;

end
