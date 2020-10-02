function [rot, trans] = dualQuatDistance(qr1, qd1, qr2, qd2, rotunit)
% DUALQUATDISTANCE  Calculate rotation and translation distance/error
% for two dual quaternions.
%   See QUATROTMAG for the rotunit description.

% default arguments
if nargin < 5
    rotunit = 'rad';
end

% calculate difference
[qr1Con, qd1Con] = dualQuatConj(qr1, qd1);
[qrDiff, qdDiff] = dualQuatMult(qr2, qd2, qr1Con, qd1Con);

% translation error
trans = compact(transFromDualQuat(qrDiff, qdDiff));
transVec = trans(2:4);
trans = [norm(transVec), transVec];

% rotation error
rotMag = abs(quatRotMag(qrDiff, rotunit, 1));
[rotx, roty, rotz] = quat2angle(compact(qrDiff));
rot = [rotMag, rotx, roty, rotz];

end
