%Abstract:
%This file tests our R_JointErrorLikelihood function.
%Run the test by executing:
%   results = runtests('TEST_JointErrorLikelihood.m');


error_vector1 = [0; 0; 0; 0; 0; 0; 0];
error_vector2 = [1; 1; 1; 1; 1; 1; 1];
error_vector3 = [0; 0; 1; 0; 1; 0; 0];
error_vector4 = [0; 0; 1; 0; 1; 1; 0];

z_matrix = [sqrt(pi)/5; -sqrt(pi)/7; 0.1; -0.2; sqrt(pi)/10; -sqrt(pi)/9; 0.2];

sig = 0.527;


%Note: The z_matrices are alweys between –sqrt(pi)/2 and sqrt(pi)/2.

%Precompute per-qubit likelihoods
test = zeros(7,1);
for i = 1:7
    test(i) = R_ErrorLikelihood(z_matrix(i), sig);
end




%Test 1: All-zero error vector [0; 0; 0; 0; 0; 0; 0] -> sum log2(1-p_i)
out1 = R_JointErrorLikelihood(error_vector1, z_matrix, sig);
out2 = 0;
for i = 1:7
    out2 = out2 + log2(1 - test(i));
end
assert(abs(out1 - out2) < 1e-12);



%Test 2: All-one error vector [1; 1; 1; 1; 1; 1; 1] -> sum log2(p_i)
out3 = R_JointErrorLikelihood(error_vector2, z_matrix, sig);
out4 = 0;
for i = 1:7
    out4 = out4 + log2(test(i));
end
assert(abs(out3 - out4) < 1e-12);



% Test 3: Mixed error vector [0; 0; 1; 0; 1; 0; 0];
out5 = R_JointErrorLikelihood(error_vector3, z_matrix, sig);
out6 = 0;
for i = 1:7
    if error_vector3(i)==1
        out6 = out6 + log2(test(i));
    else
        out6 = out6 + log2(1 - test(i));
    end
end
assert(abs(out5 - out6) < 1e-12);


% Test 4: Flipping one bit changes output by a known amount
% If we flip qubit j from 0->1, delta should be log2(p_j) - log2(1-p_j)
out7 = R_JointErrorLikelihood(error_vector4, z_matrix, sig);
delta = out7 - out5;
delta2 = log2(test(6)) - log2(1 - test(6));
assert(abs(delta - delta2) < 1e-12);
