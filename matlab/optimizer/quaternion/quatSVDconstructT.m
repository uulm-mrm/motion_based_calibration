function [T] = quatSVDconstructT(filenameA, filenameB, isMat)
% QUATSVDCONSTRUCTT Construct matrix T for SVD based calibration
% for per-sensor ego-motion of two input files.
%   isMat: Input files provide matrices instead of dual quaternions.

% default arguments
if nargin < 3
    isMat = false;
end

% read transformations from files
fA = fopen(filenameA, 'r');
fB = fopen(filenameB, 'r');

if isMat
    formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f';
    TAmat = fscanf(fA, formatSpec, [12, Inf])';
    TBmat = fscanf(fB, formatSpec, [12, Inf])';
    
    % convert matrices to dual quaternions
    sA = size(TAmat);
    sB = size(TBmat);
    
    TA = zeros(sA(1), 8);
    TB = zeros(sB(1), 8);
    
    for i=1:sA(1)
        [qra, qda] = T2DualQuat(reshape([TAmat(i,:),0,0,0,1], 4, 4)');
        TA(i,1:4) = compact(qra);
        TA(i,5:8) = compact(qda);
    end
    
    for i=1:sB(1)
        [qrb, qdb] = T2DualQuat(reshape([TBmat(i,:),0,0,0,1], 4, 4)');
        TB(i,1:4) = compact(qrb);
        TB(i,5:8) = compact(qdb);
    end
    
else
    formatSpec = '%f %f %f %f %f %f %f %f';
    TA = fscanf(fA, formatSpec, [8, Inf])';
    TB = fscanf(fB, formatSpec, [8, Inf])';
end

% check size
sA = size(TA);
sB = size(TB);

if sA ~= sB
    error('sizes must match')
end


% function for cross matrix [a]_x
function mat = crossMatrix(a)
    mat = zeros(3,3);
    mat(1,2) = -a(3);
    mat(1,3) = a(2);
    mat(2,1) = a(3);
    mat(2,3) = -a(1);
    mat(3,1) = -a(2);
    mat(3,2) = a(1);
end


% create output matrix T
nFrames = sA(1);
T = zeros(6*nFrames, 8);

% iterate frames and fill T
for i=1:nFrames
    
    % create matrix S for each frame
    a = TA(i,2:4);
    as = TA(i,6:8);
    b = TB(i,2:4);
    bs = TB(i,6:8);

    S = zeros(6,8);
    S(1:3,1) = a - b;
    S(1:3,2:4) = crossMatrix(a + b);
    S(4:6,1) = as - bs;
    S(4:6,2:4) = crossMatrix(as + bs);
    S(4:6, 5) = a - b;
    S(4:6, 6:8) = crossMatrix(a + b);
    
    % add S to output T
    start = (i-1) * 6 + 1;
    T(start:start+5,:) = S;
    
end

end
