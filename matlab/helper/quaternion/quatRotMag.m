function [rotMagnitude] = quatRotMag(q, unit, cyclicMag)
% QUATROTMAG  Calculate rotation magnitude of a quaternion.
%   Use 'deg' as unit for degree output, otherwise radians are used.
%   Set cyclicMag to 1 for normalizing the output
%     to [-pi,pi) or [-180,180).

% default arguments
if nargin < 2
    unit = 'rad';
end
if nargin < 3
    cyclicMag = 1;
end

% using compact and quaternion allows both
% input as array and as quatenion
q = compact(quaternion(q));

% magnitude
rotMagnitude = 2 * atan2(norm(q(2:4)), q(1));

% normalize to range [-pi, pi)
if cyclicMag && ~isinf(rotMagnitude)
    rotMagnitude = mod(rotMagnitude + pi, 2*pi) - pi;
end

% convert to degree
if strcmp(unit, 'deg')
    rotMagnitude = rad2deg(rotMagnitude);
end

end
