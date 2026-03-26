# Lab on hardware-software digital systems codesign - Midterm

## Task 1
## Task 2
## Task 3

| Name | Description | Time (ms) | Frequency (MHz) | LUTs | FFs | BRAMs | DSPs | Cost | Pareto? |
|------|-------------|-----------|-----------------|------|-----|-------|------|------|---------|
| SW | SW-only app on Pynq | x | x | n/a | n/a | n/a | n/a | 0 | Yes |
| Task 1 | Convolution HW, no optimization | x | x | x | x | x | x | x | x |
| Task 2 | Caching filter coefficients | x | x | x | x | x | x | x | x |
| Task 3 | Caching 3 input rows, multiplication + loop optimizations | 8551 | 100 | 10700 | 16155 | 29.5 | 70| 22.05 | x |
| Task 4 | 4 Filters calculated in parallel | 4441 | 100 | 13520 | 19105 | 43 | 169 | 37.73 | x |