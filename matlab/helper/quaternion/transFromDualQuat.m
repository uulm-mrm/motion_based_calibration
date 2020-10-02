function [qt] = transFromDualQuat(q1, q2)
% TRANSFROMDUALQUAT  Calculate translation quaternion from dual quaternion.
%   qt = TRANSFROMDUALQUAT(q) takes a dual quaternion vector.
%   qt = TRANSFROMDUALQUAT(qr, qd) takes real and dual quaternions.

switch nargin
    % 8d vector input
    case 1
        qr = quaternion(q1(1:4));
        qd = quaternion(q1(5:8));

    % quaternion input
    case 2
        qr = q1;
        qd = q2;

qt = qd * conj(qr) * 2;

end
