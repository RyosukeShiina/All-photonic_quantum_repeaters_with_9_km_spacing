%Abstract:
%This file tests our R_SyndromeToErrors function.
%Run the test by executing:
%   results = runtests('TEST_SyndromeToErrors.m');

tableSingleErr =    [ 0, 0, 0, 1, 1, 1, 1;
                     0, 1, 1, 0, 0, 1, 1;
                     1, 0, 1, 0, 1, 0, 1]';
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

%Test1: Comparison with its expectation.

%For syndrome_vec = (0, 0, 1), since
%(0,  0,  1) indicates the 1st physical qubit got an error
%(0,  1,  0) indicates the 2nd physical qubit got an error 
%(0,  1,  1) indicates the 3rd physical qubit got an error 
%(1,  0,  0) indicates the 4th physical qubit got an error 
%(1,  0,  1) indicates the 5th physical qubit got an error 
%(1,  1,  0) indicates the 6th physical qubit got an error 
%(1,  1,  1) indicates the 7th physical qubit got an error
%and 
%(0,  1,  0) + (0,  1,  1) = (0,  0,  1) mod 2
%(1,  0,  0) + (1,  0,  1) = (0,  0,  1) mod 2
%(1,  1,  0) + (1,  1,  1) = (0,  0,  1) mod 2
%we can expect the 2nd and the 3rd, the 4th and the 5th, and the 6th and the 7th physical qubits will be included in the error candidate list. 

error = R_SyndromeToErrors([0, 1, 0], tableSingleErr, tableDoubleErr, tableTripleErr);
disp(error);

CheckMatrix = zeros(8,7);
CheckMatrix(1,:) = [0,1,0,0,0,0,0];
CheckMatrix(2,:) = [1,0,1,0,0,0,0];
CheckMatrix(3,:) = [0,0,0,1,0,1,0];
CheckMatrix(4,:) = [0,0,0,0,1,0,1];
CheckMatrix(5,:) = [1,0,0,1,0,0,1];
CheckMatrix(6,:) = [1,0,0,0,1,1,0];
CheckMatrix(7,:) = [0,0,1,1,1,0,0];
CheckMatrix(8,:) = [0,0,1,0,0,1,1];

assert(all(error == CheckMatrix, 'all'))
