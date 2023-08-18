coh = .5;
a = 20;
k = .3;
num_trials = 1000;
time_steps = 10000;
e = randn(num_trials, time_steps) + coh.*k;

% This might be all I need. Now, I can just do all of the calculations as I
% did before. 