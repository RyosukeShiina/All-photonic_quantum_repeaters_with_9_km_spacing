function [Zmatrix, DeltasOut] = LP_TEC_Spool(DeltasIn, etaspool, sigGKP, etas, etad, etac, n)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Zmatrix = zeros(7, n-1);

sigChannelFirst = sqrt(2*sigGKP^2 + 1-etaspool*etas + (1 - etad*etac)/(etad*etac));
sigChannel = sqrt(2*sigGKP^2 + 1-etaspool + (1 - etad*etac)/(etad*etac));
sigChannelLastHalf = sqrt(sigGKP^2 + (1-etaspool*etad*etas*etac^2)/(2*etaspool*etad*etas*etac^2));

a = sqrt(pi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

deltas_temp = DeltasIn;

deltas_temp = deltas_temp + sigChannelFirst * randn(7, 1);
Zmatrix(:,1) = R_ReminderMod(deltas_temp, a);
deltas_temp = deltas_temp - Zmatrix(:,1);

for j = 1:n-2
    deltas_temp = deltas_temp + sigChannel * randn(7, 1);
    Zmatrix(:,j+1) = R_ReminderMod(deltas_temp, a);
    deltas_temp = deltas_temp - Zmatrix(:,j+1);
end

deltas_temp = deltas_temp + sigChannelLastHalf * randn(7, 1);

DeltasOut = deltas_temp;
