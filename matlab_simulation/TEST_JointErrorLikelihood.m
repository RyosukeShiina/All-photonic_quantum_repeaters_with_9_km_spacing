%Abstract:
%This file tests our R_ReminderMod function.
%Run the test by executing:
%   results = runtests('TEST_JointErrorLikelihood.m');


error_vector1 = [0; 0; 0; 0; 0; 0; 0];
error_vector2 = [0; 0; 1; 0; 1; 0; 0];
error_vector3 = [0; 1; 1; 0; 0; 1; 1];

z_matrix1 = [0.1; 0.1; 0.1; 0.1; 0.1; 0.1; 0.1];
z_matrix2 = [0.1; 0.1; 0.1; 0.1; 0.1; 0.1; 0.1];
z_matrix3 = [0.1; 0.1; 0.1; 0.1; 0.1; 0.1; 0.1];


%Note: The outcomes are alweys between 0 and 0.5.
%Note: The inputs are alweys between –sqrt(pi)/2 and sqrt(pi)/2.

%Test1: When z is at sqrt(pi)/2, the error likelihood should be 50% because this is exactly in the middle of logical 0 and logical 1.
z = sqrt(pi)/2;
out1 = R_ErrorLikelihood(z, sig2);
disp(out1);
assert(abs(out1 - 0.5) < 1e-3);

%Test2: At the same z point, the error likelihood of the smaller standard deviation should be smaller than the error likelihood of the bigger standard deviation
z = sqrt(pi)/5;
out2 = R_ErrorLikelihood(z, sig1);
out3 = R_ErrorLikelihood(z, sig2);
out4 = R_ErrorLikelihood(z, sig3);
disp(out2);
disp(out3);
disp(out4);
assert(out2 < out3);
assert(out3 < out4);

%Test3: When z is at sqrt(pi)/3, the likelihood should be between the results of Test1 and Test2.
z = sqrt(pi)/3;
out5 = R_ErrorLikelihood(z, sig2);
disp(out5);
assert(out5 < out1);
assert(out3 < out5);
