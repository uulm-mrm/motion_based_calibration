% Download, extract and setup CVX from http://cvxr.com/cvx/

% download
disp('Download archive for platform')

filename = 'cvx.tar.gz';
urlLinux = 'http://web.cvxr.com/cvx/cvx-a64.tar.gz';
urlMac = 'http://web.cvxr.com/cvx/cvx-maci64.tar.gz';
urlWindows = 'http://web.cvxr.com/cvx/cvx-w64.tar.gz';

try
    if isunix
        websave(filename, urlLinux);
    elseif ismac
        websave(filename, urlMac);
    elseif ispc
        websave(filename, urlWindows);
    else
        error('Platform not supported. Please download manually from http://cvxr.com/cvx/ .')
    end
catch e
    error('Could not download archive. Please download manually from http://cvxr.com/cvx/ .')
end

% extract
disp('Extract archive')
try
    untar(filename);
catch e
    error('Could not extract archive. Please download manually from http://cvxr.com/cvx/ .')
end

% setup
disp('Initial setup')
addpath('cvx');
cvx_setup;
