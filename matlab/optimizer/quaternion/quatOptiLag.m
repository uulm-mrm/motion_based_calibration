function [qrOpti, qdOpti, optival, time] = quatOptiLag(Q, runplanar)
% QUATOPTILAG  Solve dual quaternion problem for 6D and planar motion
% with global optimization.

% default arguments
if nargin < 2
    runplanar = false;
end

% hide cvx warnings
warning('off', 'CVX:UnsymmetricLMI');
warning('off', 'CVX:Empty');

% solve dual problem
cvx_tic;
cvx_begin sdp quiet
    % It is intended that the LMI is unsymmetric.
    % This is necessary to formulate the right handyness for R.

    if runplanar
        variable l(5)
    else
        variable l(2)
    end

    Pb = cvx(zeros(8,8));
    Pp = cvx(zeros(8,8));

    Pb(1:4, 1:4) = - l(1) * eye(4);

    Pp(1:4,5:8) = l(2) * eye(4);
    Pp(5:8,1:4) = l(2) * eye(4);

    if runplanar
        P3 = cvx(zeros(8,8));
        P4 = cvx(zeros(8,8));
        P5 = cvx(zeros(8,8));

        P3(2,2) = l(3);
        P4(3,3) = l(4);

        P5(1,8) = l(5);
        P5(8,1) = l(5);
        P5(4,5) = -l(5);
        P5(5,4) = -l(5);

        P = Pb + Pp + P3 + P4 + P5;
    else
        P = Pb + Pp;
    end

    maximize l(1)
    subject to
        Q + P >= 0

    Sol = Q + P;
cvx_end;

% calculate primal solution
[eigvec, ~] = eig(Sol);
vec = eigvec(:,1);
x = vec / norm(vec(1:4));
f = quadraticFunction(x, Q);

% solver timing
timings = cvx_toc;
time = timings(5);

% generate output
qrOpti = quaternion(x(1:4)');
qdOpti = quaternion(x(5:8)');
optival = f;

end
