# Lab_HW_SW_CNN_Dogs_Cats_2026
Design and optimization of an accelerator for a CNN-based application to discriminate dogs and cats.

## Task 1 : Development of the basic accelerator and integration in the original application
In branch task1, you can find the application related to task1 of the midterm. 

Here is an example of the logs from the terminal when I run the CNN with cat.9495.jpg.rgba.planar:

```bash
OUTPUT: 0.06528854 --> CAT
Conv 0 --> 7138985085 ns (7.139 s)
Conv 1 --> 28851920889 ns (28.852 s)
Conv 2 --> 26136041872 ns (26.136 s)
Conv 3 --> 22524573687 ns (22.525 s)
Conv 4 --> 2064095277 ns (2.064 s)
MaxPool 0 --> 271936821 ns (0.272 s)
MaxPool 1 --> 125647969 ns (0.126 s)
MaxPool 2 --> 58885135 ns (0.059 s)
MaxPool 3 --> 25594326 ns (0.026 s)
MaxPool 4 --> 1187206 ns (0.001 s)
Dense 5 --> 269782885 ns (0.270 s)
Dense 6 --> 114702 ns (0.000 s)
Total Conv time: 86715616810 ns (86.716 s) 99.1 %
Total MaxPool time: 483251457 ns (0.483 s) 0.6 %
Total Dense time: 269897587 ns (0.270 s) 0.3 %
Total Flatten time: 433304 ns (0.000 s) 0.0 %
Total Sigmoid time: 124012 ns (0.000 s) 0.0 %
Total time: 87469323170 ns (87.469 s) 100.0 %
```

Memory utilization: 
| Execution Time | Frequency | LUT      | FF        | BRAM | DSP | Cost | Pareto? |
| :----------: | :-------: | :------: | :-------: | :----: | :----: | :----: | :----: |
|      87.469s |    100MHz | 8200     |   13122   | 12.5 | 50 | ?? |
