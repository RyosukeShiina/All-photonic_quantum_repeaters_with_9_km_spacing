L = 9;
sigGKP = 0.12;
etas = 0.995;
etam = 0.999995;
etad = 0.9975;
etac = 0.99;
Lcavity = 2;
k = 0;
v = 0; 
leaves = 1;
N = 10000000;

xdata = [];
out_5 = [];
out_10 = [];
out_15 = [];
out_20 = [];

tic;
disp("*******The simulation has started.*******");
for i = 0:0.02:0.88
    disp("Starting loop v7=" + string(i))
    xdata = [xdata, i];
    out_5 = [out_5, UW3_InnerAndOuterLeaves(1, sigGKP, etas, etam, etad, etac, Lcavity, 5, i, leaves, N);];
    out_10 = [out_10, UW3_InnerAndOuterLeaves(1, sigGKP, etas, etam, etad, etac, Lcavity, 10, i, leaves, N);];
    out_15 = [out_15, UW3_InnerAndOuterLeaves(1, sigGKP, etas, etam, etad, etac, Lcavity, 15, i, leaves, N);];
    out_20 = [out_20, UW3_InnerAndOuterLeaves(1, sigGKP, etas, etam, etad, etac, Lcavity, 20, i, leaves, N);];
    disp("*******The loop has completed.*******")
end

writematrix(out_5, 'Perror_vs_v7_UW3_1km_5.csv');
writematrix(out_10, 'Perror_vs_v7_UW3_1km_10.csv');
writematrix(out_15, 'Perror_vs_v7_UW3_1km_15.csv');
writematrix(out_20, 'Perror_vs_v7_UW3_1km_20.csv');

disp("*******The simulation has finished.*******")
elapsedTime = toc;
fprintf('Simulation duration: %.3f seconds\n', elapsedTime);
