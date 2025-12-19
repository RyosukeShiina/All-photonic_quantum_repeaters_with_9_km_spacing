function [qdeltas, pdeltas] = LP_AddInitialLogErrorsInnerLeaves(qdeltas, pdeltas, Sampled)


Sampled3Sigma = Sampled{1};

Sampled3SigmaSwitch = Sampled{2};
Sampled3SigmaSwitchTwice = Sampled{3};

Sampled2SigmaSwitch = Sampled{4};
Sampled2SigmaSwitchTwice = Sampled{5};

SampledRefresh3SigmaSwitchTwice = Sampled{6};
SampledRefresh3SigmaSwitchThreeTimes = Sampled{7};
SampledRefresh2SigmaSwitchTwice = Sampled{8};
SampledRefresh2SigmaSwitchThreeTimes = Sampled{9};

SampledRefresh3SigmaSwitch = Sampled{10};
SampledRefresh2SigmaSwitch = Sampled{11};

SampledNoPost = Sampled{12};

%Firstly the correlated errors:
if Sampled3Sigma(1) == 1 %a
    pdeltas(1) = pdeltas(1) + sqrt(pi);
    pdeltas(2) = pdeltas(2) + sqrt(pi);
end
if Sampled3Sigma(2) == 1 %b
    pdeltas(5) = pdeltas(5) + sqrt(pi);
    pdeltas(7) = pdeltas(7) + sqrt(pi);
end
if Sampled3Sigma(3) == 1 %c
    pdeltas(5) = pdeltas(5) + sqrt(pi);
    pdeltas(6) = pdeltas(6) + sqrt(pi);
end
if Sampled3Sigma(4) == 1 %d
    pdeltas(1) = pdeltas(1) + sqrt(pi);
    pdeltas(3) = pdeltas(3) + sqrt(pi);
end
if Sampled3Sigma(5) == 1 %e
    pdeltas(6) = pdeltas(6) + sqrt(pi);
    pdeltas(7) = pdeltas(7) + sqrt(pi);
end
if Sampled3Sigma(6) == 1 %f
    pdeltas(1) = pdeltas(1) + sqrt(pi);
    pdeltas(3) = pdeltas(3) + sqrt(pi);
end
if Sampled3Sigma(7) == 1 %g
    pdeltas(2) = pdeltas(2) + sqrt(pi);
    pdeltas(3) = pdeltas(3) + sqrt(pi);
end
if Sampled3Sigma(8) == 1 %h
    pdeltas(5) = pdeltas(5) + sqrt(pi);
    pdeltas(7) = pdeltas(7) + sqrt(pi);
end

%Now the uncorrelated errors

%ONLY INNER-LEAVEES

%Without switch
pdeltas = pdeltas + Sampled3Sigma(9:15) * sqrt(pi);

%With single switch and 3 sigma
pdeltas(1:3) = pdeltas(1:3) + Sampled3SigmaSwitch(1:3) * sqrt(pi);
pdeltas(5:7) = pdeltas(5:7) + Sampled3SigmaSwitch(4:6) * sqrt(pi);


%With single switch and 2 sigma
pdeltas(4) = pdeltas(4) + Sampled2SigmaSwitch(1) * sqrt(pi);
pdeltas = pdeltas + SampledNoPost(1:7) * sqrt(pi); %%%%%v=0


%With Switch Twice and 3 Sigma
pdeltas(3) = pdeltas(3) + Sampled2SigmaSwitch(1) * sqrt(pi);
pdeltas(7) = pdeltas(7) + Sampled2SigmaSwitch(2) * sqrt(pi);


%With Switch Twice and 2 Sigma
pdeltas(1) = pdeltas(1) + Sampled2SigmaSwitchTwice(1) * sqrt(pi);
pdeltas(2) = pdeltas(2) + Sampled2SigmaSwitchTwice(2) * sqrt(pi);
pdeltas(4) = pdeltas(4) + Sampled2SigmaSwitchTwice(3) * sqrt(pi);
pdeltas(5) = pdeltas(5) + Sampled2SigmaSwitchTwice(4) * sqrt(pi);
pdeltas(6) = pdeltas(6) + Sampled2SigmaSwitchTwice(5) * sqrt(pi);


%Refresh Switch Twice and 3 sigma
%None

%Refresh Switch Twice and 2 sigma
%None

%Refresh Switch Three Times and 3 sigma
pdeltas = pdeltas + SampledRefresh3SigmaSwitchThreeTimes(1:7) * sqrt(pi);


%Refresh Switch Three Times and 2 sigma

pdeltas = pdeltas + SampledRefresh2SigmaSwitchThreeTimes(1:7) * sqrt(pi);

pdeltas(1) = pdeltas(1) + SampledRefresh2SigmaSwitchThreeTimes(8) * sqrt(pi);
qdeltas(1) = qdeltas(1) + SampledRefresh2SigmaSwitchThreeTimes(9) * sqrt(pi);

pdeltas(2) = pdeltas(2) + SampledRefresh2SigmaSwitchThreeTimes(10) * sqrt(pi);
qdeltas(2) = qdeltas(2) + SampledRefresh2SigmaSwitchThreeTimes(11) * sqrt(pi);

pdeltas(3) = pdeltas(3) + SampledRefresh2SigmaSwitchThreeTimes(12) * sqrt(pi);
pdeltas(3) = pdeltas(3) + SampledRefresh2SigmaSwitchThreeTimes(13) * sqrt(pi);
qdeltas(3) = qdeltas(3) + SampledRefresh2SigmaSwitchThreeTimes(14) * sqrt(pi);
qdeltas(3) = qdeltas(3) + SampledRefresh2SigmaSwitchThreeTimes(15) * sqrt(pi);

pdeltas(5) = pdeltas(5) + SampledRefresh2SigmaSwitchThreeTimes(16) * sqrt(pi);
qdeltas(5) = qdeltas(5) + SampledRefresh2SigmaSwitchThreeTimes(17) * sqrt(pi);

pdeltas(6) = pdeltas(6) + SampledRefresh2SigmaSwitchThreeTimes(18) * sqrt(pi);
qdeltas(6) = qdeltas(6) + SampledRefresh2SigmaSwitchThreeTimes(19) * sqrt(pi);

pdeltas(7) = pdeltas(7) + SampledRefresh2SigmaSwitchThreeTimes(20) * sqrt(pi);
pdeltas(7) = pdeltas(7) + SampledRefresh2SigmaSwitchThreeTimes(21) * sqrt(pi);
qdeltas(7) = qdeltas(7) + SampledRefresh2SigmaSwitchThreeTimes(22) * sqrt(pi);
qdeltas(7) = qdeltas(7) + SampledRefresh2SigmaSwitchThreeTimes(23) * sqrt(pi);


