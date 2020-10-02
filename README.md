# Online Extrinsic Calibration based on Per-Sensor Ego-Motion Using Dual Quaternions

Authors: [Markus Horn](mailto:markus.horn@uni-ulm.de)\*, [Thomas Wodtko](mailto:thomas.wodtko@uni-ulm.de)\*, [Michael Buchholz](mailto:michael.buchholz@uni-ulm.de), [Klaus Dietmayer](mailto:klaus.dietmayer@uni-ulm.de)

\* Markus Horn and Thomas Wodtko are co-first authors.

ArXiv: https://arxiv.org/abs/2101.11440 \
IEEE Xplore: https://ieeexplore.ieee.org/document/9345480 \
DOI: 10.1109/LRA.2021.3056352


## Abstract

In this work, we propose an approach for extrinsic sensor calibration from per-sensor ego-motion estimates.
Our problem formulation is based on dual quaternions, enabling two different online capable solving approaches.
We provide a certifiable globally optimal and a fast local approach along with a method to verify the globality of the local approach.
Additionally, means for integrating previous knowledge, for example, a common ground plane for planar sensor motion, are described.
Our algorithms are evaluated on simulated data and on a publicly available dataset containing RGB-D camera images.
Further, our online calibration approach is tested on the KITTI odometry dataset, which provides data of a lidar and two stereo camera systems mounted on a vehicle.
Our evaluation confirms the short run time, state-of-the-art accuracy, as well as online capability of our approach while retaining the global optimality of the solution at any time.


## Python: Coming Soon

We will update our code and add the Python implementation as soon as possible after refactoring.
You can send us an email if you want to be notified as soon as the sources are online: [markus.horn@uni-ulm.de](mailto:markus.horn@uni-ulm.de).
