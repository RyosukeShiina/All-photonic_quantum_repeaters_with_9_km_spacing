function logErr = LP_OuterLeaves(L0, sigGKP, etas, etad, etac, k, ErrProbVec)

%{

[Abstract]

This function outputs the simulated errors in the Z and X bases within a single segment, during (1) Construction of Elementary Entangled Bell Pairs and (2) Outer-Leaves Swapping.


[Inputs]

L0 — The distance between a repeater and its adjacent repeater, measured in kilometers [km]. Typically, we set L0 = 9.

sigGKP — The standard deviation of the Gaussian displacement noise applied to both the q and p quadratures of both qubits in the G0 states. Typically, we set sigGKP = 0.12.

etas — The efficiency of the optical switch applied to the remaining graph states after a measurement with discard windows. Typically, we set etas=0.995.

etad — The efficiency of a single homodyne detection. Typically, we set etad = 0.9975.

etac — The efficiency of a single connector between the photon fiber and the quantum chip. Typically, we set etac = 0.99.

k — The number of multiplexing levels. For example, setting k = 15 results in the generation of 15 end-to-end entangled Bell pairs.

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

logErr = LP_OuterLeaves(9, 0.12, 0.995, 0.9975, 0.99, 15, ErrProbVec)

%}




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



%Each outer-Leaves undergoes 23 type 1 measurements during the construction of elementary entangled Bell pairs. 
%We prepare two outer-leaves for use in Outer-Leaves Swapping.
Sampled3Sigma = binornd(1,ErrProbVec(1),100,k);

%We do measurement type-2 22 times during the construction of logical-logical bell pairs.
Sampled3SigmaSwitch = binornd(1,ErrProbVec(2),100,k);
Sampled3SigmaSwitchTwice = binornd(1,ErrProbVec(3),100,k);
Sampled2SigmaSwitch = binornd(1,ErrProbVec(4),100,k);
Sampled2SigmaSwitchTwice = binornd(1,ErrProbVec(5),100,k);
SampledRefresh3SigmaSwitchTwice = binornd(1,ErrProbVec(6),100,k);
SampledRefresh3SigmaSwitchThreeTimes = binornd(1,ErrProbVec(7),100,k);
SampledRefresh2SigmaSwitchTwice = binornd(1,ErrProbVec(8),100,k);
SampledRefresh2SigmaSwitchThreeTimes = binornd(1,ErrProbVec(9),100,k);
SampledRefresh3SigmaSwitch = binornd(1,ErrProbVec(10),100,k);
SampledRefresh2SigmaSwitch = binornd(1,ErrProbVec(11),100,k);
SampledNoPost = binornd(1,ErrProbVec(12),100,k);



%We prepare two blank matrices to record the bit-flip errors in the Z and X bases during (1) Construction of Elementary Entangled Bell Pairs.
qdeltas = zeros(1,k);   %%%%%%%%%%%%%%%%CHANGED%%%%%%%%%%%%%%%%%%%
pdeltas = zeros(1,k);   %%%%%%%%%%%%%%%%CHANGED%%%%%%%%%%%%%%%%%%%



for i = 1:k
    Sampled1ithlevel = {Sampled3Sigma(1:end/2,i),Sampled3SigmaSwitch(1:end/2,i), Sampled3SigmaSwitchTwice(1:end/2,i), Sampled2SigmaSwitch(1:end/2,i), Sampled2SigmaSwitchTwice(1:end/2,i), SampledRefresh3SigmaSwitchTwice(1:end/2,i), SampledRefresh3SigmaSwitchThreeTimes(1:end/2,i), SampledRefresh2SigmaSwitchTwice(1:end/2,i), SampledRefresh2SigmaSwitchThreeTimes(1:end/2,i),SampledRefresh3SigmaSwitch(1:end/2,i), SampledRefresh2SigmaSwitch(1:end/2,i), SampledNoPost(1:end/2,i)};
    [qdeltas(:,i),pdeltas(:,i)] = LP_AddInitialLogErrorsOuterLeaf(qdeltas(:,i), pdeltas(:,i), Sampled1ithlevel);
    Sampled2ithlevel = {Sampled3Sigma(end/2 + 1:end,i), Sampled3SigmaSwitch(end/2 + 1:end,i), Sampled3SigmaSwitchTwice(end/2 + 1:end,i), Sampled2SigmaSwitch(end/2 + 1:end,i), Sampled2SigmaSwitchTwice(end/2 + 1:end,i), SampledRefresh3SigmaSwitchTwice(end/2 + 1:end,i), SampledRefresh3SigmaSwitchThreeTimes(end/2 + 1:end,i), SampledRefresh2SigmaSwitchTwice(end/2 + 1:end,i),SampledRefresh2SigmaSwitchThreeTimes(end/2 + 1:end,i),SampledRefresh3SigmaSwitch(end/2 + 1:end,i),SampledRefresh2SigmaSwitch(end/2 + 1:end,i), SampledNoPost(end/2 + 1:end,i)};
    [qdeltas(:,i),pdeltas(:,i)] = LP_AddInitialLogErrorsOuterLeaf(qdeltas(:,i), pdeltas(:,i), Sampled2ithlevel);
