f1 = 0.9989873165286884;
f2 = 0.9954901435669022;
f2S = 0.9954901435669022;
f2P = 0.9856565055873818;
r2 = 0.9707735958042928;
f3 = 0.9927068828542052;
r1 = 0.9393716848403495;
f3P = 0.999999999999999;
f4 = 0.999953051552283;
f5 = 0.9982705524773533;
r3 = 0.9832339108307302;

Unprotect[Power];
Power[0, 0] = 0;
Protect[Power];

(*Step(c)*)
T1[dummy_] := Sum[Binomial[Floor[dummy/2], i] (f1)^i (1 - (f1))^(Floor[dummy/2] - i)*e[i], {i, 0, Floor[dummy/2] }] // Simplify;
MappingT1[dummy_] := dummy  /. {e -> T1} // Simplify;

(*Allocation1*)
A1[dummy_] := e[Floor[dummy/5], Floor[3 dummy/5], Floor[dummy/5] ]
MappingA1[dummy_] := dummy /. {e -> A1} // Simplify;

(*Step(d)*)
T2[dummy1_, dummy2_, dummy3_ ] := Sum[Binomial[Floor[dummy1/2], i] (f2)^i (1 - (f2))^(Floor[dummy1/2] - i)*e[i, dummy2, dummy3], {i, 0, Floor[dummy1/2] }] // Simplify;
MappingT2[dummy_] := dummy /. {e -> T2} // Simplify;

(*Step(dS)*)
T2S[dummy1_, dummy2_, dummy3_] := Sum[Binomial[Floor[dummy2/2], i] (f2S)^i (1 - (f2S))^(Floor[dummy2/2] - i)*e[dummy1, i , dummy3], {i, 0, Floor[dummy2/2] }] // Simplify;
MappingT2S[dummy_] := dummy   /. {e -> T2S} // Simplify;

(*Allocation2*)
A2[dummy1_, dummy2_, dummy3_] := e[dummy1, Floor[dummy2/3], Floor[2 dummy2/3], dummy3] // Simplify;
MappingA2[dummy_] := dummy /. {e -> A2} // Simplify;

(*Comparison1*)
C1[dummy1_, dummy2_, dummy3_, dummy4_] := e[dummy1, dummy2, Min[Floor[dummy3], Floor[dummy4]]] // Simplify;
MappingC1[dummy_] := dummy  /. {e -> C1} // Simplify;

(*Step(dP)*)
T2P[dummy1_, dummy2_, dummy3_] := Sum[Binomial[dummy3, i] (f2P)^i (1 - (f2P))^(dummy3 - i)*e[dummy1, dummy2, i], {i, 0, dummy3 }] // Simplify;
MappingT2P[dummy_] := dummy   /. {e -> T2P} // Simplify;

(*Comparison2*)
C2[dummy1_, dummy2_, dummy3_] := e[Min[Floor[dummy1], Floor[dummy2]], dummy3] // Simplify;
MappingC2[dummy_] := dummy  /. {e -> C2} // Simplify;

(*Step(e)*)
T3[dummy1_, dummy2_] := Sum[Binomial[dummy1, i] (f3)^i (1 - (f3))^(dummy1 - i)*e[i , dummy2], {i, 0, dummy1 }] // Simplify;
MappingT3[dummy_] := dummy   /. {e -> T3} // Simplify;

(*Step(r1)*)
R1[dummy1_, dummy2_] := Sum[Binomial[dummy1, i] (r1)^i (1 - (r1))^(dummy1 - i)*e[i, dummy2], {i, 0, dummy1 }] // Simplify;
MappingR1[dummy_] := dummy   /. {e -> R1} // Simplify;

(*Step(r2)*)
R2[dummy1_, dummy2_] := Sum[Binomial[dummy2, i] (r2)^i (1 - (r2))^(dummy2 - i)*e[dummy1, i], {i, 0, dummy2 }] // Simplify;
MappingR2[dummy_] := dummy   /. {e -> R2} // Simplify;

(*Step(eP)*)
T3P[dummy1_, dummy2_] := Sum[Binomial[Floor[dummy2/2], i] (f3P)^i (1 - (f3P))^(Floor[dummy2/2] - i)*e[dummy1, i], {i, 0, Floor[dummy2/2] }] // Simplify;
MappingT3P[dummy_] := dummy   /. {e -> T3P} // Simplify;

(*Comparison3*)
C3[dummy1_, dummy2_] := e[Min[Floor[dummy1], Floor[dummy2]]] // Simplify;
MappingC3[dummy_] := dummy  /. {e -> C3} // Simplify;

(*Step(f)*)
T4[dummy_] := Sum[Binomial[dummy, i] (f4)^i (1 - (f4))^(dummy - i)*e[i], {i, 0, dummy}] // Simplify;
MappingT4[dummy_] := dummy  /. {e -> T4} // Simplify;

(*Step(g)*)
T5[dummy_] := Sum[Binomial[Floor[dummy/2], i] (f5)^i (1 - (f5))^(Floor[dummy/2] - i)*e[i], {i, 0, Floor[dummy/2]}] // Simplify;
MappingT5[dummy_] := dummy  /. {e -> T5} // Simplify;

(*Step(r3)*)
R3[dummy_] := Sum[Binomial[dummy, i] (r3)^i (1 - (r3))^(dummy - i)*e[i], {i, 0, dummy }] // Simplify;
MappingR3[dummy_] := dummy   /. {e -> R3} // Simplify;

Off[General::stop]
Off[General::munfl]

req = Range[2, 40, 2];
Print["requirement_list = ", req];

