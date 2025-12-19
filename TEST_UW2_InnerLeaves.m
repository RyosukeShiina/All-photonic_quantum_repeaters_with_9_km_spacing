%Abstract:
%This file tests our UW2_InnerLeaves function.
%Run the test by executing:
%   results = runtests('TEST_UW2_InnerLeaves.m');

tol = 1e-12;

L0 = 9;
sigGKP = 0.12;
etas = 0.995;
etam = 0.999995;
etad = 0.9975;
etac = 0.99;
Lcavity = 2;

ErrProbVec = 1.0e-05 * [0.1479, 0.1479, 0.1479, 0.1479, 0.1479, ...
                        0.1479, 0.1479, 0.1479, 0.1479, 0.3341];

% Helper: output must be 1x2 binary
check_output = @(A) assert( ...
    isequal(size(A), [1,2]) && ...
    all((A==0) | (A==1), 'all') && ...
    all(~isnan(A), 'all') );

%Test 0: basic sanity (shape + binary)
rng(1);
logErr0 = UW2_InnerLeaves(L0, sigGKP, etas, etam, etad, etac, Lcavity, ErrProbVec);
check_output(logErr0);

%Test 1: If ErrProbVec is all zeros, output must be [0,0] (deterministic property)
ErrProbZero = zeros(1,10);
rng(2);
logErr1 = UW2_InnerLeaves(L0, sigGKP, etas, etam, etad, etac, Lcavity, ErrProbZero);
check_output(logErr1);
assert(isequal(logErr1, [0,0]));

%Test 2: Increasing L0 should increase error probability (robust via repetition)
L1 = 9;
L2 = 30;

R = 2000;  % number of repeats
rng(3);

cnt1 = zeros(1,2);
cnt2 = zeros(1,2);
for r = 1:R
    A1 = UW2_InnerLeaves(L1, sigGKP, etas, etam, etad, etac, Lcavity, ErrProbVec);
    A2 = UW2_InnerLeaves(L2, sigGKP, etas, etam, etad, etac, Lcavity, ErrProbVec);
    check_output(A1);
    check_output(A2);
    cnt1 = cnt1 + A1;
    cnt2 = cnt2 + A2;
end

p1 = cnt1 / R;   % estimated probabilities for [Zerr, Xerr]
p2 = cnt2 / R;

assert(all(p2 > p1 + 1e-3, 'all'));


%Test 3: Increasing sigGKP should increase error probability (robust via repetition)
sig1 = 0.12;
sig2 = 0.20;

R = 2000;
rng(4);

cnt1 = zeros(1,2);
cnt2 = zeros(1,2);
for r = 1:R
    A1 = UW2_InnerLeaves(L0, sig1, etas, etam, etad, etac, Lcavity, ErrProbVec);
    A2 = UW2_InnerLeaves(L0, sig2, etas, etam, etad, etac, Lcavity, ErrProbVec);
    check_output(A1);
    check_output(A2);
    cnt1 = cnt1 + A1;
    cnt2 = cnt2 + A2;
end

p1 = cnt1 / R;
p2 = cnt2 / R;

assert(all(p2 > p1 + 1e-3, 'all'));

