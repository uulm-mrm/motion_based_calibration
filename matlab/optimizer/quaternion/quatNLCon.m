function [c, ceq] = quatNLCon(x)
% QUATNLCON  Non-linear constraints for dual quaternions.

c = [];
ceq = [
    norm(x(1:4))^2 - 1, ...
    2 * (x(1)*x(5) + x(2)*x(6) + x(3)*x(7) + x(4)*x(8))
]; 

end
