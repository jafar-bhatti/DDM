% Implementing a DDM
a = 20;                                         % boundary
k = 0.3;                                        % drift rate
coh = linspace(-.5,.5,10);                      % coherence values (evidence)
trial_types = length(coh);                      % number of trial types
num_trials = 1000;                              % number of trials
RT = zeros(trial_types, num_trials);            % each row is different coherence
responses = zeros(trial_types, num_trials);     % each column is a different trial 


% Collect data (1000 trials) for each coherence value 
for i = 1:trial_types
    for j = 1:num_trials
        [dv, cnt, resp] = trial(coh(i), a, k);
        RT(i,j) = cnt;
        responses(i,j) = resp;
    end
end

% Compute reaction time and probabilities from collected data
meanRT = mean(RT, 2);
prob_right = sum(responses == 1, 2)/num_trials;

% Plot results 
figure
subplot(3,1,1)
plot(1:length(dv), cumsum(dv));
yline(a);
yline(a.*-1)
ylim([-1.5.*a,1.5.*a])
ylabel('Arbitrary units')
xlabel('Time (samples)')
title('Decision Variable (single-trial example)')
subplot(3,1,2)
plot(coh, meanRT,'-ko');
xlabel('Signed Coherence')
ylabel('RT in samples')
subplot(3,1,3)
plot(coh, prob_right,'-ko');
xlabel('Signed Coherence')
ylabel('Probability Right')
set(gcf,'position',[700,200,300,500])

%ACCUMULATE EVIDENCE OVER TIME UNTIL BOUNDARY CROSSED
function [dv, cnt, resp] = trial(coh, a, k)
dv = [];
cnt = 1;
resp = [];

while cnt < 10000
    if max(cumsum(dv)) >= a
        resp = 1;
        break
    elseif min(cumsum(dv)) <= a*-1
        resp = -1;
        break
    else 
        dv(cnt,1) = randn + (coh.*k);
        cnt = cnt + 1;
    end
end
end


