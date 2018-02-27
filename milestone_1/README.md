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

Method
===========
The "DataProcessing.m" file contains two parts. The first one is to change the tag identificator (010-000-024-033,020-000-033-111,020-000-032-221,010-000-030-096) into four categorical index (1,2,3,4). The second one is my try to just keep some patial dataset with motions that are of significant distinction from one another (1:walking, 4:lying, 6:sitting, 7:standing up from lying, and 9: sitting on the ground.)

Potential Challenge
===========
Some of the motions are quite similar. For example, "standing up from sitting" and "standing up from sitting on the ground". In addition, since this is a time-series dataset, a possible challenge would be how to retrieve time-series information from  the (x,y,z) coordinates and formulate it as a machine learning feature.


Resources used
===========
libsvm package on MATLAB.

How to run the code
===========
1. Download the dataset from the link by copy and paste command and save it as a .xlsx file.
2. Run the DataProcessing.m file.
