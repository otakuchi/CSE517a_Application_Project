Milestone 1 README
===========

Work
===========
I myself (Yao-Chi Yu) is the only one on this team, so basically I wrote all the code.

Goal 
===========
Correctly classifiy the 11 types of movement (walking, falling, lying down, lying, sitting down, sitting, standing up from lying, on all fours, sitting on the ground, standing up from sitting, standing up from sitting on the ground). The motion of the subjects are recorded by four tags (ankle left, ankle right, belt and chest) with 3d dimension coordinates (x,y,z).

Method
===========
A linear classifier is used to to classify the 11 possible kind of movements: walking, falling, lying down, lying, sitting down, sitting, standing up from lying, on all fours, sitting on the ground, standing up from sitting, standing up from sitting on the ground.

File
===========
The "DataProcessing.m" file contains three parts. The first one is to change the tag identificator (010-000-024-033,020-000-033-111,020-000-032-221,010-000-030-096) into four categorical index (1,2,3,4). The second one is to organize the dataset and organize it as a "data.mat" file. Third part is formulate the data that can be read by the MATLAB "fitcecoc" function and then train and test the classification result.

Potential Challenge
===========
1. Some of the motions are quite similar. For example, "standing up from sitting" and "standing up from sitting on the ground". 
2. This is a time-series dataset, a possible challenge would be how to retrieve time-series information from  the (x,y,z) coordinates and formulate it as a machine learning feature.
3. The time-series coordinate records are not of the same length for all of the subjects. Moreoever, for a specific subject, the data of each motion is of different length of duration as well.

Resources used
===========
Statistical and Machine Learning Toolbox on MATLAB.

How to run the code
===========
1. Install the "RunLength.m" function available at: https://www.mathworks.com/matlabcentral/fileexchange/41813-runlength
2. Download the dataset from the link by copy and paste command and save it as a .xlsx file.
3. Run the DataProcessing.m file until line 150; the rest of the lines is not related to this milestone.

Result
===========
10-fold crossvalidatioin results is shown and achieve a general error of 0.3735

