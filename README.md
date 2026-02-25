# Code for "All-photonic quantum repeaters with 9 km spacing"  
Author: Ryosuke Shiina
Affiliation: University of Massachusetts Amherst
Contact: rshiina@umass.edu

# Description
This repository contains the MATLAB, Mathematica, and Python code used to generate the results in our paper.

# For QCNC paper readers
This repository already contains simulation outputs used in the QCNC figures.
To reproduce QCNC figures from the provided data:
1. Go to `python_plotting/`
2. Open and run the following notebooks:
   - QCNC Fig. 3: `QCNC_camera-ready_FIG3_Rate_vs_Distance.ipynb`
   - QCNC Fig. 4: `QCNC_camera-ready_FIG4_Rate_vs_k.ipynb`
   - QCNC Fig. 5: `QCNC_camera-ready_FIG5_NoGKP_vs_Distance.ipynb`
   - QCNC Fig. 6: `QCNC_camera-ready_FIG6_Cost_vs_k.ipynb`
   - QCNC Fig. 7: `QCNC_camera-ready_FIG7_Rate_vs_Distance.ipynb`
   - QCNC Fig. 8: `QCNC_camera-ready_FIG8_etam_vs_Lcavity.ipynb`
The notebooks load data from `python_plotting/Fig_Data/`.
If you would like to regenerate the simulation outputs from scratch, please use the UW3 series.

