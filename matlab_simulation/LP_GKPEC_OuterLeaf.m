function [QubitError, z] = LP_GKPEC_OuterLeaf(delta, sigma)

%{
[Abstract]
Single (bare) GKP decoding for LP outer-leaf.
- Hard-decision bit-flip error from lattice-parity (ns mod 2)
- Reliability log2 r = log2( max(ξ0, ξ1) / (ξ0+ξ1) )
  where ξ1 = z, ξ0 = 1-z, and z is from R_ErrorLikelihood.
%}

% 1) reduce to [-sqrt(pi)/2, sqrt(pi)/2]
x = R_ReminderMod(delta, sqrt(pi));

% 2) hard decision: nearest peak parity
delta_shift = delta - x;
ns = round(delta_shift / sqrt(pi));
QubitError = mod(ns, 2);   % 0: correct, 1: bit-flip

% 3) soft reliability using your existing likelihood function
%    z is the bit-flip likelihood given x
z = R_ErrorLikelihood(x, sigma);
z = min(max(z, 1e-15), 1-1e-15);  % guard
