Milestone 4 README
===========

Work
===========
I myself (Yao-Chi Yu) is the only one on this team, so basically I wrote all the code.

Goal 
===========
As the semester goes on, the problem I am working on changes from classifiying 11 types of movement to just binary classification--static and non-static. The dataset consists of motions of the subjects, which are recorded by four tags (ankle left, ankle right, belt and chest) with 3d dimension coordinates (x,y,z).

Method
===========
Compare all methods (linear classifier, GP-binary classification, PCA+GP-binary classification) using 10 re-runs of a 10-fold cross-validation and perform a suitable statistical test to assess the performance of each method.

File
===========
"data.mat" file in Milestone 1.

Resources used
===========
Statistical and Machine Learning Toolbox on MATLAB.

How to run the code
===========
1. load "data.mat" file in Milestone 1.
2. Run the code "MS4.m".

Result
===========
10-fold cv accuracy for linear classification is 48.09%
10-fold cv accuracy for GP classification is 82.83%
10-fold cv accuracy for pca-GP classification is 81.84%
