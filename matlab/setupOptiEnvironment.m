function setupOptiEnvironment()
% SETUPOPTIENVIRONMENT Setup the optimization environment by adding all
% necessary directories to the Matlab path.

% The matrix based calibration approach is always unsymmetric.
% Thus, the respective warning is switched off.
warning('off', 'CVX:UnsymmetricLMI');

[scriptDir, ~, ~] = fileparts(mfilename('fullpath'));

if ~exist('cvx_begin')
    addpath(genpath(fullfile(scriptDir, 'libs', 'cvx')));
end

if ~exist('quatOptiLag')
    addpath(genpath(fullfile(scriptDir, 'optimizer')));
end

if ~exist('T2DualQuat')
    addpath(genpath(fullfile(scriptDir, 'helper')));
end

end
