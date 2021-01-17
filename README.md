# adaptive_eq
-This repository includes implementations of RLS(Recursive Least Squares) and LMS(Least Mean Squares).

--------------------------------------------------------------------------------------------------
NOTES---------------------------------------------------------------------------------------------
- When SNR is high, BER is always zero when pilot count is relatively high.
If pilot count is reduced, BER is no longer always zero. This justifies the
all-zero BER measurements.

- Refering to Adaptive Filter Theory, by Haykin; due to the
finite arithmetic nature of the computers, a more accurate claculation of
Kalman gain vector is achieved by introducing an extra variable, pi, to the
calculation. That is why Kalman gain vector is calculated with two steps.
