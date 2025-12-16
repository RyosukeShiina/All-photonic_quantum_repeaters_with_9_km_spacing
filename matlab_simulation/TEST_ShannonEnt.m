%Abstract:
%This file tests our R_ShannonEnt function.
%Run the test by executing:
%   results = runtests('TEST_ShannonEnt.m');

tol = 1e-12;

%Test 1: Deterministic distribution -> entropy = 0
T1 = [1 0 0 0];
out1 = R_ShannonEnt(T1);
assert(abs(out1 - 0) < tol);

%Test 2: Fair coin -> entropy = 1
T2 = [0.5 0.5];
out2 = R_ShannonEnt(T2);
assert(abs(out2 - 1) < tol);

%Test 3: Uniform distribution of size N -> entropy = log2(N)
N = 8;
T3 = ones(1,N) / N;
out3 = R_ShannonEnt(T3);
assert(abs(out3 - log2(N)) < tol);

%Test 4: Distribution with zeros (should ignore zero entries)
T4 = [0.25 0.25 0.25 0.25 0 0];
out4 = R_ShannonEnt(T4);
assert(abs(out4 - 2) < tol);

%Test 5: Known non-uniform distribution (hand-computable)
T5 = [0.5 0.25 0.25];
% Expected: -(1/2 log2 1/2 + 1/4 log2 1/4 + 1/4 log2 1/4) = 1.5
out5 = R_ShannonEnt(T5);
assert(abs(out5 - 1.5) < tol);

%Test 6: Entropy is always non-negative
rng(1);
T6 = rand(1,10);
T6 = T6 / sum(T6);
out6 = R_ShannonEnt(T6);
assert(out6 >= -tol);
