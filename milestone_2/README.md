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
I separated the data into two main groups to do GP classification; walking, falling, lying down, sitting down, standing up from lying, standing up from sitting, standing up from sitting on the ground as the static group, and the rest be non-static group.

File
===========
The "GP.m" file uses the GPML package to perform GP classification. 

Potential Challenge
===========
Gaussian Process multclass classification package is not available, so following the advice by the TA, I converted the problem into a binary classification problem. For a dataset with as many attributes as twelve, I tried not to use ARD covariance since there will be too many hyperparameters, and I don't want to overfit the data to get a bad model.

Resources used
===========
Statistical and Machine Learning Toolbox on MATLAB.

How to run the code
===========
1. load the data generated in milestone 1 folder
2. Run the code

Result
===========
I corrected some coding errors. The average accuracy of 10-fold CV result is 63% in my run. 

