# All-photonic_quantum_repeaters_with_9_km_spacing

# Code for "All-photonic quantum repeaters with 9 km spacing"  
Author: Ryosuke Shiina
Affiliation: University of Massachusetts, Amherst
Contact: rshiina@umass.edu

#　Description
This repository contains the Matlab and Mathematica code used to generate the results in our paper.

> **"All-photonic quantum repeaters with 9 km spacing"**,  
>  Ryosuke Shiina, [arXiv ID or DOI]  
> ([Link])

The code reproduces [Fig.1, Fig.2, Table I, etc.] and includes numerical simulations of [○○ model, GKP error correction, etc.].

---

## Folder Structure

project-root/
├── matlab_simulation/
│   ├── UW2_InnerAndOuterLeave.m
│   │   ├── UW2_OuterLeave.m
│   │   │   ├── UW2_AddInitialLogErrors.m
│   │   │   └── R_BellMeasurementECLikelihood.m
│   │   └── UW2_InnerLeave.m
│   │   │   ├── UW2_AddInitialLogErrors.m
│   │   │   └── R_BellMeasurementEC.m
│   │   ├── R_Find_v.m
│   │   └── R_LogErrAfterPost.m
│   ├── UW3_InnerAndOuterLeave.m
│   │   ├── UW3_OuterLeave.m
│   │   │   └── UW3_AddInitialLogErrors.m
│   │   └── UW3_InnerLeave.m
│   │   │   └── UW3_AddInitialLogErrors.m
│   │   ├── R_Find_v.m
│   │   └── R_LogErrAfterPost.m
│   └── utils/
│       └── plot_helper.m
├── mathematica_simulation/
├── LICENSE # MIT license for usage and redistribution
└── README.md

## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
