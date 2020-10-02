% This script runs several calibration approaches and compares their
% results.
% Since the SVD approach fails on kitti data, it is ommitted there.

% In order to run the calibration on one of the following data sets just
% run the respective block of this script.

% setting up the environment, e.g., load directories in path
setupOptiEnvironment;

% load necessary data
kittiData = load(fullfile('data', 'kitti_velodyne_cam0.mat'));
kittiPlanarData = load(fullfile('data', 'kitti_planar_velodyne_cam0.mat'));
brookData = load(fullfile('data', 'brookshire.mat'));

brookFilename1 = fullfile('data', 'brookshiredq', 'sensor1.txt');
brookFilename2 = fullfile('data', 'brookshiredq', 'sensor2.txt');

% define how many times the optimizations are run 
nRuns = 12;
% ignore the first few iterations
startCountValues = 3;


%% run opti on kitti
% Since the SVD approach fails, it is not presented here and
% transformations are not included in the data.
[rErrors, tErrors, ~, times] = runOptimization(kittiData, nRuns, false);

kittiAvgTError = mean(tErrors(:,startCountValues:end), 2)';
kittiAvgRError = mean(rErrors(:,startCountValues:end), 2)';
kittiAvgTimes = mean(times(:,startCountValues:end), 2)';
kittiData = [kittiAvgTError; kittiAvgRError; kittiAvgTimes;];

printResults('kitti', kittiData');


%% run opti on kitti planar
[rErrors, tErrors, ~, times] = runOptimization(kittiPlanarData, nRuns, true);

kittiPlanarAvgTError = mean(tErrors(:,startCountValues:end), 2)';
kittiPlanarAvgRError = mean(rErrors(:,startCountValues:end), 2)';
kittiPlanarAvgTimes = mean(times(:,startCountValues:end), 2)';
kittiPlanarData = [kittiPlanarAvgTError; kittiPlanarAvgRError; kittiPlanarAvgTimes;];

printResults('kitti_planar', kittiPlanarData');


%% run opti on brookshire
[rErrors, tErrors, ~, times] = runOptimization(brookData, nRuns, false);

brookAvgTError = mean(tErrors(:,startCountValues:end), 2);
brookAvgRError = mean(rErrors(:,startCountValues:end), 2);
brookAvgTimes = mean(times(:,startCountValues:end), 2);

% SVD is additionally executed for brookData, since it requires a
% different format
[rErrors, tErrors, results, times] = runSVD(...
    brookFilename2, brookFilename1, ...
    brookData.q, nRuns ...
);

% concat results of optimization and SVD
brookAvgTError = [brookAvgTError; mean(tErrors(startCountValues:end))]';
brookAvgRError = [brookAvgRError; mean(rErrors(startCountValues:end))]';
brookAvgTimes = [brookAvgTimes; mean(times(startCountValues:end))]';
brookData = [brookAvgTError; brookAvgRError; brookAvgTimes;];

printResults('brookshire', brookData');

