Milestone 2
===========

Work
===========
I myself (Yao-Chi Yu) is the only one on this team, so basically I wrote all the code.


Goal 
===========
Correctly classifiy the 11 types of movement (walking, falling, lying down, lying, sitting down, sitting, standing up from lying, on all fours, sitting on the ground, standing up from sitting, standing up from sitting on the ground). The motion of the subjects are recorded by four tags (ankle left, ankle right, belt and chest) with 3d dimension coordinates (x,y,z).

Method
===========
A GP Regression model is applied to classify the 11 possible kind of movements: walking, falling, lying down, lying, sitting down, sitting, standing up from lying, on all fours, sitting on the ground, standing up from sitting, standing up from sitting on the ground.

File
===========
The "GP.m" file uses the MATLAB built-in Gaussian process regression (GPR) model. I used two different kernels: 'squaredexponential' and 'ardsquaredexponential'. The code before line 50 is what required in this milestone. Also, mean-square-error is used as the error metric.

Potential Challenge
===========
1. There is no Gaussian Process Multivariate classification package available; I tried various online resources but all of them supports binary classificationonly only.

Resources used
===========
Statistical and Machine Learning Toolbox on MATLAB.

How to run the code
===========
1. load the data generated in milestone 1 folder
2. Run the code

