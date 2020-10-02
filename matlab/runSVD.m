function [rErrors, tErrors, results, times] = runSVD(...
    filenameA, filenameB, q, nRuns)
% RUNSVD  Run SVD calibration for input files with ego motion data.

% default arguments
if nargin < 4
    nRuns = 1;
end

% output variables
rErrors = zeros(1,nRuns);
tErrors = zeros(1,nRuns);
results = zeros(8,1,nRuns);
times = zeros(1,nRuns);

% separate real and dual part
qr = q(1);
qd = q(2);

% create T matrix for svd approach
T = quatSVDconstructT(filenameA, filenameB, false);

% repeat nRuns times
for i=1:nRuns
    
    % svd solution
    [qrSVD, qdSVD, ~, time] = quatSVD(T);
    [erSVD, etSVD] = dualQuatDistance(qr, qd, qrSVD, qdSVD, 'deg');

    % store results
    % only the first error entry is relevant
    % all other entries contain additional information
    rErrors(i) = erSVD(1);
    tErrors(i) = etSVD(1);
    results(:,1,i) = [compact(qrSVD), compact(qdSVD)];
    times(i) = time;

end

end
