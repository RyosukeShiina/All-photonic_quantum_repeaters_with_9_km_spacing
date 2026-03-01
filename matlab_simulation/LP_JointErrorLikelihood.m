function joint_prob = LP_JointErrorLikelihood(error_vector, z_matrixCh, z_matrixPerfect, etaspool, sigGKP, etas, etad, etac)

joint_prob_temp = 0;
nqubit = length(error_vector);



sigChannelFirst = sqrt(2*sigGKP^2 + 1-etaspool*etas + (1 - etad*etac)/(etad*etac));
sigChannel = sqrt(2*sigGKP^2 + 1-etaspool + (1 - etad*etac)/(etad*etac));
sigChannelLastFull = sqrt(2*sigGKP^2 + (1-etaspool*etad*etas*etac^2)/(etaspool*etad*etas*etac^2));


                            
for qubit_index = 1:nqubit
     if(error_vector(qubit_index) == 1)
        joint_prob_temp = joint_prob_temp - 1 +  log2(1 - prod(1 - 2 * R_ErrorLikelihood(z_matrixCh(qubit_index, [1,(end/2) + 1]), sigChannelFirst)) ...
        *prod(1 - 2 * R_ErrorLikelihood(z_matrixCh(qubit_index,[2:end/2, (end/2) + 2:end]), sigChannel) ) ...
        * (1 - 2 * R_ErrorLikelihood(z_matrixPerfect(qubit_index,1), sigChannelLastFull) ) );
     else
        joint_prob_temp = joint_prob_temp - 1 +  log2(1 + prod(1 - 2 * R_ErrorLikelihood(z_matrixCh(qubit_index, [1,(end/2) + 1]), sigChannelFirst)) ...
        *prod(1 - 2 * R_ErrorLikelihood(z_matrixCh(qubit_index,[2:end/2, (end/2) + 2:end]), sigChannel) ) ...
        * (1 - 2 * R_ErrorLikelihood(z_matrixPerfect(qubit_index,1), sigChannelLastFull) ) );
    end
end

joint_prob = joint_prob_temp;
