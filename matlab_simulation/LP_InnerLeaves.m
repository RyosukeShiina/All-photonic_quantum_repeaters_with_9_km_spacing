function logErr = UW3_InnerLeaves(L0, sigGKP, etas, etam, etad, etac, Lcavity, ErrProbVec)

%Abstract:
%This function outputs the error probabilities of a bit-flip error on the Z-basis and the X-basis happening during one inner leaf measurement inside one repeater.

%Inputs:
%L is a distance between a repeater and its neighboring repeater. The unit is [km]. Typically, we set L=9.
%sigGKP is a standard deviation used in your Gaussian function of GKP-coding. Typically, we set sigGKP=0.12.
%etas is an error probability that occurs when a graph-state passes through a switch. Typically, we set etas=0.995.
%etam is an error probability that occurs when a graph-state bounces back inside a mirror room. Typically, we set etas=0.999995.
%etad is an error probability that occurs when we detect a photon. Typically, we set etad=0.9975.
%etac is an error probability that occurs when a graph-state passes from a quantum chip to a fiber or from a fiber to a quantum chip. Typically, we set etac=0.99.
%Lcavity is the size of a mirror room. The unit is [m]. Typically, we set Lcavity=2.
%ErrProbVec is a result of our LogErrAfterPost-function. Since we have 10 different measurement types, we have 10 different error probabilities. ErrProbVec is a column vector having such 10 error probability values. This error probability is defined as bit-flip results out of all survival results of the window post-selection.

%Output:
%logErr is one of [0, 0], [0, 1], [1, 0] and [1, 1].
%[0, 0] means both Z and X bit-flip errors didn't happen.
%[1, 0] means only a Z bit-flip error happens.
%[0, 1] means only a X bit-flip error happens.
%[1, 1] means both Z and X bit-flip errors happened.


%Note:
%The total length of local storage, such as a mirror room, is also L. This is because the outer qubits pass over L/2 [km] to reach a beamsplitter and the classical measurement result information comes back for the L/2 [km].



%We derive eta that is a total error probability during being stored in a mirror room.
%Since inner leaves have to wait for t[s] = 1000L[m] / (7/10)*c_vacuum[m/s] in a mirror room because light speed in a photon fiber is 30% slower than in vacuum. For the period, a photon bounces a wall t[s] * c_air[m/s] / Lcavity[m] times (We assumed c_air = c_vacuum).
eta = etam^(L0*1000*10/(Lcavity*7));


%We define 2 look-up tables for the [[7, 1, 3]]-code.
%This first table is for detecting a single bit-flip error.
%Here, we transpose the look-up table. This is because this makes it easier to compare our result [a, b, c] (row vector) with [x, y, z] of the look-up table within our BellMeasurementEC-function.
tableSingleErr =    [ 0, 0, 0, 1, 1, 1, 1;
                      0, 1, 1, 0, 0, 1, 1;
                      1, 0, 1, 0, 1, 0, 1]';

%This second table is for detecting two bit-flip errors.
%Basically, we add up two row vectors (the ith-row and the j-th row) of the transposed matrix above.
tableDoubleErr =  zeros(7,3,7);
for i = 1:7
   for j = 1:7
        tableDoubleErr(i,:,j) = mod(tableSingleErr(i,:) + tableSingleErr(j,:), 2);
   end
end


%Similarly, we create a lookup table to detect weight-3 bit-flip errors, using the weight-1 lookup table.
tableTripleErr =  zeros(7,7,7,3);
for i = 1:7
   for j = 1:7
       for l = 1:7
        tableTripleErr(i,j,l,:) = mod(tableSingleErr(i,:) + tableSingleErr(j,:)+ tableSingleErr(l,:), 2);
       end
   end
end

%The binornd(n, p, a, 1)-function generates random numbers (a, 1)-column matrix from the binomial distribution specified by the trial numbers n (we set n=1 because we can measure each photon only once) and the probability of success for each trial p.
%We have 10 bit-flip error probabilities after post-selection that correspond to 10 measurement types.

%We do measurement type-1 46 times during the construction of logical-logical bell pairs.
Sampled3Sigma = binornd(1,ErrProbVec(1),100,1);

%We do measurement type-2 22 times during the construction of logical-logical bell pairs.
Sampled3SigmaSwitch = binornd(1,ErrProbVec(2),100,1);
Sampled3SigmaSwitchTwice = binornd(1,ErrProbVec(3),100,1);
Sampled2SigmaSwitch = binornd(1,ErrProbVec(4),100,1);
Sampled2SigmaSwitchTwice = binornd(1,ErrProbVec(5),100,1);
SampledRefresh3SigmaSwitchTwice = binornd(1,ErrProbVec(6),100,1);
SampledRefresh3SigmaSwitchThreeTimes = binornd(1,ErrProbVec(7),100,1);
SampledRefresh2SigmaSwitchTwice = binornd(1,ErrProbVec(8),100,1);
SampledRefresh2SigmaSwitchThreeTimes = binornd(1,ErrProbVec(9),100,1);
SampledRefresh3SigmaSwitch = binornd(1,ErrProbVec(10),100,1);
SampledRefresh2SigmaSwitch = binornd(1,ErrProbVec(11),100,1);
SampledNoPost = binornd(1,ErrProbVec(12),40,1);

