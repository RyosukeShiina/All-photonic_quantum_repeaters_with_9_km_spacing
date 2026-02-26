req = {{}, {}, {}};
req[[1]] = 10;(*k=5*)
req[[2]] = 20;(*k=10*)
req[[3]] = 30;(*k=15*)

start = 9;
end = 1035;
step = 9;
LSEG = 9;  

DistanceData = {};
Do[
 AppendTo[DistanceData, i],
 {i, start, end, step}
 ]

f1 = 0.9989873165286884
f2 = 0.9954901435669022
f2P = 0.9977366682556823
f3 = 0.9925159766840489
r1 = 0.9259353783424354
f4 = 0.9999999999999999;
f5 = 0.9999882626814254
r2 = 0.9987274185432191

Unprotect[Power];
Power[0, 0] = 0;
Protect[Power];

(*Step(c)*)
T1[dummy_] := Sum[Binomial[Floor[dummy/2], i] (f1)^i (1 - (f1))^(Floor[dummy/2] - i)*e[i], {i, 0, Floor[dummy/2] }] // Simplify;
MappingT1[dummy_] := dummy  /. {e -> T1} // Simplify;

(*Allocation1*)
A1[dummy_] := e[Floor[dummy/2], Floor[dummy/2] ]
MappingA1[dummy_] := dummy /. {e -> A1} // Simplify;

(*Step(d)*)
T2[dummy1_, dummy2_ ] := Sum[Binomial[Floor[dummy1/2], i] (f2)^i (1 - (f2))^(Floor[dummy1/2] - i)*e[i, dummy2], {i, 0, Floor[dummy1/2] }] // Simplify;
MappingT2[dummy_] := dummy /. {e -> T2} // Simplify;

(*Step(dP)*)
T2P[dummy1_, dummy2_] := Sum[Binomial[Floor[dummy2/2], i] (f2P)^i (1 - (f2P))^(Floor[dummy2/2] - i)*e[dummy1, i], {i, 0, Floor[dummy2/2] }] // Simplify;
MappingT2P[dummy_] := dummy   /. {e -> T2P} // Simplify;

(*Comparison1*)
C1[dummy1_, dummy2_] := e[Min[Floor[dummy1], Floor[dummy2]]]
MappingC1[dummy_] := dummy  /. {e -> C1} // Simplify;

(*Step(e)*)
T3[dummy_] := Sum[Binomial[dummy, i] (f3)^i (1 - (f3))^(dummy - i)*e[i], {i, 0, dummy }] // Simplify;
MappingT3[dummy_] := dummy   /. {e -> T3} // Simplify;

(*Step(r1)*)
R1[dummy_] := Sum[Binomial[dummy, i] (r1)^i (1 - (r1))^(dummy - i)*e[i], {i, 0, dummy }] // Simplify ;
MappingR1[dummy_] := dummy   /. {e -> R1} // Simplify;

(*Step(f)*)
T4[dummy_] := Sum[Binomial[Floor[dummy/2], i] (f4)^i (1 - (f4))^(Floor[dummy/2] - i)*e[i], {i, 0, Floor[dummy/2]}] // Simplify;
MappingT4[dummy_] := dummy  /. {e -> T4} // Simplify;

(*Step(g)*)
T5[dummy_] := Sum[Binomial[Floor[dummy/2], i] (f5)^i (1 - (f5))^(Floor[dummy/2] - i)*e[i], {i, 0, Floor[dummy/2]}] // Simplify ;
MappingT5[dummy_] := dummy  /. {e -> T5} // Simplify;

(*Step(r2)*)
R2[dummy_] := Sum[Binomial[dummy, i] (r2)^i (1 - (r2))^(dummy - i)*e[i], {i, 0, dummy }] // Simplify ;
MappingR2[dummy_] := dummy   /. {e -> R2} // Simplify;

Off[General::stop]
Off[General::munfl]

three9data = {{}, {}, {}};
Print["three9data[1]=", three9data[[1]]];
Print["three9data[2]=", three9data[[2]]];
Print["three9data[3]=", three9data[[3]]];

