function MultiqubitErrors = LP_SteaneEC(deltas, etaspool, sigGKP, etas, etad, etac, ZmatrixCh, tableSingleErr, tableDoubleErr, tableTripleErr)


ZmatrixPerfect = R_ReminderMod(deltas, sqrt(pi));
deltas = deltas - ZmatrixPerfect;

ns = round(deltas/sqrt(pi));



MultiqubitErrors = zeros(7,1);
for i = 1:7
    if mod(ns(i),2) == 1
        MultiqubitErrors(i) = 1;
    end
end

parityIIIPPPP = mod(sum(MultiqubitErrors(4:7)), 2);
parityIPPIIPP = mod(sum(MultiqubitErrors([2:3,6:7])), 2);
parityPIPIPIP = mod(sum(MultiqubitErrors([1,3,5,7])), 2);
parityVector = [parityIIIPPPP, parityIPPIIPP, parityPIPIPIP];
error_matrix = R_SyndromeToErrors(parityVector, tableSingleErr, tableDoubleErr, tableTripleErr);
    

matrix_size = size(error_matrix);
num_errs = matrix_size(1);


ErrProb = zeros(1, num_errs);

    


for k = 1:num_errs
    ErrProb(1,k) = LP_JointErrorLikelihood(error_matrix(k,:), ZmatrixCh, ZmatrixPerfect, etaspool, sigGKP, etas, etad, etac);
end


if isequal(error_matrix(1,:), zeros(1,7))
    ErrProbGrouped = [ErrProb(1,1), log2(sum(2.^ErrProb(1,2:end)))];
else
    ErrProbGrouped = [log2(2.^ErrProb(1,1) + sum(2.^ErrProb(1,5:8))), log2(sum(2.^ErrProb(1,2:4)))];
end

[maxErrProb,indmax] = max(ErrProbGrouped);

MultiqubitErrors = mod(MultiqubitErrors + transpose(error_matrix(indmax,:)),2);

if isequal(MultiqubitErrors, [0; 0; 0; 1; 1; 1; 1]) || isequal(MultiqubitErrors, [0; 1; 1; 0; 0; 1; 1])...
  || isequal(MultiqubitErrors, [1; 0; 1; 0; 1; 0; 1]) || isequal(MultiqubitErrors, [0; 1; 1; 1; 1; 0; 0])...
  || isequal(MultiqubitErrors, [1; 0; 1; 1; 0; 1; 0]) || isequal(MultiqubitErrors, [1; 1; 0; 0; 1; 1; 0])...
  || isequal(MultiqubitErrors, [1; 1; 0; 1; 0; 0; 1])

    MultiqubitErrors = zeros(7,1);
end
