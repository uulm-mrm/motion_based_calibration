# Matlab Implementation for Motion Based Calibration

A Matlab implementation for the calibration approaches described in the respective work is given here.


## Installation

In order to run our scripts, Matlab must be installed, including the Optimization Toolbox.

Additionally, the CVX Matlab toolbox is required.
You can download and install CVX using our script `libs/downloadCVX.m`.
If you use our script, no further steps are required.
Alternatively, you can download it manually at `http://cvxr.com/cvx/`.
After downloading the project, either extract the cvx folder containing the toolbox to `matlab/libs`, or adjust the respective line in `setupOptiEnvironment.m`.
In case the CVX toolbox is installed for the first time, or if it is moved after it was previously installed, run `cvx_setup` in the Matlab console while the CVX folder is included in the Matlab path in order to ensure a correct setup.


## Run Scripts

The script `runCalibrations.m` loads necessary data and runs the offline calibrations presented in our work.
While results for each dataset are stored in a respective variable, they are also printed out immediatly after the calculation.


## Miscellaneous

This implementation was tested using `Ubuntu 20.04.1 LTS`, `MATLAB R2020a` and `CVX 2.2`.


## References

**Matrix Optimization**\
M. Giamou, Z. Ma, V. Peretroukhin, and J. Kelly, "Certifiably Globally Optimal Extrinsic Calibration from Per-Sensor Egomotion"\
IEEE Robotics and Automation Letters, vol. 4, no. 2, pp. 367-374, 2019

**SVD Calibration**\
K. Daniilidis, "Hand-Eye Calibration Using Dual Quaternions"\
The International Journal of Robotics Research, vol. 18, no. 3, pp. 286-298, 1999

**KITTI Dataset**\
A. Geiger, P. Lenz, and R. Urtasun, "Are we ready for Autonomous Driving? The KITTI Vision Benchmark Suite"\
IEEE/CVF Conference on Computer Vision and Pattern Recognition (CVPR), 2012, pp. 3354-3361\
http://www.cvlibs.net/datasets/kitti/

**Brookshire Dataset**\
J. Brookshire and S. Teller, "Extrinsic Calibration from Per-Sensor Egomotion"\
Robotics: Science and Systems, vol. 8, pp. 25-32, 2013\
http://www.jbrookshire.com/projects_3dcalib.htm

**Lidar Odometry: A-LOAM**\
J. Zhang and S. Singh, "LOAM: Lidar Odometry and Mapping in Real-time”\
Robotics: Science and Systems, vol. 2, 2014\
https://github.com/HKUST-Aerial-Robotics/A-LOAM

**Stereo Odometry: OpenVSLAM**\
S. Sumikura, M. Shibuya, and K. Sakurada, "OpenVSLAM: A Versatile Visual SLAM Framework"\
ACM International Conference on Multimedia, ser. MM ’19, ACM, 2019, pp. 2292-2295\
https://github.com/xdspacelab/openvslam
