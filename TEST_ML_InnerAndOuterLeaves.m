%Abstract:
%This file tests our ML_InnerAndOuterLeaves function.
%Run the test by executing:
%   results = runtests('TEST_ML_InnerAndOuterLeaves.m');

L = 9;
sigGKP = 0.12;
etas = 0.995;
etam = 0.999995;
etad = 0.9975;
etac = 0.99;
Lcavity = 2;
k = 5;
v = 0.2;
leaves = 1;
N = 1000;


%Test1: When the distance increases, our error probabilities increase.
L1 = 3;
L2 = 10;
[Zerr1,Xerr1] = ML_InnerAndOuterLeaves(L1, sigGKP, etas, etam, etad, etac, Lcavity, k, v, leaves, N);
[Zerr2,Xerr2] = ML_InnerAndOuterLeaves(L2, sigGKP, etas, etam, etad, etac, Lcavity, k, v, leaves, N);

assert(all(Zerr1 < Zerr2, 'all'))
assert(all(Xerr1 < Xerr2, 'all'))


%Test2: When the sigGKP increases, our error probabilities increase.
sigGKP1 = 0.05;
sigGKP2 = 0.18;

[Zerr1,Xerr1] = ML_InnerAndOuterLeaves(L, sigGKP1, etas, etam, etad, etac, Lcavity, k, v, leaves, N);
[Zerr2,Xerr2] = ML_InnerAndOuterLeaves(L, sigGKP2, etas, etam, etad, etac, Lcavity, k, v, leaves, N);

assert(all(Zerr1 < Zerr2, 'all'))
assert(all(Xerr1 < Xerr2, 'all'))
