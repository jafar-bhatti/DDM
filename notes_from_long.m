% Notes from Long
%
% 1. In my simulation, I set an arbitrary cut off point for the decsion
%    process (10,000 steps). I did this initially because I didn't want the
%    program to run indefinitely if the DV doesn't approach a boundary. In
%    my model, I would say that if a bound is not reached in 10,000 trials,
%    then I would label it a "bad trial". 
%           - Is this refected in behavior? When a monkey fails to make a
%           decsion, does the neural correlates refect a DDM that also
%           fails to reach a boundary?
% 
%2. In my model, I think that error trials will have a higher RT than
%   correct trials. However, I think in real life, error trials will have
%   much great variability than correct trials. For example, in one error
%   trial, a monkey may have a strong desire for the reward and therefore
%   makes his decision quicker and therefore sacrifice accuracy. I can also
%   see cases where the monkey has a lapse in attention and waits until the
%   last minute before the trial ends (this seems less likely to me, so
%   maybe the answer is that in real life, the monkey has shorter RT)
%
%08/29
% - Plot distribution of DV (distributation over time - sample different time points)
% - distribution of RTs (for a given coherence) 
% 
% - Long made a comment about making a 2D matrix that has data from all
% coherences. She suggesed that the assigned row number be calculated from
% the coherence value and num_trial, row_num = num_trials * coh; this
% doesnt make that much sense to me. 1) coherence isnt an integer and
% 2)this would allow for repeats. I might try 3D matrix or a
% list of matrices 
%
%
%
%
%