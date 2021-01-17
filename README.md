# adaptive_eq
-This repository includes implementations of RLS(Recursive Least Squares), LMS(Least Mean Squares) and a Monte Carlo simulation. Results are presented as SNR vs. BER plot.

NOTES

- When SNR is high, BER is always zero when pilot count is relatively high.
If pilot count is reduced, BER is no longer always zero. This justifies the
all-zero BER measurements.

- Refering to Adaptive Filter Theory, by Haykin; due to the
finite arithmetic nature of the computers, a more accurate claculation of
Kalman gain vector is achieved by introducing an extra variable, pi, to the
calculation. That is why Kalman gain vector is calculated with two steps.

- Instead of LMS algorithm, normalized LMS algorithm is used. Normalized LMS
algorithm normalizes the update term with respect to the observation vector.
This helps with stability and convergence performance of the algorithm.
