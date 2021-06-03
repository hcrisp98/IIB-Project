# IIB-Project
Code and experimental data for the analysis of the collective Bernoulli-ball system


Real world data naming convention: T_fanPower_balloonWeights

Within each one are columns of X, Y, Z position for each balloon in m, e.g. [X Y Z X1 Y1 Z1] for two balloon system

one_balloon, two_balloons_empirical, two_balloons_springdamper, three_balloons and four_balloons are the simulink models of the system

optimiseBO and optimiseB2 are the Bayesian optimisation files for the one and two balloon models, sim_balloon and sim_2balloon are the corresponding cost functions

the parameter values for different models can be found in optimisationData
