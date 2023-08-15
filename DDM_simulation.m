% Implementing a DDM

%VARIABLES
coh = 1;
ter = 0.3;  %non-decision time in seconds (s)
a = 2.0;    %boundary 
z = 0.5;    %bias
k = 1;      %slope (drift rate)

%How can the following effect the model?

% Reward
% Inter-trial interval
% Error timeout

%Evidence
samples = 10;
right = randn(samples,1) + coh; %coh could be a sequence, then you just use this line
left =  randn(samples,1) - coh;

time = 1:samples;

figure
hold on;
subplot(1,2,1);
plot(time, right)
plot(time, left)
title('Evidence')
hold off;
subplot(1,2,2);
diffusion = cumsum(right);
plot(time, diffusion)
title('Decision Variable');


