% Constants
coh = linspace(-.5,.5,10);                
a = 200;
b = a.*-1;
k = .1;
num_trial = 1000;
time_steps = 10000;
e = zeros(num_trial, time_steps, length(coh));

% Generate evidence for each coherence 
for i = 1:length(coh)
   e(:,:,i) = randn(num_trial, time_steps) + (coh(i).*k);
end

% Calculate the DV
dv = cumsum(e, 2);

%Plot sample DVs
figure
subplot(1,3,1)
plot(1:time_steps, dv(1,:,1))   %plot left coherence
ylim([b*1.5, a*1.5])
yline(a)
yline(b)
title('Coherence = -0.5')
xlabel('Time steps')
ylabel('DV (a.u.)')
subplot(1,3,2)
plot(1:time_steps, dv(1,:,10))  %plot right coherence
ylim([b*1.5, a*1.5])
yline(a)
yline(b)
title('Coherence = +0.5')
xlabel('Time steps')
ylabel('DV (a.u.)')
subplot(1,3,3)
plot(1:time_steps, dv(1,:,5))   %plot ambiguous coherence
ylim([b*1.5, a*1.5])
yline(a)
yline(b)
title('Coherence = -0.0556')
xlabel('Time steps')
ylabel('DV (a.u.)')
set(gcf,'position',[300,500,500,300])

% Determine responses and RTs
RT = zeros(num_trial, length(coh));
resp = zeros(num_trial, length(coh));
for i = 1:length(coh)
    for j = 1:num_trial
        if sum(dv(j, :, i) >= a) ~= 0                       %if theres a value greater than or equal to the threshold, get the RT
            RT(j,i) = find(dv(j, :, i) >= a, 1, 'first'); 
            resp(j,i) = 1;
        end
        if sum(dv(j, :, i) <= b) ~= 0                       %if theres a value less than or equal to the threshold, get the RT
            RT(j,i) = find(dv(j, :, i) <= b, 1, 'first');
            resp(j,i) = -1;
        end
        if sum(dv(j, :, i) >= a) == 0 && sum(dv(j, :, i) <= b) == 0  %if the dv doesnt reach EITHER bound, set RT as NaN and record it as a bad trial
            RT(j,i) = NaN;
            resp(j,i) = 0;
        end
    end
end

%Plot RT and resp (all trials)
meanRT = mean(RT, 'omitnan');
prob_right = sum(resp == 1, 1)./(sum(resp == 1, 1) + sum(resp == -1, 1));
figure,
subplot(1,2,1)
plot(coh, prob_right,'-ko');
xline(0);
yline(0.5);
title('Psychometric performance')
xlabel('Signed Coherence')
ylabel('Probability Right')
subplot(1,2,2)
plot(coh, meanRT)
title('Mean RT (all trials)')
xlabel('Signed Coherence')
ylabel('RT in samples')
set(gcf,'position',[850,500,500,300])

% Seperate left and right trials
leftRT = NaN(num_trial, length(coh));
rightRT = NaN(num_trial, length(coh));
for i = 1:length(coh)
   leftRT(resp(:, i) == -1, i) = RT(resp(:, i) == -1, i);
   rightRT(resp(:, i) == 1, i) = RT(resp(:, i) == 1, i);
end

%Seperate correct and incorrect trials
correctRT = NaN(num_trial, length(coh));
errorRT = NaN(num_trial, length(coh));
for i = 1:length(coh)
    if sign(coh(i)) == -1       %left trials 
        correctRT(resp(:, i) == -1, i) = RT(resp(:, i) == -1, i);
        errorRT(resp(:, i) == 1, i) = RT(resp(:, i) == 1, i);
    else                        %right trials
        correctRT(resp(:, i) == 1, i) = RT(resp(:, i) == 1, i);
        errorRT(resp(:, i) == -1, i) = RT(resp(:, i) == -1, i);            
    end
end

% Calculations
meanCorRT = mean(correctRT, 1, 'omitnan');
meanErRT = mean(errorRT, 1, 'omitnan');
meanleftRT = mean(leftRT, 1, 'omitnan');
meanrightRT = mean(rightRT, 1, 'omitnan');

% Plot 
figure
subplot(1, 2, 1)
hold on;
plot(coh, meanCorRT)
plot(coh, meanErRT)
xlabel('Signed coherence')
ylabel('RT (in samples)')
legend('Correct', 'Incorrect','Location','north')
hold off;
subplot(1, 2, 2)
hold on;
plot(coh, meanleftRT)
plot(coh, meanrightRT)
xlabel('Signed coherence')
ylabel('RT (in samples)')
legend('Left trials', 'Right trials','Location','north')
hold off;
set(gcf,'position',[300,100,500,300])

% Plot DV and RT distribution 
time_points = [1000, 5000, 9000];
coh_analyzed = 10;
dv_dist = zeros(num_trial, length(time_points));
for i = 1:length(time_points) 
    dv_dist(:,i) = dv(:, time_points(i), coh_analyzed);
end

figure
subplot(1,2,1)
hold on;
for i = 1:length(time_points)
    histogram(dv_dist(:,i))
end
hold off;
title('DV distribution - Coh = 0.5') 
legend('t = 1000', 't = 5000', 't = 9000')
xlabel('DV (a.u.)')
ylabel('Count')

% Plot RT distribution
subplot(1,2,2)
hold on;
histogram(RT(:,1))
histogram(RT(:,5))
histogram(RT(:,10))
hold off;
legend('coh = -0.5', 'coh = -0.0556', 'coh = +0.5')
title('RT distributions')
set(gcf,'position',[850,100,500,300])