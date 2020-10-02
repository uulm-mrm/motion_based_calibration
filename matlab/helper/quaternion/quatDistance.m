function [dist] = quatDistance(q1, q2, unit)
% QUATDISTANCE  Calculate rotation distance/error for two quaternions.
%   See QUATROTMAG for the unit description.

% calculate difference
qDiff = quaternion(q1) * conj(quaternion(q2));
qDiffComp = compact(qDiff);

% rotation magnitude
dist = quatRotMag(qDiffComp, unit);

end
