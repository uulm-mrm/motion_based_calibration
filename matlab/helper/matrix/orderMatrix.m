function out = orderMatrix(d)
% ORDERMATRIX  Order the three entries in d such that
% the result 3x3 matrix can be used to construct a special 
% matrix in the optimization problem.

out = [
     0,    -d(3),  d(2);
     d(3),  0,    -d(1);
    -d(2),  d(1),  0
];

end
