%Abstract:
%This file tests our R_ConcatenatedEC_OuterLeaves function.
%Run the test by executing:
%   results = runtests('TEST_ConcatenatedEC_OuterLeaves.m');

tableSingleErr = [ 0, 0, 0, 1, 1, 1, 1; 0, 1, 1, 0, 0, 1, 1; 1, 0, 1, 0, 1, 0, 1]';

tableDoubleErr =  zeros(7,3,7);
for i = 1:7
   for j = 1:7
        tableDoubleErr(i,:,j) = mod(tableSingleErr(i,:) + tableSingleErr(j,:), 2);
   end
end

tableTripleErr =  zeros(7,7,7,3);
for i = 1:7
   for j = 1:7
       for l = 1:7
        tableTripleErr(i,j,l,:) = mod(tableSingleErr(i,:) + tableSingleErr(j,:)+ tableSingleErr(l,:), 2);
       end
   end
end


deltas1 = [2.456; -1.426; 0.003; 0.461; -0.343; 1.333; 4.000]
D = sqrt(pi);
deltas2 = deltas1 - D;


deltas3 = [0; 1.772; 1.772; 0; 0; 1.772; 1.772]

deltas4 = [1.772; 1.772; 1.772; 0; 0; 1.772; 1.772]


sigma = 0.527


%Test 1: To achieve the same error probability, a Gaussian distribution with a larger standard deviation requires a wider window.


[MultiqubitErrors1, Pcorrect1] = R_ConcatenatedEC_OuterLeaves(deltas1, sigma, tableSingleErr, tableDoubleErr, tableTripleErr)
[MultiqubitErrors2, Pcorrect2] = R_ConcatenatedEC_OuterLeaves(deltas2, sigma, tableSingleErr, tableDoubleErr, tableTripleErr)



%Test 2: To achieve a smaller error probability, a wider window is required.
vVec1 = R_Find_v(sigVec, 1e-6, vmax);
vVec2 = R_Find_v(sigVec, 1e-7, vmax);
assert(all(vVec1 < vVec2, 'all'))
