Milestone 3
===========

Work
===========
I myself (Yao-Chi Yu) is the only one on this team, so basically I wrote all the code.

Goal 
===========
Pre-assign the 11 types of movement (walking, falling, lying down, lying, sitting down, sitting, standing up from lying, on all fours, sitting on the ground, standing up from sitting, standing up from sitting on the ground) into two groups (static and non-static), we aim at correctly classifying the binary classification problem through motion recording of four tags (ankle left, ankle right, belt and chest) with 3d dimension coordinates (x,y,z).

Method
===========
Since there are a total of 12 features (three coordintates x four tags), we run PCA to retain only the principle components of the data.
I reduce the most important 4 features calculated by pca, which takes up to 75% of all variability, and run GP classification, as in the milestone 2.

File
===========
The code will need the pre-processed data.mat file in the first milestone.

Potential Challenge
===========
There are generally two types of limitation for PCA (ref: Girolami, Mark_ Rogers, Simon-A first course in machine learning-CRC Press (2017), p. 243):
1. The data have to be real valued.
2. There are no missing values in the data.
Fortunately in this dataset, we do not have any missing data; nor do we have categorical variables that will hinder the PCA algorithm; PCA can capture the characateristic of the data nicely.

Resources used
===========
Statistical and Machine Learning Toolbox on MATLAB.

How to run the code
===========
1. Run the MS3.m file.

Result
===========
10-fold crossvalidatioin results is shown and achieve an average accuracy of 85.23%. 