start = 45;
end = 1035;
step = 45;
LSEG = 9; 

DistanceData = {};
Do[
 AppendTo[DistanceData, i],
 {i, start, end, step}
 ]
Print["distance_list = ", DistanceData]

extractProbabilities[expr_, minLen_ : 0] :=
  Module[{terms, rules, grouped, probList, maxIndex},
   If[NumericQ[expr], Return[ConstantArray[0, minLen]]];
   terms = Quiet[List @@ Expand[expr]];
   If[! ListQ[terms], terms = {expr}];
   rules = Reap[
      Do[Do[Module[{coeff = Coefficient[terms[[k]], e[n]]},
         If[coeff =!= 0, Sow[n -> coeff]]], {n, 0, 2000}], {k, Length[terms]}]][[2, 1]];
   If[rules === {} || ! MatchQ[rules, {(_ -> _) ...}],
    Return[ConstantArray[0, minLen]]];
   grouped = Association[rules];
   maxIndex = Max[Join[Keys[grouped], {minLen}]];
   probList = Table[Lookup[grouped, i, 0], {i, 0, maxIndex}];
   probList];

FindRequiredNoG1[val_, distance_, requirement_] :=
    Module[{low = 1, high = Length[G1List], mid, z, probList, w, OneRepeater, n, AR, init, AfterTransition},
           While[low < high, mid = Floor[(low + high)/2];
                 z = G1List[[mid]];
                 init = e[z];
                 AfterTransition = Composition[Simplify, MappingR3, MappingT5, MappingT4, MappingC3, MappingT3P, MappingR2, MappingR1, MappingT3, MappingC2, MappingT2P, MappingC1, MappingA2, MappingT2S, MappingT2, MappingA1, MappingT1][init] // Simplify;
                 probList = extractProbabilities[AfterTransition, requirement];
                 w = 1 - Accumulate[probList];
                 OneRepeater = w[[requirement]];
                 n = Ceiling[distance/LSEG];
                 AR = OneRepeater^n;
                 If[NumericQ[AR] && AR > val, high = mid, low = mid + 1];
            ];
           z = G1List[[low]];
           init = e[z];
           AfterTransition = Composition[Simplify, MappingR3, MappingT5, MappingT4, MappingC3, MappingT3P, MappingR2, MappingR1, MappingT3, MappingC2, MappingT2P, MappingC1, MappingA2, MappingT2S, MappingT2, MappingA1, MappingT1][init] // Simplify;
           probList = extractProbabilities[AfterTransition, requirement];
           w = 1 - Accumulate[probList];
           OneRepeater = w[[requirement]];
           n = Ceiling[distance/LSEG];
           AR = OneRepeater^n;
           If[NumericQ[AR] && AR > val,
              Print["Result: Number of G1-states = ", z, "___OneRepeater = ", OneRepeater, ",___AllRepeater = ", AR];
            z, Missing["NotFound"]]
    ];

three9data = Table[{}, {1}];
four9data  = Table[{}, {1}];

tic[] := (startTime = AbsoluteTime[]);

toc[] := Module[{elapsed = AbsoluteTime[] - startTime},
  With[{h = Floor[elapsed/3600],
        m = Floor[Mod[elapsed, 3600]/60],
        s = Mod[elapsed, 60]},
   Print[
    StringForm["Simulation duration: ``h ``m ``s``", h, m,
      NumberForm[s, {4, 2}]]
   ];
   elapsed
  ]
]

tic[];

Print["**********************************The simulation has started.**********************************"]

Print["**********************************k=17**********************************"]
G1List = Range[1751, 1951];

three9data[[1]] = Join @@ ParallelTable[FindRequiredNoG1[0.999, i, req[[17]]],{i, start, end, step}];
three9data[[1]] = List @@ three9data[[1]];
Print[">0.999 = ", three9data[[1]]]

four9data[[1]] = Join @@ ParallelTable[FindRequiredNoG1[0.9999, i, req[[17]]],{i, start, end, step}];
four9data[[1]] = List @@ four9data[[1]];
Print[">0.9999 = ", four9data[[1]]]

Print["**********************************Summary**********************************"]
three9Alldata = Table[Flatten[three9data[[i]]], {i, 1, Length[three9data]}];
four9Alldata  = Table[Flatten[four9data[[i]]],  {i, 1, Length[four9data]}];

Print["**********************************Export**********************************"]

dir = FileNameJoin[{"/home/rshiina_umass_edu/NoG1_vs_k_UW2", "NoG1_three9_vs_k_UW2_k=17"}];
If[! DirectoryQ[dir], CreateDirectory[dir]];
Do[col = Transpose[three9Alldata][[i]];
 Print["L_total = ", 45*i, ": ", col];
 Export[FileNameJoin[{dir, "NoG1_three9_vs_k_UW2_k=17_" <> ToString[45*i] <> "km.csv"}], col], {i, Length[First[three9Alldata]]}]

dir = FileNameJoin[{"/home/rshiina_umass_edu/NoG1_vs_k_UW2", "NoG1_four9_vs_k_UW2_k=17"}];
If[! DirectoryQ[dir], CreateDirectory[dir]];
Do[col = Transpose[four9Alldata][[i]];
 Print["L_total = ", 45*i, ": ", col];
 Export[FileNameJoin[{dir, "NoG1_four9_vs_k_UW2_k=17_" <> ToString[45*i] <> "km.csv"}], col], {i, Length[First[four9Alldata]]}]

Print["**********************************The simulation has finished.**********************************"]

toc[];
