function [qrOut, qdOut] = dualQuatMult(qr1, qd1, qr2, qd2)
% DUALQUATMULT  Multiply two dual quaternions.

qrOut = quaternion(qr1) * quaternion(qr2);
qdOut = quaternion(qr1) * quaternion(qd2) + quaternion(qd1) * quaternion(qr2);

end
