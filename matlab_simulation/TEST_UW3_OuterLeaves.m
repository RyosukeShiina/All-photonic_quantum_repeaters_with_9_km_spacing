%Abstract:
%This file tests our UW3_OutnerLeaves-function.
%Please try "results = runtests('TEST_UW3_OuterLeaves.m')"

L = 9;
sigGKP = 0.12;
etas = 0.995;
etad = 0.9975;
etac = 0.99;
k = 20;
ErrProbVec = 1.0e-05 *[0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.3341];


%Test1: When the distance increases, our error probabilities increase.
L1 = 9;
L2 = 20;
logErr1 = UW3_OuterLeaves(L1, sigGKP, etas, etad, etac, k, ErrProbVec);
logErr2 = UW3_OuterLeaves(L2, sigGKP, etas, etad, etac, k, ErrProbVec);
avgErr1 = mean(logErr1);
avgErr2 = mean(logErr2);

assert(all(avgErr1 < avgErr2, 'all'))


%Test2: When the sigGKP increases, our error probabilities increase.
sigGKP1 = 0.12;
sigGKP2 = 0.18;

logErr1 = UW3_OuterLeaves(L1, sigGKP, etas, etad, etac, k, ErrProbVec);
logErr2 = UW3_OuterLeaves(L2, sigGKP, etas, etad, etac, k, ErrProbVec);
avgErr1 = mean(logErr1);
avgErr2 = mean(logErr2);

assert(all(avgErr1 < avgErr2, 'all'))