%We are going to simulate two halves of a logical-logical bell pair. This means we separate a logical-logical bell pair into a left-part and right-part.
%Therefore, we separate the 10 column vectors above into the first half and the second half. And we store the first 10 columns vectors to Sampled1 and the second 10 column vectors to Sampled2.
Sampled1 = {Sampled3Sigma(1:end/2,1),Sampled3SigmaSwitch(1:end/2,1), Sampled3SigmaSwitchTwice(1:end/2,1), Sampled2SigmaSwitch(1:end/2,1), Sampled2SigmaSwitchTwice(1:end/2,1), SampledRefresh3SigmaSwitchTwice(1:end/2,1), SampledRefresh3SigmaSwitchThreeTimes(1:end/2,1), SampledRefresh2SigmaSwitchTwice(1:end/2,1), SampledRefresh2SigmaSwitchThreeTimes(1:end/2,1), SampledRefresh3SigmaSwitch(1:end/2,1), SampledRefresh2SigmaSwitch(1:end/2,1), SampledNoPost(1:end/2,1)};
Sampled2 = {Sampled3Sigma(end/2 + 1:end,1),Sampled3SigmaSwitch(end/2 + 1:end,1), Sampled3SigmaSwitchTwice(end/2 + 1:end,1), Sampled2SigmaSwitch(end/2 + 1:end,1), Sampled2SigmaSwitchTwice(end/2 + 1:end,1), SampledRefresh3SigmaSwitchTwice(end/2 + 1:end,1), SampledRefresh3SigmaSwitchThreeTimes(end/2 + 1:end,1), SampledRefresh2SigmaSwitchTwice(end/2 + 1:end,1),SampledRefresh2SigmaSwitchThreeTimes(end/2 + 1:end,1), SampledRefresh3SigmaSwitch(end/2 + 1:end,1), SampledRefresh2SigmaSwitch(end/2 + 1:end,1), SampledNoPost(end/2 + 1:end,1)};



%We simulate a half of a logical-logical bell pair.
%We set an initial shift error, which just afeter step (b), as zero.
qdeltas = zeros(7,1);
pdeltas = zeros(7,1);


%Using the Sampled1 and Sampled2 above and our AddInitialLogErrors-function, we consider all of the correlated errors and add sqrt(pi) for them, which happen during our logical-logical bell pair construction.
[qdeltas, pdeltas] = LP_AddInitialLogErrorsInnerLeaves(qdeltas, pdeltas, Sampled1);
[qdeltas, pdeltas] = LP_AddInitialLogErrorsInnerLeaves(qdeltas, pdeltas, Sampled2);


%We have to apply a H-gate before an XX-measurement. We swap a q-value shift error and a p-value shift error according to the formulas: H(-p)H^{dagger} = q and HqH^{dagger} = p.
%We used a deal-function. This is the same as qdeltas(1:4)=-pdeltas(1:4) and pdeltas(1:4)=qdeltas(1:4)
[qdeltas(1:4), pdeltas(1:4)] = deal(-pdeltas(1:4), qdeltas(1:4));

%Since inner leaves pass through two switches, four connectors, a mirror room, and a detector, our logical results are affected by the following modified sigma.
sigChannel = sqrt(2*sigGKP^2 + (1-etas^2*etac^4*eta*etad)/(etas^2*etac^4*eta*etad));

%Because of the sigChannel above, each inner leaf's Δq = σ^2 + (1-etas)/etas & Δp = σ^2 + (1-etas)/etas are changed to below.
qdeltas = qdeltas + normrnd(0, sigChannel,7,1);
pdeltas = pdeltas + normrnd(0, sigChannel,7,1);

%Our BellMeasurementEC-function simulates the Bell measurements for qubits which are encoded with GKP-coding and [[7, 1, 3]] Steane-coding.
%This function outputs a 7-elements column vector, for example, [0; 0; 0; 0; 0; 0; 1]. Here, 0 means it is correct, and 1 means it contains a bit-flip error.
%First, we use the BellMeasurementEC-function to simulate Z-basis bit-flip errors with pdeltas.
Zerrors = R_ConcatenatedEC_InnerLeaves(pdeltas, sigChannel, tableSingleErr, tableDoubleErr, tableTripleErr);

%If there is 1 among the output, e.g. [0; 0; 0; 0; 0; 0; 1], we consider the result to have an error.
if any(Zerrors)
    Zerr = 1;
else
    %If our output is [0; 0; 0; 0; 0; 0; 0], we consider the result to have no error.
    Zerr = 0;
end

%Next, we use the BellMeasurementEC-function to simulate X-basis bit-flip errors with qdeltas.
Xerrors = R_ConcatenatedEC_InnerLeaves(qdeltas, sigChannel, tableSingleErr, tableDoubleErr, tableTripleErr);

if any(Xerrors)
    Xerr = 1;
else
    Xerr = 0;
end

%logErr is one of [0, 0], [0, 1], [1, 0] and [1, 1].
%[0, 0] means both Z and X bit-flip errors didn't happen.
%[1, 0] means only a Z bit-flip error happens.
%[0, 1] means only a X bit-flip error happens.
%[1, 1] means both Z and X bit-flip errors happened.
logErr = [Zerr,Xerr];
