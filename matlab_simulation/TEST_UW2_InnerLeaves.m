%Abstract:
%This file tests our UW2_InnerLeaves function.
%Run the test by executing:
%   results = runtests('TEST_UW2_InnerLeaves.m');

L = 9;
sigGKP = 0.12;
etas = 0.995;
etam = 0.999995;
etad = 0.9975;
etac = 0.99;
Lcavity = 2;
ErrProbVec = 1.0e-05 *[0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.3341];
N = 10000;

%Test1: When the distance increases, our error probabilities increase.
L1 = 3;
L2 = 18;
logErr1 = zeros(N,2);
for i = 1:N
	logErr1(i,:) = UW2_InnerLeaves(L1, sigGKP, etas, etam, etad, etac, Lcavity, ErrProbVec);
end
Total_logErr1 = sum(logErr1);


logErr2 = zeros(N,2);
for i = 1:N
    logErr2(i,:) = UW2_InnerLeaves(L2, sigGKP, etas, etam, etad, etac, Lcavity, ErrProbVec);
end
Total_logErr2 = sum(logErr2);

assert(all(Total_logErr1 < Total_logErr2, 'all'))



%Test2: When the sigGKP increases, our error probabilities increase. 
sigGKP1 = 0.12;
sigGKP2 = 0.28;
logErr1 = zeros(N,2);
for i = 1:N
    logErr1(i,:) = UW2_InnerLeaves(L, sigGKP1, etas, etam, etad, etac, Lcavity, ErrProbVec);
end
Total_logErr1 = sum(logErr1);


logErr2 = zeros(N,2);
for i = 1:N
    logErr2(i,:) = UW2_InnerLeaves(L, sigGKP2, etas, etam, etad, etac, Lcavity, ErrProbVec);
end
Total_logErr2 = sum(logErr2);

assert(all(Total_logErr1 < Total_logErr2, 'all'))
