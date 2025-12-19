%Abstract:
%This file tests our UW3_OutnerLeaves function.
%Run the test by executing:
%   results = runtests('TEST_UW3_OuterLeaves.m');

tol = 1e-12;

sigGKP = 0.12;
etas = 0.995;
etad = 0.9975;
etac = 0.99;

% Use large k to reduce fluctuations
k = 200;

ErrProbVec = 1.0e-05*[0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.3341, 0.3341, 0.3341, 0.3341];

% Helper: output must be kx2 binary
check_output = @(A,k) assert( ...
    isequal(size(A), [k,2]) && ...
    all((A==0) | (A==1), 'all') && ...
    all(~isnan(A), 'all') );

%Test 0: Basic sanity (shape + binary)
rng(1);
A0 = UW3_OuterLeaves(9, sigGKP, etas, etad, etac, k, ErrProbVec);
check_output(A0, k);

%Test 0b: Reproducibility with rng reset (strong regression test)
% If you reset rng to the same seed, you should get the same output.
rng(2);
A1 = UW3_OuterLeaves(9, sigGKP, etas, etad, etac, k, ErrProbVec);
rng(2);
A2 = UW3_OuterLeaves(9, sigGKP, etas, etad, etac, k, ErrProbVec);
assert(isequal(A1, A2));

%Test 1: Larger distance -> larger error rate (robust via repetition)

L1 = 9;
L2 = 30;
R  = 20;   % number of repeats

rng(3);
sum1 = zeros(1,2);
sum2 = zeros(1,2);

for r = 1:R
    B1 = UW3_OuterLeaves(L1, sigGKP, etas, etad, etac, k, ErrProbVec);
    B2 = UW3_OuterLeaves(L2, sigGKP, etas, etad, etac, k, ErrProbVec);
    check_output(B1, k);
    check_output(B2, k);
    sum1 = sum1 + sum(B1, 1);   % counts of [Zerr, Xerr]
    sum2 = sum2 + sum(B2, 1);
end

p1 = sum1 / (R*k);
p2 = sum2 / (R*k);

assert(all(p2 > p1 + 1e-4, 'all'));

%Test 2: Larger sigGKP -> larger error rate (robust via repetition)
sig1 = 0.12;
sig2 = 0.20;

rng(4);
sum1 = zeros(1,2);
sum2 = zeros(1,2);

for r = 1:R
    B1 = UW3_OuterLeaves(9, sig1, etas, etad, etac, k, ErrProbVec);
    B2 = UW3_OuterLeaves(9, sig2, etas, etad, etac, k, ErrProbVec);
    check_output(B1, k);
    check_output(B2, k);
    sum1 = sum1 + sum(B1, 1);
    sum2 = sum2 + sum(B2, 1);
end

p1 = sum1 / (R*k);
p2 = sum2 / (R*k);

assert(all(p2 > p1 + 1e-4, 'all'));

%Test 3: If etac is smaller (worse connectors), error rate should increase (sanity)
% This targets the eta*etac*etad term in sigChannel.
etac1 = 0.99;
etac2 = 0.90;

rng(5);
sum1 = zeros(1,2);
sum2 = zeros(1,2);

for r = 1:R
    B1 = UW3_OuterLeaves(9, sigGKP, etas, etad, etac1, k, ErrProbVec);
    B2 = UW3_OuterLeaves(9, sigGKP, etas, etad, etac2, k, ErrProbVec);
    check_output(B1, k);
    check_output(B2, k);
    sum1 = sum1 + sum(B1, 1);
    sum2 = sum2 + sum(B2, 1);
end

p1 = sum1 / (R*k);
p2 = sum2 / (R*k);

assert(all(p2 > p1 + 1e-4, 'all'));
