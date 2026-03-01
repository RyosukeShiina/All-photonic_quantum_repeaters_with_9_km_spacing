function [qdeltas, pdeltas] = LP_AddInitialLogErrorsOuterLeaf(qdeltas, pdeltas, Sampled)


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
%None

%Now the uncorrelated errors

%Without switch
pdeltas = pdeltas + Sampled3Sigma(1) * sqrt(pi);

%With single switch and 3 sigma
%None


%With single switch and 2 sigma
pdeltas = pdeltas + Sampled2SigmaSwitch(1) * sqrt(pi);
pdeltas = pdeltas + SampledNoPost(1) * sqrt(pi); %%%%%v=0


%With Switch Twice and 3 Sigma
%None


%With Switch Twice and 2 Sigma
pdeltas = pdeltas + Sampled2SigmaSwitchTwice(1) * sqrt(pi);


%Refresh Switch Twice and 3 sigma
%None

%Refresh Switch Twice and 2 sigma
%None

%Refresh Switch Three Times and 3 sigma
pdeltas = pdeltas + SampledRefresh3SigmaSwitchThreeTimes(1) * sqrt(pi);


%Refresh Switch Three Times and 2 sigma

pdeltas = pdeltas + SampledRefresh2SigmaSwitchThreeTimes(1) * sqrt(pi);
