%Abstract:
%This file tests our R_ReminderMod function.
%Run the test by executing:
%   results = runtests('TEST_ReminderMod.m');

modval = sqrt(pi);
%Note: sqrt(pi) = 1.772... and sqrt(pi)/2 = 0.886...

% Tolerance 1e-12 is used to account for floating-point rounding errors.
% Numerical tolerance for floating-point arithmetic.


% Test 1: Shape / size check
vec0 = [2.456; -1.426; 0.003; 0.461; -0.343; 1.333; 4.000];
out0 = R_ReminderMod(vec0, modval);
assert(isequal(size(out0), size(vec0)));

% Test 2: Exact multiples of modval map to 0
vec1 = [1*modval; 2*modval; 3*modval; -8*modval; 100*modval; -56*modval; 20*modval];
out1 = R_ReminderMod(vec1, modval);
assert(all(abs(out1) < 1e-12, 'all'));


% Test 3: Values already in [-modval/2, modval/2] should remain unchanged (identity on the principal interval).
vec2 = [ ...
    modval/3; modval/6; modval/7; -modval/11; -modval/3; -modval/5; modval/100 ...
];
out2 = R_ReminderMod(vec2, modval);
assert(all(abs(out2 - vec2) < 1e-12, 'all'));


% Test 3 (Your old Test3): Adding integer multiples of modval should not change the output (periodicity / invariance).
vec3 = [ modval/3 + 1*modval; modval/6 + 2*modval; modval/7 - 3*modval; -modval/11 + 3*modval; -modval/3; -modval/5; modval/100];
out3 = R_ReminderMod(vec3, modval);
assert(all(abs(out3 - out2) < 1e-12, 'all'));


% Test 4: Output must lie in [-modval/2, modval/2] for general inputs
vec4 = [2.456; -1.426; 0.003; 0.461; -0.343; 1.333; 4.000];
out4 = R_ReminderMod(vec4, modval);
assert(all(out4 >= -modval/2 - 1e-12, 'all'));
assert(all(out4 <=  modval/2 + 1e-12, 'all'));


% Test 5: Boundary behavior near +/- modval/2
eps0 = 1e-10;
vec5 = [ -modval/2; modval/2; modval/2 + eps0; -modval/2 - eps0];
out5 = R_ReminderMod(vec5, modval);

assert(all(out5 >= -modval/2 - 1e-12, 'all'));
assert(all(out5 <=  modval/2 + 1e-12, 'all'));
