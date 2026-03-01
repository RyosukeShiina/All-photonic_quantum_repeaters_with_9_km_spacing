%Abstract:
%This file tests our R_ConcatenatedEC_OuterLeaves function.
%Run the test by executing:
%   results = runtests('TEST_ConcatenatedEC_OuterLeaves.m');

tableSingleErr = [ 0, 0, 0, 1, 1, 1, 1; ...
                   0, 1, 1, 0, 0, 1, 1; ...
                   1, 0, 1, 0, 1, 0, 1 ]';

tableDoubleErr = zeros(7,3,7);
for i = 1:7
    for j = 1:7
        tableDoubleErr(i,:,j) = mod(tableSingleErr(i,:) + tableSingleErr(j,:), 2);
    end
end

tableTripleErr = zeros(7,7,7,3);
for i = 1:7
    for j = 1:7
        for l = 1:7
            tableTripleErr(i,j,l,:) = mod(tableSingleErr(i,:) + tableSingleErr(j,:) + tableSingleErr(l,:), 2);
        end
    end
end

sigma = 0.527;
tol = 1e-12;


%MultiqubitErrors must be 7x1 binary
%Pcorrect must be finite number or -Inf, and must be <= 0 (since it's log2(max/total)) (max/total is in (0,1], so log2 is <=0).
check_output = @(E,P) assert( ...
                             isequal(size(E), [7,1]) && ...
                             all((E==0) | (E==1), 'all') && ...
                             ~isnan(P) && ...
                             (P <= tol) );

%Test 1: Invariance under adding 2*sqrt(pi) (does not change parity)
%ns = round(deltas/sqrt(pi)). Adding 2*sqrt(pi) shifts ns by +2 -> parity unchanged.
%ZmatrixPerfect = R_ReminderMod(deltas,sqrt(pi)) is periodic with period sqrt(pi), so unchanged as well.
%Therefore output should be identical.

deltas1 = [2.456; -1.426; 0.003; 0.461; -0.343; 1.333; 4.000];
deltas2 = deltas1 + 2*sqrt(pi);

[E1, P1] = R_ConcatenatedEC_OuterLeaves(deltas1, sigma, tableSingleErr, tableDoubleErr, tableTripleErr);
[E2, P2] = R_ConcatenatedEC_OuterLeaves(deltas2, sigma, tableSingleErr, tableDoubleErr, tableTripleErr);

check_output(E1, P1);
check_output(E2, P2);

assert(isequal(E1, E2));
assert(abs(P1 - P2) < 1e-10);


%Test 2: All-zero deltas -> no physical shift -> should decode to no error

deltas0 = zeros(7,1);

[E0, P0] = R_ConcatenatedEC_OuterLeaves(deltas0, sigma, tableSingleErr, tableDoubleErr, tableTripleErr);

check_output(E0, P0);
assert(isequal(E0, zeros(7,1)));
assert(P0 <= tol);
assert(P0 > -1);
                                                           


%Test 3: Weight-4 patterns listed as "not considered errors" must map to all-zero
                                                           
eps0 = 1e-9;
deltas3 = [0; sqrt(pi)-eps0; sqrt(pi)-eps0; 0; 0; sqrt(pi)-eps0; sqrt(pi)-eps0];
                                                           
[E3, P3] = R_ConcatenatedEC_OuterLeaves(deltas3, sigma, tableSingleErr, tableDoubleErr, tableTripleErr);
check_output(E3, P3);
assert(isequal(E3, zeros(7,1)));

                                                           

%Test 4: Output range sanity for Pcorrect. Pcorrect = maxErrProb - log2(sum(2.^ErrProb)) = log2(max/total) ∈ (-Inf, 0]

deltas4 = [0.12; -0.34; 0.56; -0.11; 0.22; -0.78; 0.01];

[E4, P4] = R_ConcatenatedEC_OuterLeaves(deltas4, sigma, tableSingleErr, tableDoubleErr, tableTripleErr);

check_output(E4, P4);

% Stronger check: must be <= 0
assert(P4 <= tol);
