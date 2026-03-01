function logErr = LP_InnerLeaves(L0, sigGKP, etas, etam, etad, etac, Lcavity, ErrProbVec)

%{

[Abstract]

This function outputs the simulated errors in the Z and X bases within a single segment, during (1) Construction of Elementary Entangled Bell Pairs and (2) Outer-Leaves Swapping.


[Inputs]

L0 — The distance between a repeater and its adjacent repeater, measured in kilometers [km]. Typically, we set L0 = 9.

sigGKP — The standard deviation of the Gaussian displacement noise applied to both the q and p quadratures of both qubits in the G0 states. Typically, we set sigGKP = 0.12.

etas — The efficiency of the optical switch applied to the remaining graph states after a measurement with discard windows. Typically, we set etas=0.995.

etam — The efficiency of mirror reflection per bounce. Typically, we set etam = 0.999995.

etad — The efficiency of a single homodyne detection. Typically, we set etad = 0.9975.

etac — The efficiency of a single connector between the photon fiber and the quantum chip. Typically, we set etac = 0.99.

Lcavity — The distance between successive bounces inside a mirror room or an optical cavity, measured in meters [m]. Typically, we set Lcavity = 2.

ErrProbVec — The output of the R_LogErrAfterPost function. It contains the bit-flip error probabilities for the 12 measurement types, which are made approximately equal by tuning the window sizes.


[Output]

logErr — A (k, 2) binary matrix. Each row corresponds to the i-th high-quality optical channel. The first column indicates the presence of a bit-flip error in the Z basis, and the second column indicates the presence of a bit-flip error in the X basis.
        Specifically:
            - [0, 0] means that neither Z nor X bit-flip errors occurred.
            - [1, 0] means that only a Z bit-flip error occurred.
            - [0, 1] means that only an X bit-flip error occurred.
            - [1, 1] means that both Z and X bit-flip errors occurred.

[Example]

ErrProbVec = 1.0e-05 *[0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.1479, 0.3341, 0.1479, 0.3341]

logErr = LP_InnerLeaves(5, 0.12, 0.995, 0.999995, 0.9975, 0.99, 2, ErrProbVec)

%}


%Note:
%The total length of local storage, such as a mirror room, is also L. This is because the outer qubits pass over L/2 [km] to reach a beamsplitter and the classical measurement result information comes back for the L/2 [km].

%We derive eta that is a total error probability during being stored in a mirror room.
%Since inner leaves have to wait for t[s] = 1000L[m] / (7/10)*c_vacuum[m/s] in a mirror room because light speed in a photon fiber is 30% slower than in vacuum. For the period, a photon bounces a wall t[s] * c_air[m/s] / Lcavity[m] times (We assumed c_air = c_vacuum).

eta = etam^(L0*1000*10/(Lcavity*7));


%We first create a lookup table to detect weight-1 bit-flip errors in the [[7, 1, 3]] code.
%Here, we take the transpose to make it easier to compare with the syndrome, which is a (1, 3) row vector.
tableSingleErr =    [ 0, 0, 0, 1, 1, 1, 1;
                      0, 1, 1, 0, 0, 1, 1;
                      1, 0, 1, 0, 1, 0, 1]';



%Next, we create a lookup table to detect weight-2 bit-flip errors, using the weight-1 lookup table.
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



%The binornd(n, p, A, B) function generates a (A, B) matrix of random numbers drawn from the binomial distribution with n trials and success probability p for each trial.
%Here, we set n = 1 and obtain a binary matrix, since each GKP qubit can be measured only once. We set A to the number of specified measurement types, and B to the multiplexing level k.




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





%Subsequently, we apply eta derived above, along with additional errors.
%Note that the final Elementary Entangled Bell Pairs are affected by a single optical switch and pass through four connectors from the factory to the detection center in a repeater, in addition to one more optical switch located at the detection center.
sigChannel = sqrt(2*sigGKP^2 + (1-etas^2*etac^4*eta*etad)/(etas^2*etac^4*eta*etad));
qdeltas = qdeltas + normrnd(0, sigChannel, 7, 1);
pdeltas = pdeltas + normrnd(0, sigChannel, 7, 1);




%Using the R_ConcatenatedEC_InnerLeaves function, we calculate the 7 binary bits resulting from [[7, 1, 3]] Steane error correction (if no error occurs, the result is a row vector of seven zeros) in the q-quadrature.
Zerrors = R_ConcatenatedEC_InnerLeaves(pdeltas, sigChannel, tableSingleErr, tableDoubleErr, tableTripleErr);



%Using the R_ConcatenatedEC_InnerLeaves function, we calculate the 7 binary bits resulting from [[7, 1, 3]] Steane error correction (if no error occurs, the result is a row vector of seven zeros) in the p-quadrature.
Xerrors = R_ConcatenatedEC_InnerLeaves(qdeltas, sigChannel, tableSingleErr, tableDoubleErr, tableTripleErr);





%We check whether an Z-error has occurred for each optical channel.
if any(Zerrors)
    Zerr = 1;
else
    Zerr = 0;
end


if any(Xerrors)
    Xerr = 1;
else
    Xerr = 0;
end




%Finally, we combine the two results above for each optical channel.
logErr = [Zerr,Xerr];
