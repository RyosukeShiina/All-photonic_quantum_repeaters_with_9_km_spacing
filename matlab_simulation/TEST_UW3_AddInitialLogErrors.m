%Abstract:
%This file tests our UW3_AddInitialLogErrors function.
%Run the test by executing:
%   results = runtests('TEST_UW3_AddInitialLogErrors.m');

tol = 1e-12;

% Initial deltas
qd0 = zeros(7,1);
pd0 = zeros(7,1);

%Test 1: All-zero Sampled -> identity
SampledZero = cell(1,12);
SampledZero{1}  = zeros(100,1);   % Sampled3Sigma
SampledZero{2}  = zeros(100,1);
SampledZero{3}  = zeros(100,1);
SampledZero{4}  = zeros(100,1);
SampledZero{5}  = zeros(100,1);
SampledZero{6}  = zeros(100,1);
SampledZero{7}  = zeros(100,1);
SampledZero{8}  = zeros(100,1);
SampledZero{9}  = zeros(100,1);
SampledZero{10} = zeros(100,1);
SampledZero{11} = zeros(100,1);
SampledZero{12} = zeros(100,1);

[qd, pd] = UW3_AddInitialLogErrors(qd0, pd0, SampledZero);

assert(norm(qd) < tol);
assert(norm(pd) < tol);

%Test 2: Output size and √π quantization
SampledOne = SampledZero;
SampledOne{1}(1) = 1;   % flip one bit

[qd, pd] = UW3_AddInitialLogErrors(qd0, pd0, SampledOne);

assert(isequal(size(qd), [7,1]));
assert(isequal(size(pd), [7,1]));

vals = [qd; pd] / sqrt(pi);
assert(all(abs(vals - round(vals)) < tol));
