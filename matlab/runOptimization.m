function [rErrors, tErrors, results, times] = runOptimization(...
    data, nRuns, isPlanar)
% RUNOPTIMIZATION  Run matrix, fast DQ and global DQ optimization
% multiple times for previously generated cost matrices.

% default arguments
if nargin < 3
    isPlanar = false;
end
if nargin < 2
    nRuns = 1;
end

% output variables
rErrors = zeros(3,nRuns);
tErrors = zeros(3,nRuns);
results = zeros(8,3,nRuns);
times = zeros(3,nRuns);

% separate real and dual part
qr = data.q(1);
qd = data.q(2);

% repeat nRuns times
for i=1:nRuns
    
    % matrix approach (only for non-planar case)
    if ~isPlanar
        [TMatrix, ~, timeMatrix] = matOptiLag(data.Qmat);
        [qrMatrix, qdMatrix] = T2DualQuat(TMatrix);
        [erMatrix, etMatrix] = dualQuatDistance(qr, qd, qrMatrix, qdMatrix, 'deg');
    else
        erMatrix = inf;
        etMatrix = inf;
        timeMatrix = inf;
        qrMatrix = quaternion(inf(1,4));
        qdMatrix = quaternion(inf(1,4));
    end

    % global dual quaternion approach
    [qrDQGlob, qdDQGlob, ~, timeDQGlob] = quatOptiLag(data.Q, isPlanar);
    [erDQGlob, etDQGlob] = dualQuatDistance(qr, qd, qrDQGlob, qdDQGlob, 'deg');
    
    % fast dual quaternion approach
    if isPlanar
        [qrDQFast, qdDQFast, ~, timeDQFast] = quatOptiDirNLPlaneCon(data.Q);
    else
        [qrDQFast, qdDQFast, ~, timeDQFast] = quatOptiDirNLCon(data.Q); 
    end
    [erDQFast, etDQFast] = dualQuatDistance(qr, qd, qrDQFast, qdDQFast, 'deg');

    % store results
    % only the first error entry is relevant
    % all other entries contain additional information
    rErrors(:,i) = [erMatrix(1), erDQGlob(1), erDQFast(1)];
    tErrors(:,i) = [etMatrix(1), etDQGlob(1), etDQFast(1)];
    results(:,1,i) = [compact(qrMatrix), compact(qdMatrix)];
    results(:,2,i) = [compact(qrDQGlob), compact(qdDQGlob)];
    results(:,3,i) = [compact(qrDQFast), compact(qdDQFast)];
    times(:,i) = [timeMatrix, timeDQGlob, timeDQFast];

end

end
