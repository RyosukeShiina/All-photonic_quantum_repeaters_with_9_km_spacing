%Abstract:
%This file tests our R_Find_v function.
%Run the test by executing:
%   results = runtests('TEST_Find_v.m');

sigVec = [0.20, 0.21, 0.22, 0.23, 0.24];
vmax = 0.8;


%Note:
%Sometimes, we obtain v = 0.8862.
%This indicates that an error occurred (since (sqrt(pi)/2 = 0.8862...)

%Test 1: To achieve the same error probability, a Gaussian distribution with a larger standard deviation requires a wider window.

vVec = R_Find_v(sigVec, 1e-6, vmax);
for i = 1:length(vVec)-1
    assert(vVec(i) < vVec(i+1));
end

%Test 2: To achieve a smaller error probability, a wider window is required.
vVec1 = R_Find_v(sigVec, 1e-6, vmax);
vVec2 = R_Find_v(sigVec, 1e-7, vmax);
assert(all(vVec1 < vVec2, 'all'))
