# BPU.scala

The **Branch Prediction Unit (BPU)** predicts the control flow of the program.

## Overview
It integrates multiple predictors to provide high-accuracy predictions for branch direction and target addresses.

## Predictor Hierarchy
- **Fast Predictors**: Provide low-latency predictions (e.g., uBTB).
- **Accurate Predictors**: Provide higher accuracy with more latency (e.g., Tage, ITTage, SC).
- **Composer**: A module that selects and combines results from different predictors.

## Key Structures
- `Predictor`: The top-level BPU implementation.
- `BasePredictor`: An abstract class for all predictor implementations.
- `AllFoldedHistories`: Manages global history information used by various predictors.
