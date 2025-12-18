%Abstract:
%This file tests our R_SecretKey6State_total function.
%Run the test by executing:
%   results = runtests('TEST_SecretKey6State_total.m');

tol = 1e-12;

%Test 1: Zero error -> secret key = 1
k = 5;
QerrZ = zeros(k,1);
QerrX = zeros(k,1);
out1 = R_SecretKey6State_total(QerrZ, QerrX);
assert(abs(out1 - k) < tol);

%Test 2: Very high errors -> key rate should be 0 (because max(...,0))
k = 7;
QerrZ = 0.5*ones(k,1);
QerrX = 0.5*ones(k,1);

out2 = R_SecretKey6State_total(QerrZ, QerrX);
assert(abs(out2 - 0) < tol);

%Test 3: Output range must be within [0,k]
k = 10;
rng(1);
QerrZ = 0.5*rand(k,1);
QerrX = 0.5*rand(k,1);
out3 = R_SecretKey6State_total(QerrZ, QerrX);
assert(out3 >= -tol);
assert(out3 <= k + tol);

%Test 4: Symmetry under swapping X and Z errors (function is symmetric)
k = 8;
QerrZ = [0.01; 0.02; 0.05; 0.1; 0.15; 0.2; 0.3; 0.4];
QerrX = [0.04; 0.03; 0.07; 0.12; 0.18; 0.22; 0.31; 0.41];
out4a = R_SecretKey6State_total(QerrZ, QerrX);
out4b = R_SecretKey6State_total(QerrX, QerrZ);
assert(abs(out4a - out4b) < 1e-10);

%% Test 5: k=1 should match direct (no averaging ambiguity)
QerrZ = 0.12;
QerrX = 0.07;
out5 = R_SecretKey6State_total(QerrZ, QerrX);

%Build the same computation explicitly for k=1
qZ = QerrZ*(1-QerrX);
qX = QerrX*(1-QerrZ);
qY = QerrZ*QerrX;
eX = min(qZ + qY, 0.5);
eZ = min(qX + qY, 0.5);
eY = min(qZ + qX, 0.5);
lambda00 = 1-(eX + eY + eZ)/2;
lambda01 = (eX + eZ - eY)/2;
lambda10 = (-eX + eY + eZ)/2;
lambda11 = (eX - eZ + eY)/2;

L = [lambda00, lambda01, lambda10, lambda11];
PX0 = (lambda00 + lambda01)^2 + (lambda10 + lambda11)^2;
lambda00p = (lambda00^2 + lambda01^2)/PX0;
lambda01p = (2*lambda00*lambda01)/PX0;
lambda10p = (lambda10^2 + lambda11^2)/PX0;
lambda11p = (2*lambda10*lambda11)/PX0;
Lp = [lambda00p, lambda01p, lambda10p, lambda11p];
out1_direct = 1 - R_ShannonEnt(L);
out2_direct = (PX0/2) * (1 - R_ShannonEnt(Lp));
out_direct = max([out1_direct, out2_direct, 0]);

assert(abs(out5 - out_direct) < 1e-12);
