# Crowd-Behavior
## Modeling the Mechanics of Fleeing with the Individual Agent Model

###Summary

The following report seeks to analyze several simple crowd behavior models to explore how a group of people may evacuate a building under certain conditions. The simulations suggest that (1) a larger variance in reaction time can offset high mean reaction times and (2) a flow of people moving against the crowd can speed up evacuation so long as the size of their group, as a percentage of the whole group, does not exceed a certain threshold. 

###Contents

- [Report](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/Report.pdf)

###Code Appendix

- [re.m](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/re.m) and [re_trials.m](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/re_trials.m): implement the Random Escape Model
- [are.m](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/are.m) and [are_trials.m](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/are_trials.m): implement the Adaptive Escape Model
- [sdem.m](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/sdem.m) and [sdem_trials.m](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/sdem_trials.m): implement the Shortest Distance Escape Model
- [sdercf.m](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/sdercf.m) and [sdercf_trials.m](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/sdercf_trials.m): implement the Shortest Distance Escape Model with both Random Reaction and Counter Flow Models
- [sdercf2.m](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/sdercf2.m) and [sdercf2_trials.m](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/sdercf2_trials.m): implement the Shortest Distance Escape Model with both Stationary Reaction and Counter Flow Models
- [visualize.m](https://github.com/geoffstevens8/Crowd-Behavior/blob/master/visualize.m): dependency for other models to implement a visualization