# Folder Structure and Call Hierarchy
project-root/
├── matlab_simulation/
│   ├── UW2_InnerAndOuterLeave.m
│   │   ├── UW2_OuterLeave.m
│   │   │   ├── UW2_AddInitialLogErrors.m
│   │   │   └── R_ConcatenatedEC_OuterLeaves.m
│   │   │       ├── R_ReminderMod.m
│   │   │       ├── R_SyndromeToErrors.m
│   │   │       └── R_JointErrorLikelihood.m
│   │   │           └── R_ErrorLikelihood.m
│   │   ├── UW2_InnerLeave.m
│   │   │   ├── UW2_AddInitialLogErrors.m
│   │   │   └── R_ConcatenatedEC_InnerLeaves.m
│   │   │       ├── R_ReminderMod.m
│   │   │       ├── R_SyndromeToErrors.m
│   │   │       └── R_JointErrorLikelihood.m
│   │   │           └── R_ErrorLikelihood.m
│   │   ├── R_Find_v.m
│   │   └── R_LogErrAfterPost.m
│   ├── UW3_InnerAndOuterLeave.m
│   │   ├── UW3_OuterLeave.m
│   │   │   ├── UW3_AddInitialLogErrors.m
│   │   │   └── R_ConcatenatedEC_OuterLeaves.m
│   │   │       ├── R_ReminderMod.m
│   │   │       ├── R_SyndromeToErrors.m
│   │   │       └── R_JointErrorLikelihood.m
│   │   │           └── R_ErrorLikelihood.m
│   │   ├── UW3_InnerLeave.m
│   │   │   ├── UW3_AddInitialLogErrors.m
│   │   │   └── R_ConcatenatedEC_InnerLeaves.m
│   │   │       ├── R_ReminderMod.m
│   │   │       ├── R_SyndromeToErrors.m
│   │   │       └── R_JointErrorLikelihood.m
│   │   │           └── R_ErrorLikelihood.m
│   │   ├── R_Find_v.m
│   │   └── R_LogErrAfterPost.m
│   ├── ML_InnerAndOuterLeave.m (ML stands for memoryless)
│   │   ├── UW2_OuterLeave.m
│   │   │   ├── UW2_AddInitialLogErrors.m
│   │   │   └── R_ConcatenatedEC_OuterLeaves.m
│   │   │       ├── R_ReminderMod.m
│   │   │       ├── R_SyndromeToErrors.m
│   │   │       └── R_JointErrorLikelihood.m
│   │   │           └── R_ErrorLikelihood.m
│   │   ├── UW2_InnerLeave.m
│   │   │   ├── UW2_AddInitialLogErrors.m
│   │   │   └── R_ConcatenatedEC_InnerLeaves.m
│   │   │       ├── R_ReminderMod.m
│   │   │       ├── R_SyndromeToErrors.m
│   │   │       └── R_JointErrorLikelihood.m
│   │   │           └── R_ErrorLikelihood.m
│   │   ├── R_Find_v.m
│   │   └── R_LogErrAfterPost.m
│   ├── LP_InnerAndOuterLeave.m (LP stands for Logical-Physical)
│   │   ├── LP_OuterLeaf.m
│   │   │   ├── LP_AddInitialLogErrorsOuterLeaf.m
│   │   │   └── LP_GKPEC_OuterLeaf.m
│   │   │       ├── R_ReminderMod.m
│   │   │       └── R_ErrorLikelihood.m
│   │   ├── LP_InnerLeave.m
│   │   │   ├── LP_AddInitialLogErrorsInnerLeaves.m
│   │   │   └── R_ConcatenatedEC_InnerLeaves.m
│   │   │       ├── R_ReminderMod.m
│   │   │       ├── R_SyndromeToErrors.m
│   │   │       └── R_JointErrorLikelihood.m
│   │   │           └── R_ErrorLikelihood.m
│   │   ├── R_Find_v.m
│   │   └── R_LogErrAfterPost.m
│   └── LP_Spool_InnerAndOuterLeave.m
│       ├── LP_OuterLeaf.m
│       │   ├── LP_AddInitialLogErrorsOuterLeaf.m
│       │   └── LP_GKPEC_OuterLeaf.m
│       │       ├── R_ReminderMod.m
│       │       └── R_ErrorLikelihood.m
│       ├── LP_Spool_InnerLeave.m
│       │   ├── LP_AddInitialLogErrorsInnerLeaves.m
│       │   ├── LP_TEC_Spool.m
│       │   │   └── R_ReminderMod.m
│       │   └── LP_SteaneEC
│       │       ├── R_ReminderMod.m
│       │       ├── R_SyndromeToErrors.m
│       │       └── LP_JointErrorLikelihood.m
│       │           └── R_ErrorLikelihood.m
│       ├── R_Find_v.m
│       └── R_LogErrAfterPost.m
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
│   ├── Rate_vs_Distance_LP_ML
│   ├── Rate_vs_k_UW2
│   └── Rate_vs_k_UW3
├── mathematica_simulation_outcomes/
│   ├── NoG1_vs_Distance_UW2
│   ├── NoG1_vs_Distance_UW3
│   ├── NoG1_vs_Distance_LP
│   ├── NoG1_vs_k_UW2
│   └── NoG1_vs_k_UW3
├── python_plotting/
│   ├── QCNC_camera-ready_FIG3_Rate_vs_Distance.ipynb (QCNC_Fig 3)
│   ├── QCNC_camera-ready_FIG4_Rate_vs_k.ipynb (QCNC_Fig 4)
│   ├── QCNC_camera-ready_FIG5_NoGKP_vs_Distance.ipynb (QCNC_Fig 5)
│   ├── QCNC_camera-ready_FIG6_Cost_vs_k.ipynb (QCNC_Fig 6)
│   ├── QCNC_camera-ready_FIG7_Rate_vs_Distance.ipynb (QCNC_Fig 7)
│   ├── QCNC_camera-ready_FIG8_etam_vs_Lcavity.ipynb (QCNC_Fig 8)
│   └── Fig_Data
│       ├── Rate_vs_Distance_UW2_and_UW3
│       ├── Rate_vs_Distance_ML_and_LP
│       ├── Rate_vs_k
│       ├── NoG1_vs_Distance
│       └── NoG1_vs_k
├── LICENSE # MIT license for usage and redistribution
└── README.md

# License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
