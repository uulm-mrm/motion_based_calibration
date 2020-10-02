function [qrOut, qdOut] = dualQuatConj(qrIn, qdIn)
% DUALQUATCONJ  Conjugate dual quaternion.

qrOut = conj(quaternion(qrIn));
qdOut = conj(quaternion(qdIn));

end