end



%Next, Hadamard gates are applied to the 5th, 6th, and 7th qubits to transform the graph state into a Bell pair.
%[qdeltas(5:7,:), pdeltas(5:7,:)] = deal(-pdeltas(5:7,:), qdeltas(5:7,:)); %%%%%%%%%%%%%%%%CHANGED%%%%%%%%%%%%%%%%%%%



%Subsequently, we apply eta derived above, along with additional errors.  
%Note that the final Elementary Entangled Bell Pairs are affected by a single optical switch and pass through four connectors from the factory to the detection center in a repeater.
Latt = 22;
eta = exp(-L0/(2*Latt));
sigChannel = sqrt(2*sigGKP^2 + (1-etas*etac*eta*etad)/(etas*etac*eta*etad));

qdeltas = qdeltas + normrnd(0, sigChannel, 1, k); %%%%%%%%%%%%%%%%CHANGED%%%%%%%%%%%%%%%%%%%
pdeltas = pdeltas + normrnd(0, sigChannel, 1, k); %%%%%%%%%%%%%%%%CHANGED%%%%%%%%%%%%%%%%%%%


%We prepare two blank column vectors to record final X-type and Z-type errors that occur during (2) Outer-Leaves Swapping.
Xerr = zeros(k,1);
Zerr = zeros(k,1);



qZVec = R_ReminderMod(qdeltas, sqrt(pi)); %%%%%%%%%%%%%%%%CHANGED%%%%%%%%%%%%%%%%%%%
qErrLike = R_ErrorLikelihood(qZVec, sigChannel); %%%%%%%%%%%%%%%%CHANGED%%%%%%%%%%%%%WHAT IS SIGQ?%%%%%%

pZVec = R_ReminderMod(pdeltas, sqrt(pi)); %%%%%%%%%%%%%%%%CHANGED%%%%%%%%%%%%%%%%%%%
pErrLike = R_ErrorLikelihood(pZVec, sigChannel); %%%%%%%%%%%%%%%%CHANGED%%%%%%%%%%%%WHAT IS SIGP?%%%%%%%

%PNoError = (1 - qErrLike).*(1 - pErrLike); %%%%%%%%%%%%%%%%CHANGED%%%%%%%%%%%%%%%%%%%





SecKeyRanking = zeros(size(pErrLike, 2), 1);

for i = 1:size(pErrLike, 2)
    SecKeyRanking(i) = R_SecretKey6State_per(pErrLike(i), qErrLike(i));
end



%We sort the capital Q (PNoError) values in descending order.
[~, IndDesc] = sort(SecKeyRanking, 'descend');



%We check whether an Z-error has occurred for each optical channel.
for i = 1:k
    ns = round((qdeltas(IndDesc(i)) - qZVec(IndDesc(i)))/sqrt(pi));
    
    if mod(ns,2) == 1
        Xerr(i) = 1;
    end
end

%Now check whether there were Z errors on the corresponding qubits
%in descening order according to PNoError:
for i = 1:k
    ns = round((pdeltas(IndDesc(i)) - pZVec(IndDesc(i)))/sqrt(pi));
    
    if mod(ns,2) == 1
        Zerr(i) = 1;
    end
end



%Finally, we combine the two results above for each optical channel.
logErr = [Zerr, Xerr];
