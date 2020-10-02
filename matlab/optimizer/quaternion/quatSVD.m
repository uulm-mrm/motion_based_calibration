function [qrOpti, qdOpti, optival, time] = quatSVD(T)
% QUATSVD Estimate calibration with SVD appraoch.
%   The algorithm is based on:
%   K. Daniilidis, "Hand-Eye Calibration Using Dual Quaternions",
%   The International Journal of Robotics Research, vol. 18, no. 3, 
%   pp. 286-298, 1999

% start timing
tic

% perform svd
[~, ~, vec] = svd(T, 'econ');
v1Pos = 7;
v2Pos = 8;


% split right-singular vectors corresponding to the two smallest
% singular values and ensure u1' * v1 ~= 0
u1 = vec(1:4,v1Pos);
v1 = vec(5:8,v1Pos);
u2 = vec(1:4,v2Pos);
v2 = vec(5:8,v2Pos);

if abs(u1' * v1) < 0.0001
    u2 = u1;
    v2 = v1;
    u1 = vec(1:4,v2Pos);
    v1 = vec(5:8,v2Pos);
end


% a,b,c of eq 34
a1 = u1' * u1;
b1 = 2 * u1' * u2;
c1 = u2' * u2;

% a,b,c of eq 35
a2 = u1' * v1;
b2 = u1' * v2 + u2'* v1;
c2 = u2' * v2;

% solve eq 35
disc2 = sqrt(b2^2 - 4 * a2 * c2);
s1 = (-b2 + disc2) / (2*a2);
s2 = (-b2 - disc2) / (2*a2);

% select s corresponding two largest value of eq 34
value1 = s1^2 * a1 + s1 * b1 + c1;
value2 = s2^2 * a1 + s2 * b1 + c1;

if value1 > value2
    s = s1;
    value = value1;
else
    s = s2;
    value = value2;
end

% calculate lambdas from s
l2 = sqrt(1/value);
l1 = s * l2;

% create real and dual quaternions
qr = l1 * u1 + l2 * u2;
qd = l1 * v1 + l2 * v2;
qrOpti = quaternion(qr');
qdOpti = quaternion(qd');

% generate other outputs
time = toc;
optival = -1;

end
