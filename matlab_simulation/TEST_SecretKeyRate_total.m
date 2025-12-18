%Abstract:
%This file tests our R_SecretKeyRate_total function.
%Run the test by executing:
%   results = runtests('TEST_SecretKeyRate_total.m');

tol = 1e-12;

%Test 1: If Ltot = L (one link), then QerrZArray = Zerr and QerrXArray = Xerr
L = 10;
Ltot = 10;

Zerr = [0.12; 0.30; 0.01];
Xerr = [0.07; 0.20; 0.40];

out1 = R_SecretKeyRate_total(L, Ltot, Zerr, Xerr);

% Manual end-to-end errors for NoLinks = 1
NoLinks = Ltot/L;
QerrZArray = (1 - (1 - 2*Zerr).^NoLinks)/2;
QerrXArray = (1 - (1 - 2*Xerr).^NoLinks)/2;

out1_manual = R_SecretKey6State_total(QerrZArray, QerrXArray);
assert(abs(out1 - out1_manual) < tol);

%Test 2: Clipping at 0.5 should make values >0.5 equivalent to 0.5
L = 10;
Ltot = 50; % 5 links

ZerrA = [0.7; 0.9; 0.51];
XerrA = [0.8; 0.6; 0.99];

ZerrB = 0.5*ones(3,1);
XerrB = 0.5*ones(3,1);

out2a = R_SecretKeyRate_total(L, Ltot, ZerrA, XerrA);
out2b = R_SecretKeyRate_total(L, Ltot, ZerrB, XerrB);
assert(abs(out2a - out2b) < 1e-10);

%Test 3: Output range must be within [0, k] (total over k modes)
L = 10;
Ltot = 100; % 10 links

rng(1);
k = 8;
Zerr = 0.5*rand(k,1);
Xerr = 0.5*rand(k,1);

out3 = R_SecretKeyRate_total(L, Ltot, Zerr, Xerr);
assert(out3 >= -tol);
assert(out3 <= k + tol);


%Test 4: Increasing number of links should not increase end-to-end total key
%More links => larger accumulated errors => key should be decreasing

L = 10;
Zerr = [0.02; 0.05; 0.10];
Xerr = [0.01; 0.04; 0.08];
k = numel(Zerr);

out4a = R_SecretKeyRate_total(L, 10,  Zerr, Xerr);   % NoLinks=1
out4b = R_SecretKeyRate_total(L, 50,  Zerr, Xerr);   % NoLinks=5
out4c = R_SecretKeyRate_total(L, 100, Zerr, Xerr);   % NoLinks=10

assert(out4a >= out4b - 1e-10);
assert(out4b >= out4c - 1e-10);

%Test 5: Zero error -> secret key = k (total over k modes)
L = 10;
Ltot = 30;  % any integer multiple of L is fine
k = 6;

Zerr = zeros(k,1);
Xerr = zeros(k,1);

out5 = R_SecretKeyRate_total(L, Ltot, Zerr, Xerr);
assert(abs(out5 - k) < tol);

%Test 6: Crossover check with per-version.
%For the same inputs, total rate should equal k * per-rate.
L = 10;
Ltot = 100;

rng(2);
k = 9;
Zerr = 0.5*rand(k,1);
Xerr = 0.5*rand(k,1);

out_total = R_SecretKeyRate_total(L, Ltot, Zerr, Xerr);
out_per   = R_SecretKeyRate_per(L, Ltot, Zerr, Xerr);

assert(abs(out_total - k*out_per) < 1e-10);