four9data = {{}, {}, {}};
Print["four9data[1]=", four9data[[1]]];
Print["four9data[2]=", four9data[[2]]];
Print["four9data[3]=", four9data[[3]]];

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
                 AfterTransition = Composition[Simplify, MappingR2, MappingT5, MappingT4, MappingR1, MappingT3, MappingC1, MappingT2P, MappingT2, MappingA1, MappingT1][init] // Simplify;
                 probList = extractProbabilities[AfterTransition, requirement];
                 w = 1 - Accumulate[probList];
                 OneRepeater = w[[requirement]];
                 n = Ceiling[distance/LSEG];
                 AR = OneRepeater^n;
                 If[NumericQ[AR] && AR > val, high = mid, low = mid + 1];
            ];
           z = G1List[[low]];
           init = e[z];
           AfterTransition = Composition[Simplify, MappingR2, MappingT5, MappingT4, MappingR1, MappingT3, MappingC1, MappingT2P, MappingT2, MappingA1, MappingT1][init] // Simplify;
           probList = extractProbabilities[AfterTransition, requirement];
           w = 1 - Accumulate[probList];
           OneRepeater = w[[requirement]];
           n = Ceiling[distance/LSEG];
           AR = OneRepeater^n;
           If[NumericQ[AR] && AR > val,
              Print["Result: Number of G1-states = ", z, "___OneRepeater = ", OneRepeater, ",___AllRepeater = ", AR];
            z, Missing["NotFound"]]
    ];

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

Print["*****************1**********************"]
G1List = Range[401, 501];
three9data[[1]] = Join @@ ParallelTable[FindRequiredNoG1[0.999, i, req[[1]]], {i, start, end, step}]
df = List @@ three9data[[1]]
Export["/home/rshiina_umass_edu/NoG1_vs_Distance_UW3/NoG1_three9_vs_Distance_UW3_5.csv", Transpose@{df}, "CSV"]

Print["*****************2**********************"]
G1List = Range[401, 501];
four9data[[1]] = Join @@ ParallelTable[FindRequiredNoG1[0.9999, i, req[[1]]], {i, start, end, step}]
df = List @@ four9data[[1]]
Export["/home/rshiina_umass_edu/NoG1_vs_Distance_UW3/NoG1_four9_vs_Distance_UW3_5.csv", Transpose@{df}, "CSV"]

Print["*****************3**********************"]
G1List = Range[781, 901];
three9data[[2]] = Join @@ ParallelTable[FindRequiredNoG1[0.999, i, req[[2]]], {i, start, end, step}]
df = List @@ three9data[[2]]
Export["/home/rshiina_umass_edu/NoG1_vs_Distance_UW3/NoG1_three9_vs_Distance_UW3_10.csv", Transpose@{df}, "CSV"]

Print["*****************4**********************"]
G1List = Range[801, 901];
four9data[[2]] = Join @@ ParallelTable[FindRequiredNoG1[0.9999, i, req[[2]]], {i, start, end, step}]
df = List @@ four9data[[2]]
Export["/home/rshiina_umass_edu/NoG1_vs_Distance_UW3/NoG1_four9_vs_Distance_UW3_10.csv", Transpose@{df}, "CSV"]

Print["*****************5**********************"]
G1List = Range[1151, 1301];
three9data[[3]] = Join @@ ParallelTable[FindRequiredNoG1[0.999, i, req[[3]]], {i, start, end, step}]
df = List @@ three9data[[3]]
Export["/home/rshiina_umass_edu/NoG1_vs_Distance_UW3/NoG1_three9_vs_Distance_UW3_15.csv", Transpose@{df}, "CSV"]

Print["*****************6**********************"]
G1List = Range[1151, 1301];
four9data[[3]] = Join @@ ParallelTable[FindRequiredNoG1[0.9999, i, req[[3]]], {i, start, end, step}]
df = List @@ four9data[[3]]
Export["/home/rshiina_umass_edu/NoG1_vs_Distance_UW3/NoG1_four9_vs_Distance_UW3_15.csv", Transpose@{df}, "CSV"]

Print["**********************************The simulation has finished.**********************************"]

toc[];
