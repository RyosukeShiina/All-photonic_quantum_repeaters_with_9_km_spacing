%Abstract:
%This file tests our R_LogErrAfterPost function.
%Run the test by executing:
%   results = runtests('TEST_LogErrAfterPost.m');

sig1 = 0.246;
sig2 = 0.1;

v1 = 0.2;
v2 = 0.3;

%Test 1: If the standard deviation of the Gaussian displacement noise is fixed, then a larger window size leads to a lower bit-flip error probability, ErrProb, but also to a lower survival probability, Ppost.

[ErrProb1, Ppost1] = R_LogErrAfterPost(sig1, v1);
[ErrProb2, Ppost2] = R_LogErrAfterPost(sig1, v2);

assert(all(ErrProb1 > ErrProb2, 'all'));
assert(all(Ppost1 > Ppost2, 'all'));

%Test 2: If the window size is fixed, then a smaller standard deviation leads to a lower bit-flip error probability, ErrProb, but also to a higher survival probability, Ppost.

[ErrProb1, Ppost1] = R_LogErrAfterPost(sig1, v1);
[ErrProb2, Ppost2] = R_LogErrAfterPost(sig2, v1);

assert(all(ErrProb1 > ErrProb2, 'all'));
assert(all(Ppost1 < Ppost2, 'all'));
