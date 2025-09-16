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
│   │   │       ├── R_ReminderMod.m
│   │   │       ├── R_SyndromeToErrorsOuter.m
│   │   │       └── R_JointErrorLikelihood.m
│   │   │           └── R_ErrorLikelihood.m
│   │   └── UW2_InnerLeave.m
│   │   │   ├── UW2_AddInitialLogErrors.m
│   │   │   └── R_BellMeasurementEC.m
│   │   │       ├── R_ReminderMod.m
│   │   │       ├── R_SyndromeToErrors.m
│   │   │       └── R_JointErrorLikelihood.m
│   │   │           └── R_ErrorLikelihood.m
│   │   ├── R_Find_v.m
│   │   └── R_LogErrAfterPost.m
│   ├── UW3_InnerAndOuterLeave.m
│   │   ├── UW3_OuterLeave.m
│   │   │   ├── UW3_AddInitialLogErrors.m
│   │   │   └── R_BellMeasurementECLikelihood.m
│   │   │       ├── R_ReminderMod.m
│   │   │       ├── R_SyndromeToErrorsOuter.m
│   │   │       └── R_JointErrorLikelihood.m
│   │   │           └── R_ErrorLikelihood.m
│   │   └── UW3_InnerLeave.m
│   │   │   ├── UW3_AddInitialLogErrors.m
│   │   │   └── R_BellMeasurementEC.m
│   │   │       ├── R_ReminderMod.m
│   │   │       ├── R_SyndromeToErrors.m
│   │   │       └── R_JointErrorLikelihood.m
│   │   │           └── R_ErrorLikelihood.m
│   │   ├── R_Find_v.m
│   │   └── R_LogErrAfterPost.m
│   ├── LP_Spool_InnerAndOuterLeave.m
│   │   ├── LP_OuterLeave.m
│   │   │   ├── LP_ReminderMod.m
│   │   │   └── LP_ErrorLikelihood.m
│   │   ├── LP_Spool_InnerLeave.m
│   │   │   ├── LP_AddInitialLogErrors.m
│   │   │   ├── LP_ChannelWithGKPCorr7QubitCode
│   │   │   │   └── LP_ReminderMod.m
│   │   │   └── LP_BellMeasurementEC.m
│   │   │       ├── LP_ReminderMod.m
│   │   │       ├── LP_SyndromeToErrors.m
│   │   │       └── LP_JointErrorLikelihood.m
│   │   │           └── LP_ErrorLikelihood.m
│   │   └── LP_LogErrAfterPost.m
│   └── LP_MR_InnerAndOuterLeave.m
│       ├── LP_OuterLeave.m
│       │   ├── LP_ReminderMod.m
│       │   └── LP_ErrorLikelihood.m
│       ├── LP_MR_InnerLeave.m
│       │   ├── LP_AddInitialLogErrors.m
│       │   ├── LP_ChannelWithGKPCorr7QubitCode
│       │   │   └── LP_ReminderMod.m
│       │   └── LP_BellMeasurementEC.m
│       │       ├── LP_ReminderMod.m
│       │       ├── LP_SyndromeToErrors.m
│       │       └── LP_JointErrorLikelihood.m
│       │           └── LP_ErrorLikelihood.m
│       └── LP_LogErrAfterPost.m
├── mathematica_simulation/
│   ├── NoG1_vs_Distance_UW2.m
│   ├── NoG1_vs_Distance_UW3.m
│   ├── NoG1_vs_Distance_LP.m
│   ├── NoG1_vs_k_UW2.m
│   └── NoG1_vs_k_UW3.m
├── matlab_simulation_outcomes/
│   ├── Rate_vs_Distance_UW2
│   ├── Rate_vs_Distance_UW3
│   ├── Rate_vs_Distance_LP_Spool
│   ├── Rate_vs_Distance_LP_MR
│   ├── Rate_vs_k_UW2
│   └── Rate_vs_k_UW3
├── mathematica_simulation_outcomes/
│   ├── NoG1_vs_Distance_UW2
│   ├── NoG1_vs_Distance_UW3
│   ├── NoG1_vs_Distance_LP
│   ├── NoG1_vs_k_UW2
│   └── NoG1_vs_k_UW3
├── LICENSE # MIT license for usage and redistribution
└── README.md

## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
