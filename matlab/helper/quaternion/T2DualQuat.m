function [qr, qd] = T2DualQuat(T)
% T2DUALQUAT  Convert homogeneous transformation matrix
% to dual quaternion.

R = T(1:3,1:3);
t = T(1:3,4);
qr = quaternion(R, 'rotmat', 'point');

qt = quaternion([0, t']);
qd = 0.5 * qt * qr;

end
